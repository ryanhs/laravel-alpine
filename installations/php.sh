#!/bin/sh

# install
apk add \
    php7 php7-phar php7-json php7-iconv php7-openssl \
    php7-apache2

# Add Composer
curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# php modules part 1
apk add \
	php7-ftp \
	php7-xdebug \
	php7-mcrypt \
	php7-mbstring \
	php7-soap \
	php7-gmp \
	php7-pdo_odbc \
	php7-dom \
	php7-pdo \
	php7-zip \
	php7-mysqli \
	php7-sqlite3 \
	php7-pdo_pgsql \
	php7-bcmath \
	php7-gd \
	php7-odbc \
	php7-pdo_mysql \
	php7-pdo_sqlite \
	php7-gettext \
	php7-xmlreader \
	php7-xmlwriter \
	php7-tokenizer \
	php7-xmlrpc \
	php7-bz2 \
	php7-pdo_dblib \
	php7-curl \
	php7-ctype \
	php7-session \
	php7-redis \
	php7-exif

# php modules part 2, separated installations
apk add php7-simplexml php7-fileinfo php7-pcntl php7-posix

# add php as default /usr/bin/php
cp /usr/bin/php7 /usr/bin/php

# add laravel schedule:run to cron
echo "* * * * * /docker/laravel-schedule-run.sh" | tee -a /etc/crontabs/apache
chmod 644 /etc/crontabs/apache

# if artisan not provided,
echo '<?php echo date("Y-m-d H:i:s").PHP_EOL; var_dump($argv);' | tee /app/artisan
