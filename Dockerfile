FROM debian:bookworm-slim

MAINTAINER Nikita Tarasov <nikita@mygento.com>

ENV GIN_MODE=release

RUN apt-get -qq update && \
    apt-get -qqy upgrade && \
    apt-get -qqy install aptly

EXPOSE 8080

VOLUME ["/var/lib/aptly"]

COPY aptly.conf /etc/aptly.conf
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD aptly api serve
