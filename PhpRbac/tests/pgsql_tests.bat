@ECHO OFF
php "%~dp0phpunit.phar" -c phpunit_pgsql.xml %*
PAUSE