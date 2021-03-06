RatticWeb
=========

Build Status: [![Build Status](https://travis-ci.org/tildaslash/RatticWeb.png?branch=master)](https://travis-ci.org/tildaslash/RatticWeb)

RatticWeb is the website part of the Rattic password management solution, which allows you to easily manage your users and passwords.

If you decide to use RatticWeb you should take the following into account:
* The webpage should be served over HTTPS only, apart from a redirect from normal HTTP.
* The filesystem in which the database is stored should be protected with encryption.
* The access logs should be protected.
* The machine which serves RatticWeb should be protected from access.
* Tools like <a href=="http://www.ossec.net/">OSSEC</a> are your friend.

Support and Known Issues:
* Through <a href="http://twitter.com/RatticDB">twitter</a> or <a href="https://github.com/tildaslash/RatticWeb/issues?state=open">Github Issues</a>
* Apache config needs to have "WSGIPassAuthorization On" for the API keys to work  

Dev Setup: <https://github.com/tildaslash/RatticWeb/wiki/Development>


Build docker image

`docker build -t ratticweb .`


Run with docker

environment variables

`SECRET_KEY`

`DEBUG` django server debug mode default false

`HOSTNAME` hostname for django server allowed hosts

`MYSQL_HOST` mysql database host default localhost

`MYSQL_PORT` mysql database port default 3306

`MYSQL_USER` mysql database user default ratticweb

`MYSQL_PASSWORD` mysql database password default ratticweb

`MYSQL_DB` mysql database name default ratticdb