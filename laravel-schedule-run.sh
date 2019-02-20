#!/bin/sh

test -f /app/artisan && /usr/bin/php /app/artisan schedule:run
