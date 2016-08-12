FROM nginx:1.9

COPY support/front/boot.sh /usr/local/bin/boot.sh
COPY support/front/config /etc/nginx/
COPY web /srv/

CMD ["bash", "/usr/local/bin/boot.sh"]
