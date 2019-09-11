FROM debian:buster-slim

MAINTAINER Nikita Tarasov <nikita@mygento.ru>

ENV GIN_MODE=release

RUN apt-get -qq update && apt-get -qqy upgrade && \
    apt-get -qqy install wget gnupg1 sudo && \
    wget -qO - https://www.aptly.info/pubkey.txt | sudo apt-key add - && \
    sh -c 'echo "deb http://repo.aptly.info/ squeeze main" >> /etc/apt/sources.list.d/aptly.list' && \
    apt-get -qq update && apt-get -qqy install aptly

CMD aptly api serve
