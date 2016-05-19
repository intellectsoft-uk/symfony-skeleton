#!/usr/bin/env bash

set -e

# Disable xdebug in production environment
xdebug_config=/usr/local/etc/php/conf.d/xdebug.ini
if [ -f $xdebug_config ] && [ "$SYMFONY_ENV" == "prod" ]; then
    rm $xdebug_config
else
    usermod -u "${USER_ID:=1000}" www-data
fi

su -m -s /bin/bash -c 'cd /srv; support/php/prepare.sh' - www-data

php-fpm
