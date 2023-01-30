<?php

namespace CustomExtension;

use CustomExtension\JobScheduler\JobScheduler;

/**
 * All CustomExtension's external hooks.
 */
class Hooks {

	public static function onSpecialStatsAddExtra( &$extraStats, $context ) {
		$extraStats['dcycle-mediawiki-starterkit-article-words'] = '123';
		// Schedule a job to update this number
		$scheduler = new JobScheduler();
		$scheduler->schedule();
	}

	public static function onMultiContentSave( \MediaWiki\Revision\RenderedRevision $renderedRevision, \MediaWiki\User\UserIdentity $user, \CommentStoreComment $summary, $flags, \Status $hookStatus ) {
		$id = $renderedRevision->getRevision()->getId();
		if (!$renderedRevision->isContentDeleted()) {
			$outputObject = $renderedRevision->getRevisionParserOutput();
			if ($outputObject) {
				$text = strip_tags($outputObject->getDisplayTitle()) . ' ' . strip_tags($outputObject->getRawText());
				error_log('There are ' . str_word_count($text) . ' in id ' . $id . ';', 3, "/var/tmp/my-errors.log");
				return;
			}
		}
		error_log('deleting id ' . $id . ';', 3, "/var/tmp/my-errors.log");
	}

}
