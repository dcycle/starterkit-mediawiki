FROM mediawiki

COPY docker-resources /docker-resources

RUN /docker-resources/docker-setup-script.sh

#
# This is how to install an extension; we are using EmbedVideo as an example,
# use this as a template to install your own extensions in your fork or
# copy of this project.
#
# You must also add the line "include('/load-extensions.php');" to your
# unversioned copy of LocalSettings.php once your wiki is set up.
#
# https://www.mediawiki.org/wiki/Extension:EmbedVideo#Installation
RUN curl -O https://gitlab.com/hydrawiki/extensions/EmbedVideo/-/archive/v2.9.0/EmbedVideo-v2.9.0.zip && \
  mv EmbedVideo* extensions/ && \
  cd extensions && \
  unzip EmbedVideo* && \
  rm EmbedVideo*zip && \
  mv EmbedVideo* EmbedVideo && \
  echo "wfLoadExtension( 'EmbedVideo' );" >> /load-extensions.php

#### Enter your own extensions based on the above template below this line.
# Your own extensions.
#### Enter your own extensions based on the above template above this line.
