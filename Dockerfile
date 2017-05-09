FROM python:2.7

ENV GIT_REPO https://github.com/defcyy/RatticWeb.git
ENV WORK_DIR /opt/mattricweb

RUN apt-get update && apt-get install -y libldap2-dev libsasl2-dev && pip install uwsgi

RUN mkdir -p $WORK_DIR && git clone $GIT_REPO $WORK_DIR
WORKDIR $WORK_DIR

RUN pip install -r requirements-base.txt && \
    pip install -r requirements-mysql.txt && \
    chmod +x docker-entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["./docker-entrypoint.sh"]