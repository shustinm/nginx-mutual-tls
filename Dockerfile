FROM nginx

EXPOSE 443

COPY nginx.conf /etc/nginx/conf.d/

ENV LISTEN_ADDR '443'
ENV VERIFY_DEPTH 1
ENV ALLOWED_CLIENT_S_DN 'CN=shust.in,O=Shustin Software Solutions,L=Scranton,ST=Israel,C=IL'
ENV FW_ADDR 'localhost:8123'
CMD envsubst '${LISTEN_ADDR} ${VERIFY_DEPTH} ${ALLOWED_CLIENT_S_DN} ${FW_ADDR}' < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf && exec nginx -g 'daemon off;'
