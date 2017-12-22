#!/usr/bin/env bash

# meant to be used for the pgwatch2-webpy docker image

# currently only checks if SSL is enabled and if so generates new cert on the first run
if [ -n "$PW2_WEBSSL" ] ; then
    if [ ! -f /pgwatch2/ssl_key.pem -o ! -f /pgwatch2/ssl_cert.pem ] ; then
        # generate self-signed SSL certificates
        openssl req -x509 -newkey rsa:4096 -keyout /pgwatch2/ssl_key.pem -out /pgwatch2/ssl_cert.pem -days 3650 -nodes -sha256 -subj '/CN=pw2'
    fi
fi

exec /pgwatch2/webpy/web.py "$@"
