<?php

namespace CustomExtension\Job;

/**
 * Job to update the word count.
 */
class UpdateWordCount extends \Job {

	public function __construct( $params ) {
		parent::__construct( 'customExtensionUpdateWordCount', $params );
	}

	/**
	 * @return bool
	 * @throws \MWException
	 */
	public function run() {
		print_r('Doing job' . PHP_EOL);
		return TRUE;
	}

}
