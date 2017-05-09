FROM python:2.7

ENV GIT_REPO https://github.com/defcyy/RatticWeb.git

RUN apt-get update && apt install -y libldap2-dev libsasl2-dev && pip install uwsgi

RUN mkdir /opt/mattricweb && \
    git clone $GIT_REPO /opt/mattricweb && \
    chmod +x /opt/mattricweb/docker-entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/opt/mattricweb/docker-entrypoint.sh"]