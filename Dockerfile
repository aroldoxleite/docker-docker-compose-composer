FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install curl wget php5-cli unzip -y

#instalando composer
RUN curl -s https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

#instalando docker-compose
ARG compose_version=1.10.0
RUN curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)"
RUN chmod +x /usr/local/bin/docker-compose

#instalando docker
RUN wget -qO- https://get.docker.com/ | sh
RUN usermod -aG docker $(whoami)

RUN docker --version
RUN docker-compose --version
RUN composer --version
