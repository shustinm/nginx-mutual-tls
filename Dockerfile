FROM nginx

ENV LISTEN_ADDR='443'
ENV VERIFY_DEPTH=1
ENV ALLOWED_CLIENT_S_DN='/C=IL/ST=Israel/O=Company'
ENV FW_ADDR='localhost:8123'
ENV NGINX_CA='on'
ENV NGINX_DN='on'

COPY nginx.conf /etc/nginx/nginx.conf

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]

CMD nginx -g 'daemon off;'