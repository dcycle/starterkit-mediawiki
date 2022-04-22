FROM mediawiki

COPY docker-resources /docker-resources
COPY starter-data /starter-data

RUN /docker-resources/docker-setup-script.sh
