#
# Initial setup instructions.
#
echo ''
echo '* Go to http://0.0.0.0:8080/mw-config/index.php'
echo '* Go through the installation procedure'
echo '* When prompted for database connection details enter:'
echo ''
echo '    Database host: database'
echo '    Database name: my_wiki'
echo '    Database table prefix: [LEAVE EMPTY]'
echo '    Database username: wikiuser'
echo "    Database password: $MYSQL_PASSWORD"
echo ''
echo '* When prompted for "Database account for web access", leave "Use the same account as for installation" checked'
echo '* Enter a name for your wiki, and an initial username and password.'
echo '* When done, the LocalSettings.php file will be automatically downloaded'
echo '* Add it to root of the Git repo; note that it will not be version controlled'
echo '* Run ./scripts/deploy.sh'
