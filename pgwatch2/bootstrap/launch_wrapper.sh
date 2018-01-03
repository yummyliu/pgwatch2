#!/usr/bin/env bash

# generates new cert on the first run
# used by Postgres and also WebUI/Grafana if $PW2_WEBSSL/$PW2_GRAFANASSL set

if [ ! -f /pgwatch2/ssl_key.pem -o ! -f /pgwatch2/ssl_cert.pem ] ; then
    openssl req -x509 -newkey rsa:4096 -keyout /pgwatch2/ssl_key.pem -out /pgwatch2/ssl_cert.pem -days 3650 -nodes -sha256 -subj '/CN=pw2'
    chmod 0600 /pgwatch2/*.pem
fi

if [ -n "$PW2_GRAFANASSL"] ; then
    HTTP=$(grep -c 'protocol = http' /etc/grafana/grafana.ini)
    if [ "$HTTP" -eq 0 ] ; then
        sed -i 's/protocol = http.*/protocol = https/' /etc/grafana/grafana.ini
    fi
fi

supervisorctl start grafana
supervisorctl start webpy
