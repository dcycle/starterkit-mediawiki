Dcycle Mediawiki Starterkit
-----

This project uses Docker and Docker Compose to set up a fully working Wiki based on [Mediawiki](https://www.mediawiki.org/wiki/MediaWiki).

[![CircleCI](https://circleci.com/gh/dcycle/starterkit-mediawiki/tree/master.svg?style=svg)](https://circleci.com/gh/dcycle/starterkit-mediawiki/tree/master)

Quick start
-----

Start by making sure you have Docker and Docker Compose installed and running on your computer or on a Linux server. This has been tested on Intel-based mac OS and on Ubuntu, not on Windows.

Run the following:

    ./scripts/deploy.sh

And follow instructions therein.

Once installed, you can edit and create new pages as per the MediaWiki documentation you will find online.

Stopping the environment
-----

If you want to **destroy all your data**, run:

    ./scripts/destroy.sh

If you want to keep your data for next time, run:

    docker-compose down

Uploading your logo, or other files
-----

If you want to upload files:

* Make sure there is an unversioned file called LocalSettings.php at the root of your local directory.
* Edit that file and make sure it says "$wgEnableUploads = true;" (it will be false by default)
* Log in to your wiki and go to http://0.0.0.0:8080/index.php/Special:Upload
* Upload your logo, and on the resulting page open the image in a separate tab, note its URL, which will look like http://0.0.0.0:8080/images/6/6e/Logo.jpg
* Edit LocalSettings.php again and change the line '$wgLogos = [ '1x' => "$wgResourceBasePath/resources/assets/wiki.png" ];' to, in this example, '$wgLogos = [ '1x' => "/images/6/6e/Logo.jpg" ];'.
* Empty your browser cache, or try in a different browser you haven't used before, and you'll see your logo!

Installing extensions
-----

This starterkit provides a single extension, [EmbedVideo](https://www.mediawiki.org/wiki/Extension:EmbedVideo#Installation), but you can use its installation as a template to install your own extensions.

Extensions are installed in the Dockerfile, and you will probably need to modify that in your own fork or copy of this repo.

Custom code
-----

Custom code is stored in ./mediawiki/CustomExtension, and is loaded in ./docker-resources/load-extensions.php.

Our custom code was created based on https://www.mediawiki.org/wiki/Manual:Developing_extensions and does the following:

* Adds a statistic using a "Words in all content pages" section to the Special:Statistics page.

(https://www.mediawiki.org/wiki/Extension:CirrusSearch does the same thing but needs a connection to an ElasticSearch server, so this approach might work for simpler needs.)

Errors and PHP logs
-----

Errors and notices will not be displayed on screen. To see the error logs you can run:

    tail ./do-not-commit/php-log.log

LetsEncrypt
-----

If you would like to use LetsEncrypt to host your wiki on a secure HTTPS protocol:

#### First, deploy as normal

    ./scripts/deploy.sh

#### Second, edit the unversioned .env file at the root of your project on your production Docker host, adding the following

    # .env
    ...
    VIRTUAL_HOST=example.com
    LETSENCRYPT_HOST=example.com
    LETSENCRYPT_EMAIL=admin@example.com

#### Third, deploy again

    ./scripts/deploy.sh

#### Finally, set up Letsencrypt

Follow the instructions in the following blog posts:

* [Letsencrypt HTTPS for Drupal on Docker, October 03, 2017, Dcycle Blog](https://blog.dcycle.com/blog/170a6078/letsencrypt-drupal-docker/)
* [Deploying Letsencrypt with Docker-Compose, October 06, 2017, Dcycle Blog](https://blog.dcycle.com/blog/7f3ea9e1/letsencrypt-docker-compose/)

Debugging
-----

You might want to turn off OpCache during development:

    docker-compose exec mediawiki /bin/bash

Once logged in run:

    echo 'opcache.enable=0' >> /usr/local/etc/php/php.ini

You might also want to add these lines to the beginning of your LocalSettings.php file within your container:

    apt-get update && apt-get install -y vim
    vi LocalSettings.php

Then add these lines at the very beginning after the `<?php` tag:

    error_reporting( -1 );
    ini_set( 'display_errors', 1 );

Then exit and run:

    docker-compose restart mediawiki

Making a backup and restoring from a backup
-----

    ./scripts/make-backup.sh

Backups are stored in ./do-not-commit/backups

To restore from a backup, run:

    ./scripts/revert-from-backup.sh

Using the database from the command line
-----

    docker-compose exec database /bin/bash
    ...
    mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD"
    ...
    use my_wiki

You can now perform database operations.

You are encouraged to create a backup before fiddling with the database (see above).

Getting a database from a remote environment
-----

You must start by defining the remote environment, for example "stage", by copying the example (dummy) environment information, and putting in your real environment information. Something like:

    cp ./scripts/remote/environments/example ./scripts/remote/environments/stage

Then modify the file ./scripts/remote/environments/fr/info.source.sh with the stage environment information.

Now, every time you want to fetch the data from your stage environment, you would run:

    ./scripts/get-database-from-remote.sh stage

Troubleshooting
-----

### "Sending build context to Docker daemon" takes forever

You might want to delete unused backups from the ./do-not-commit/backups directory.

Resources
-----

* [MediaWiki Docker image](https://hub.docker.com/_/mediawiki)
