#!/bin/bash

OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}
VIRTUALENV=${VIRTUALENV:-/home/omero/omeroenv}

#start-nginx-install
apt-get update
apt-get -y install nginx
#end-nginx-install

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

cd ~omero
#web-requirements-recommended-start
su - omero -c "source $VIRTUALENV/bin/activate; pip3 install omero-web"
#web-requirements-recommended-end

# set up as the omero user.
su - omero -c "VIRTUALENV=$VIRTUALENV bash -eux setup_omero_nginx.sh nginx"

#start-nginx-admin
cp OMERO.server/nginx.conf.tmp /etc/nginx/sites-available/omero-web
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/omero-web /etc/nginx/sites-enabled/

service nginx start
#end-nginx-admin
