<?php

namespace CustomExtension\JobScheduler;

use CustomExtension\Job\UpdateWordCount;
use MediaWiki\MediaWikiServices;

/**
 * Used to schedule a job to be run.
 */
class JobScheduler {

  /**
   * Schedule our word count update job.
   *
   * See https://www.mediawiki.org/wiki/Manual:Job_queue/For_developers.
   */
  public function schedule() {
    $job = new UpdateWordCount([]);
    MediaWikiServices::getInstance()
      ->getJobQueueGroup()
      ->push($job);

    // MediaWikiServices::getInstance()
    //   ->getJobQueueGroupFactory()
    //   ->makeJobQueueGroup()
    //   ->push($job);
  }

}
