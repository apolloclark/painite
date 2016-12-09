#!/bin/bash

# set the installation to be non-interactive
export DEBIAN_FRONTEND="noninteractive"

# pre-answer some installation questions
debconf-set-selections <<< 'libc6 libraries/restart-without-asking boolean true'
debconf-set-selections <<< 'libc6:amd64 libraries/restart-without-asking boolean true'
debconf-set-selections <<< 'libc6 glibc/upgrade boolean true'
debconf-set-selections <<< 'libc6:amd64 glibc/upgrade boolean true'





# install system dependencies
apt-get update
apt-get install --yes --allow-downgrades \
	--allow-remove-essential --allow-change-held-packages \
	locate build-essential git libxml2 libxml2-dev libssl-dev libffi-dev \
    libxslt-dev libcurl4-openssl-dev libsqlite3-dev libyaml-dev zlib1g-dev \
    python-dev python-pip python-setuptools curl nmap w3af-console \
    wget locate librtmp1 lua-lpeg openssl
	# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=835342#76
apt-get autoremove -y
updatedb


# install Gauntlt, from source
cd ~
git clone https://github.com/gauntlt/gauntlt
cd gauntlt
bundle install --system #update
exit 0;