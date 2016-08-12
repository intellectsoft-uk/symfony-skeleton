#!/usr/bin/env bash

set -ef

conf="/etc/nginx/conf.d"
ssl_cert="/certs/domain.crt"
if [ -f $ssl_cert ]; then
    cp "$conf/default-ssl.conf.tpl" "$conf/default.conf"
else
    cp "$conf/default.conf.tpl" "$conf/default.conf"
fi

nginx -g 'daemon off;'
