Starterkit Wiki
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

Uploading your logo, or other files
-----

If you want to upload files:

* Make sure there is an unversioned file called LocalSettings.php at the root of your local directory.
* Edit that file and make sure it says "$wgEnableUploads = true;" (it will be false by default)
* Log in to your wiki and go to http://0.0.0.0:8080/index.php/Special:Upload
* Upload your logo, and on the resulting page open the image in a separate tab, note its URL, which will look like http://0.0.0.0:8080/images/6/6e/Logo.jpg
* Edit LocalSettings.php again and change the line '$wgLogos = [ '1x' => "$wgResourceBasePath/resources/assets/wiki.png" ];' to, in this example, '$wgLogos = [ '1x' => "/images/6/6e/Logo.jpg" ];'.
* Empty your browser cache, or try in a different browser you haven't used before, and you'll see your logo!

Resources
-----

* [MediaWiki Docker image](https://hub.docker.com/_/mediawiki)
