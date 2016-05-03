FROM php:7.0-fpm

RUN apt-get update && \
    apt-get install -y libmcrypt-dev libpq-dev netcat && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
        mcrypt \
        bcmath \
        mbstring \
        zip \
        opcache \
        pdo pdo_pgsql

RUN yes | pecl install xdebug-beta \
        && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini

COPY support/php/fpm_www.conf /usr/local/etc/php-fpm.d/www.conf

COPY vendor /srv/vendor
COPY bin /srv/bin
COPY var /srv/var
COPY app /srv/app
COPY src /srv/src
COPY app.php boot.sh /srv/

WORKDIR /srv

CMD ["bash", "boot.sh"]
