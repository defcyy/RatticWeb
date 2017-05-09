#!/bin/bash
set -e

WORK_DIR=${WORK_DIR:=/opt/ratticweb}
PROCESSES_NUM=${PROCESSES_NUM:=4}
SECRET_KEY=${SECRET_KEY:=FFEB9031-1A1B-4F72-ADC4-119D1ECEBE52}
DEBUG=${DEBUG:=false}
HOSTNAME=${HOSTNAME:=localhost}
MYSQL_USER=${MYSQL_USER:=ratticweb}
MYSQL_PASSWORD=${MYSQL_PASSWORD:=ratticweb}
MYSQL_HOST=${MYSQL_HOST:=127.0.0.1}
MYSQL_PORT=${MYSQL_PORT:=3306}
MYSQL_DB=${MYSQL_DB:=ratticdb}

cat > /etc/ratticweb.cfg << EOF
[ratticweb]
secretkey = ${SECRET_KEY}
debug = ${DEBUG}
hostname = ${HOSTNAME}

[database]
user = ${MYSQL_USER}
password = ${MYSQL_PASSWORD}
host = ${MYSQL_HOST}
port = ${MYSQL_PORT}
engine = django.db.backends.mysql
name = ${MYSQL_DB}

[filepaths]
media = /var/ratticweb/media
static = /var/ratticweb/static
EOF

id -u ratticweb &> /dev/null || ratticweb
[ -d /var/ratticweb ] || mkdir -p /var/ratticweb/{media,static}
chown -R ratticweb /var/ratticweb

cd $WORK_DIR
python manage.py syncdb --settings=ratticweb.settings
python manage.py migrate --settings=ratticweb.settings
python manage.py collectstatic --settings=ratticweb.settings --noinput

uwsgi --http 0.0.0.0:8000 --chdir $WORK_DIR --module ratticweb.wsgi:application --uid ratticweb --master --processes $PROCESSES_NUM