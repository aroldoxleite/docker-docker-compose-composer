FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
  && apt-get install -y git curl wget php-cli php-curl php-mbstring unzip sudo

#instalando composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

#instalando docker-compose
ARG COMPOSE_VERSION=1.11.2
RUN curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)"
RUN chmod +x /usr/local/bin/docker-compose

#instalando docker
RUN wget -qO- https://get.docker.com/ | sh
RUN usermod -aG docker $(whoami)

# Ferramentas NodeJS
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - \
  && apt-get install -y nodejs
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - \
   && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
   && sudo apt-get update \
   && sudo apt-get install -y yarn
RUN npm install -g bower

RUN composer global require hirak/prestissimo

RUN docker --version \
  && docker-compose --version \
  && composer --version \
  && php --version
