#!/bin/bash
# Install requirements as documeted here (https://github.com/phpbrew/phpbrew/wiki/Requirement)
sudo apt install -y \
  build-essential \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  libcurl4-gnutls-dev \
  libzip-dev \
  libssl-dev \
  libxml2-dev \
  libxslt-dev \
  php8.1-cli \
  php8.1-bz2 \
  php8.1-xml \
  pkg-config \
  libonig-dev
  
# Install php brew as documented here (https://github.com/phpbrew/phpbrew?tab=readme-ov-file#installation)
#
curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
chmod +x phpbrew.phar

# Move the file to some directory within your $PATH
sudo mv phpbrew.phar /usr/local/bin/phpbrew


phpbrew init
