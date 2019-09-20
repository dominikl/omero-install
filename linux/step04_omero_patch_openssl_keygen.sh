#!/bin/bash

# Use self-signed certificates to work-around problems with
# disallowed ADH ciphers

set -eu

mkdir -p /opt/omero/server/OMERO.server/var/certs
cd /opt/omero/server/OMERO.server/var/certs

if [ -f server.p12 -a -f server.pem -a -f server.key ]; then
    echo "Certificates already exist, not overwriting"
    exit 0
fi

openssl req -new -nodes -x509 -subj "/C=UK/ST=Scotland/L=Dundee/O=OME/CN=localhost" -days 3650 -keyout server.key -out server.pem -extensions v3_ca
echo Created server.key server.pem

openssl pkcs12 -export -out server.p12 -inkey server.key -in server.pem -name server -password pass:secret

chown -R omero /opt/omero/server/OMERO.server/var/certs
