#!/bin/sh

/docker/configs/auto-timezone.sh
/docker/configs/auto-apache2.sh
/docker/configs/auto-php-config.sh

echo "starting supervisor"
exec supervisord -c /etc/supervisord.conf
