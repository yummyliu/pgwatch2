#!/bin/bash
echo 'Moving files into place...'
/usr/bin/install -c -m 755 /usr/local/Cellar/postgresql/10.4/lib/postgresql/pgstattuple.so /usr/local/pgsql/lib
/usr/bin/install -c -m 644 $(find /usr/local/Cellar/postgresql/10.4/share/postgresql/extension -name pgstattuple*) /usr/local/pgsql/share/extension
echo 'Success.'
