FROM python:3.7.3-stretch
RUN apt-get install git
COPY requirements.txt ./
COPY ./src /srv/utils
WORKDIR /srv/utils
RUN pip install --editable .

CMD ["sh"]