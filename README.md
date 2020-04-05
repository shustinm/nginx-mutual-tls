# NGINX Mutual TLS

This image contains an NGINX server configured with Mutual TLS which will allow your server to do client authentication in addition to server authentication.


## Setup
1. Put your certs in `./certs/`:
* `server.crt` and `server.key` - Server certificate and private key
* `ca.crt` - The certificate of the CA that authorizes the clients that connect to the server
2. Edit the environment variables and ports in the `docker-compose.yml` file:
* `NGINX_CA` - Set this to `off` to disable the loading of the CA certificate, default is `on`
* `VERIFY_DEPTH` - Maximum client certificate verify depth, defaults to `1` which will allow client certificates signed by one intermediate CA, set to `0` to only allow client certificates signed by the trusted root CA.
* `LISTEN_ADDR` - Address for NGINX to listen on. Default is `443`.
* `FW_ADDR` - Address on which the proxied server is listening. Default is `localhost:8123` 
* `ALLOWED_CLIENT_S_DN` - Allowed client certificate subject distinguished name, client certificates with a different DN will result in a `403`.
* `NGINX_DN` - set this to `off` to disable the checking of `ALLOWED_CLIENT_S_DN`. Default is `on`.
3. Run it:
```
docker-compose up
```

## Test
Assuming you have client certs in `client.crt`/`client.key` and `ca_server.crt` contains the CA your server certificate is signed by, you can test it with:
```
curl -v --cert client.crt --key client.key --cacert ca_server.crt https://localhost
```

## Links
* To see which specific configs were used to setup client authentication, check out the [Dockerfile](https://github.com/shustinm/nginx-mutual-tls/blob/master/Dockerfile)
* Docs - http://nginx.org/en/docs/http/ngx_http_ssl_module.html
