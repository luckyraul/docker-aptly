FROM debian:trixie-slim

LABEL maintainer="Nikita Tarasov <nikita@mygento.com>"

ENV GIN_MODE=release

RUN echo 'deb http://deb.debian.org/debian trixie-backports main' > /etc/apt/sources.list.d/backports.list
RUN apt-get -qq update && \
    apt-get -qqy upgrade && \
    apt-get -qqy install aptly gosu && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8080

VOLUME ["/var/lib/aptly"]

ENV GNUPGHOME="/var/lib/aptly/.gnupg"

RUN mkdir -p /var/lib/aptly/.gnupg && \ 
    chmod 700 /var/lib/aptly/.gnupg && \
    chown -R www-data:www-data /var/lib/aptly/.gnupg

COPY aptly.conf /etc/aptly.conf

USER www-data
CMD ["aptly", "api", "serve", "-listen=:8080", "-no-lock"]
WORKDIR /opt/aptly