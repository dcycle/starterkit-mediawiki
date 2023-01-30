<?php

namespace CustomExtension;

use CustomExtension\JobScheduler\JobScheduler;
use MediaWiki\MediaWikiServices;

/**
 * All CustomExtension's external hooks.
 */
class Hooks {

	const TABLE = 'CustomExtensionWordCount';

	public static function readConnection() {
		// https://www.mediawiki.org/wiki/Manual:Database_access
		return self::connection(DB_REPLICA);
	}

	public static function writeConnection() {
		return self::connection(DB_PRIMARY);
	}

	public static function connection($type) {
		$lb = MediaWikiServices::getInstance()->getDBLoadBalancer();
		$dbr = $lb->getConnectionRef( DB_REPLICA );

		try {
			$dbr->query('select 1 from `' . self::TABLE . '` LIMIT 1');
		}
		catch (\Throwable $t) {
			$dbw = $lb->getConnectionRef( DB_PRIMARY );
			$dbw->query("CREATE TABLE " . self::TABLE . " (
				title VARCHAR(30) NOT NULL PRIMARY KEY,
				words VARCHAR(30) NOT NULL
			)");
		}

		return $lb->getConnectionRef($type);
	}

	public static function updateWordCount(string $title, int $words) {
		$resultSet = self::readConnection()
			->newSelectQueryBuilder()
			->select(['words'])
			->from(self::TABLE)
			->where(['title' => $title])
			->fetchField();

		if ($resultSet === FALSE) {
			self::writeConnection()
				->insert(self::TABLE, [
					'title' => $title,
					'words' => $words,
				]);
		}
		else {
			self::writeConnection()
				->update(self::TABLE, ['words' => $words], ['title' => $title]);
		}
	}

	public static function onSpecialStatsAddExtra( &$extraStats, $context ) {
		$extraStats['dcycle-mediawiki-starterkit-article-words'] = self::countTotalWords();
	}

	public static function countTotalWords() : string {
		try {
			$resultSet = self::readConnection()
				->newSelectQueryBuilder()
				->select(['words'])
				->from(self::TABLE)
				->fetchResultSet();

			$return = 0;

			// I know, there is a better way of doing this but I cannot find it...
			while ($result = $resultSet->fetchRow()) {
				$return += $result['words'];
			}

			return $return;
		}
		catch (\Throwable $t) {
			return $this->throwableToString();
		}
	}

	// The PageSaveComplete hook does not seem to get called.
	// https://stackoverflow.com/questions/75289566/in-mediawiki-how-do-i-get-the-pagesavecomplete-to-execute

	public static function onMultiContentSave( \MediaWiki\Revision\RenderedRevision $renderedRevision, \MediaWiki\User\UserIdentity $user, \CommentStoreComment $summary, $flags, \Status $hookStatus ) {
		try {
			$outputObject = $renderedRevision->getRevisionParserOutput();
			$title = strip_tags($outputObject->getDisplayTitle());
			$words = str_word_count($title . ' ' . strip_tags($outputObject->getRawText()));
			self::updateWordCount($title, $words);
		}
		catch (\Throwable $t) {
			self::logThrowable($t);
		}
	}

	public static function logThrowable(\Throwable $t) {
		self::log(self::throwableToString($t));
	}

	public static function log(string $text) {
		error_log($text . PHP_EOL, 3, "/var/tmp/my-errors.log");
	}

	public static function throwableToString(\Throwable $t) : string {
		return $t->getMessage() . ' ' . $t->getFile() . ':' . $t->getLine() . PHP_EOL;
	}

}
