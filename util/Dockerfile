# to check for latest version run "just check-docker"
FROM python:3.9.23-bullseye
RUN apt-get install git
COPY requirements.txt /srv/requirements.txt
RUN pip install -r /srv/requirements.txt
COPY ./src /srv/utils
WORKDIR /srv/utils

CMD ["sh"]