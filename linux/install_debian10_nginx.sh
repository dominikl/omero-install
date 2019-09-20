#!/bin/bash

set -e -u -x

OMEROVER=${OMEROVER:-latest}

source settings.env
source settings-web.env

bash -eux step01_ubuntu_init.sh

bash -eux step01_debian10_deps.sh

bash -eux step02_all_setup.sh

bash -eux step03_all_postgres.sh

cp settings.env settings-web.env step04_omero_patch_openssl.sh step04_all_omero.sh setup_omero_db.sh ~omero

su - omero -c "OMEROVER=$OMEROVER bash -eux step04_all_omero.sh"
bash -eux step04_omero_patch_openssl_keygen.sh
su - omero -c "bash -eux step04_omero_patch_openssl.sh"
su - omero -c "bash setup_omero_db.sh"

OMEROVER=$OMEROVER bash -eux step05_debian9_nginx.sh

#If you don't want to use the init.d scripts you can start OMERO manually:
#su - omero -c "OMERO.server/bin/omero admin start"
#su - omero -c "OMERO.server/bin/omero web start"

bash -eux step06_ubuntu_daemon.sh

bash -eux step07_all_perms.sh

bash -eux step08_all_cron.sh

#service omero start
#service omero-web start

# remove this strange file which is a link to itself and prevents nginx to start up
rm /etc/nginx/sites-enabled/default
