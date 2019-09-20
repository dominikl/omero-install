#!/bin/bash

# Use self-signed certificates to work-around problems with
# disallowed ADH ciphers

OMERO.server/bin/omero config set omero.glacier2.IceSSL.Ciphers ADH:HIGH
OMERO.server/bin/omero config set omero.glacier2.IceSSL.DefaultDir /opt/omero/server/OMERO.server/var/certs
OMERO.server/bin/omero config set omero.glacier2.IceSSL.CAs server.pem
OMERO.server/bin/omero config set omero.glacier2.IceSSL.CertFile server.p12
OMERO.server/bin/omero config set omero.glacier2.IceSSL.Password secret

