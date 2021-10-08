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

Resources
-----

* [MediaWiki Docker image](https://hub.docker.com/_/mediawiki)
