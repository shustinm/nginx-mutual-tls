#!/bin/bash

envsubst '${LISTEN_ADDR} ${VERIFY_DEPTH} ${ALLOWED_CLIENT_S_DN} ${FW_ADDR}' < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf

if [[ "${NGINX_CA}" = "off" ]]; then
    sed -i '/ssl_client_certificate/d' /etc/nginx/nginx.conf
    sed -i '/ssl_verify_depth/d' /etc/nginx/nginx.conf
    sed -i 's/ssl_verify_client [a-z]*/ssl_verify_client optional_no_ca/' /etc/nginx/nginx.conf
fi

if [[ "${NGINX_DN}" = "off" ]]; then
    sed -i '/ssl_verify_client/d' /etc/nginx/nginx.conf
    sed -i -e '/ssl_client_s_dn/,/}/d' /etc/nginx/nginx.conf
fi

exec "$@"