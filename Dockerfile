FROM ubuntu:14.04
MAINTAINER Richard Willis <willis.rh@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV PHP_ENV development

# Manually set the apache environment variables in order to get apache
# to work immediately.
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# Install app dependencies
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
  openssh-server supervisor \
  vim curl wget \
  bash-completion build-essential python-software-properties \
  git \
  postfix mailutils \
  apache2 \
  php5 php5-curl

# Install composer
#WORKDIR /var/www
#RUN curl -sS https://getcomposer.org/installer | php

# Install composer components
# RUN /var/www/composer.phar install --prefer-source --no-interaction --working-dir /var/www

# Setup apache
RUN ln -s /var/www/apache/app.local.conf /etc/apache2/sites-enabled/

RUN mkdir /var/run/sshd
RUN mkdir -p /var/log/supervisor

RUN echo 'root:pass' | chpasswd
RUN sed --in-place=.bak 's/without-password/yes/' /etc/ssh/sshd_config

ADD ./app /var/www
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22 80
CMD ["/usr/bin/supervisord"]