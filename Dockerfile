FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN rm -f /var/www/html/index.html

WORKDIR /var/www/html

COPY html/ /var/www/html/

EXPOSE 80

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]