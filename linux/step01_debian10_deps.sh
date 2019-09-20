#!/bin/bash

# java
apt-get -y install default-jdk-headless

# ice
apt-get -y install dirmngr
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 5E6DA83306132997
echo "deb http://zeroc.com/download/Ice/3.6/debian9 stable main" >> /etc/apt/sources.list.d/ice.list
echo "Package: zeroc*" >> /etc/apt/preferences.d/ice
echo "Pin: version 3.6.*" >> /etc/apt/preferences.d/ice
echo "Pin-Priority: 550" >> /etc/apt/preferences.d/ice
echo "" >> /etc/apt/preferences.d/ice
echo "Package: libzeroc*" >> /etc/apt/preferences.d/ice
echo "Pin: version 3.6.*" >> /etc/apt/preferences.d/ice
echo "Pin-Priority: 550" >> /etc/apt/preferences.d/ice

apt-get update
apt-cache policy
apt-get -y install zeroc-ice-all-runtime
apt-get -y install python-pip
pip install https://github.com/ome/zeroc-ice-py-debian9/releases/download/0.1.0/zeroc_ice-3.6.4-cp27-cp27mu-linux_x86_64.whl

# postgres
apt-get -y install postgresql
service postgresql start

# python stuff
apt-get -y install python-{pip,virtualenv,yaml,jinja2}

# to be installed if recommended/suggested is false
apt-get -y install python-setuptools python-wheel virtualenv

# python-tables will install tables version 3.3
# but it does not work. install pytables from pypi.
pip install tables==3.4.4

#start-web-dependencies
apt-get -y install zlib1g-dev libjpeg-dev
apt-get -y install python-{pillow,numpy}
#end-web-dependencies