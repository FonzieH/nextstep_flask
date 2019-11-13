FROM python:3.7-alpine
ENV FLASK_APP flask.py
ENV FLASK_CONFIG docker

RUN adduser -D flasky
USER flasky

WORKDIR /home/flasky

COPY requirements requirements

RUN python -m venv venv
ADD pip.conf /home/flasky/.pip/pip.conf
RUN venv/bin/pip3 install -r requirements/docker.txt --timeout 99999

COPY app app
COPY migrations migrations
ADD flasky.py config.py boot.sh export.sh ./

# Config while running
EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
