server {
    listen 80;
    listen [::]:80;

    return         301 https://$server_name$request_uri;
}

server {

    listen 443 ssl;

    ssl on;
    ssl_certificate /certs/domain.crt;
    ssl_certificate_key /certs/domain.key;

    gzip             on;
    gzip_comp_level  1;
    gzip_min_length  1000;
    gzip_proxied     expired no-cache no-store private auth;
    gzip_types       text/plain application/x-javascript application/javascript application/json text/xml text/css application/xml;

    location ~* ^/(_profiler|_wdt|api)(?<api_path>/.*) {
        set $api_root /srv;
        set $api_entrypoint app.php;
        fastcgi_pass php:9000;
        include fastcgi_params;
        fastcgi_param  SCRIPT_FILENAME    $api_root/$api_entrypoint;
        fastcgi_param  SCRIPT_NAME        $api_entrypoint;
    }

    location / {
        root /srv;
        include mime.types;
    }
}
