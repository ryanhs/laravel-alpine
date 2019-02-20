#!/bin/sh

# install
apk add apache2

# Add apache to /run and configure
mkdir -p /run/apache2
sed -i "s/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/" /etc/apache2/httpd.conf
sed -i "s/#LoadModule\ session_module/LoadModule\ session_module/" /etc/apache2/httpd.conf
sed -i "s/#LoadModule\ session_cookie_module/LoadModule\ session_cookie_module/" /etc/apache2/httpd.conf
sed -i "s/#LoadModule\ session_crypto_module/LoadModule\ session_crypto_module/" /etc/apache2/httpd.conf
sed -i "s/#LoadModule\ deflate_module/LoadModule\ deflate_module/" /etc/apache2/httpd.conf
sed -i "s#^DocumentRoot \".*#DocumentRoot \"/app/public\"#g" /etc/apache2/httpd.conf
sed -i "s#/var/www/localhost/htdocs#/app/public#" /etc/apache2/httpd.conf
printf "\n<Directory \"/app/public\">\n\tAllowOverride All\n</Directory>\n" >> /etc/apache2/httpd.conf

# setup app directory
mkdir -p /app/public
chown -R apache:apache /app
chmod -R 755 /app
echo 'It works!' | tee /app/public/index.html
echo '<?php phpinfo();' | tee /app/public/info.php

# add to supervisord
echo | tee -a /etc/supervisord.conf
echo "[program:apache2]" | tee -a /etc/supervisord.conf
echo "command=/usr/sbin/httpd -D FOREGROUND" | tee -a /etc/supervisord.conf
echo "stdout_logfile=/dev/stdout" | tee -a /etc/supervisord.conf
echo "stdout_logfile_maxbytes=0" | tee -a /etc/supervisord.conf
echo "stdout_events_enabled=true" | tee -a /etc/supervisord.conf
echo "stderr_events_enabled=true" | tee -a /etc/supervisord.conf
echo | tee -a /etc/supervisord.conf
