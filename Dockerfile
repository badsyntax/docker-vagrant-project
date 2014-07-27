FROM      ubuntu
MAINTAINER Richard Willis <willis.rh@gmail.com>

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y apache2 openssh-server

RUN "chmod +x ./start.sh"

ENV PHP_ENV development

EXPOSE 5900
EXPOSE 80
CMD    ["./start.sh"]