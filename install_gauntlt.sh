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
	build-essential git libxml2 libxml2-dev \
    libxslt-dev libcurl4-openssl-dev libsqlite3-dev libyaml-dev zlib1g-dev \
    python-dev python-pip python-setuptools curl nmap w3af-console \
    wget locate librtmp1 lua-lpeg
	# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=835342#76
apt-get autoremove -y





# install Gauntlt
# gem install gauntlt --no-rdoc --no-ri
cd ~
git clone https://github.com/gauntlt/gauntlt
cd gauntlt
export GAUNTLT_DIR=`pwd`
git submodule update --init --recursive --force
bundle install --system
gem build gauntlt.gemspec
gem install gauntlt-1.0.12.gem




# check for system variables
if [ -z $HOME_FOLDER ]; then
    HOME_FOLDER=$HOME
    echo -e "INFO: setting \$HOME_FOLDER to $HOME";
fi
if [ -z $USER_NAME ]; then
    USER_NAME=`whoami`
    echo -e "INFO: setting \$USER_NAME to `whoami`";
fi

# install sslyze
if ! type "sslyze" > /dev/null 2>&1; then
    cd $GAUNTLT_DIR/vendor/sslyze
    pip install -r requirements.txt
    ln -s `pwd`/sslyze_cli.py /usr/bin/sslyze
fi



# install sqlmap
if ! type "sqlmap" > /dev/null 2>&1; then
    cd $GAUNTLT_DIR/vendor/sqlmap
    ln -s `pwd`/sqlmap.py /usr/bin/sqlmap
fi



# install Go, Heartbleed
if ! type "Heartbleed" > /dev/null 2>&1; then
    apt-get install -y golang
    export GOPATH=$HOME_FOLDER/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
    cat << 'EOF' >> $HOME_FOLDER/.bashrc

# configure go pathways
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
EOF
    go get github.com/FiloSottile/Heartbleed
fi


# install dirb
if ! type "dirb" > /dev/null 2>&1; then
	cd $GAUNTLT_DIR/vendor
	wget -q http://downloads.sourceforge.net/project/dirb/dirb/2.22/dirb222.tar.gz
	tar -zxf dirb222.tar.gz
	mv dirb222 dirb
	chmod -R +x ./dirb
	cd dirb
	chown -R $(whoami) .
	cd $GAUNTLT_DIR/vendor/dirb
    bash ./configure
    make
    ln -s `pwd`/dirb /usr/bin/dirb
	updatedb
fi
export DIRB_WORDLISTS=`locate dirb | grep "/dirb/wordlists$"`


# install Garmr, from source
if ! type "garmr" > /dev/null 2>&1; then
    cd $GAUNTLT_DIR/vendor/Garmr
    mkdir -p /usr/local/lib/python2.7/dist-packages/
    python setup.py install
	updatedb
fi


# install Arachni, from a gem
if ! type "arachni" > /dev/null 2>&1; then
    gem install arachni -v 1.0.6
    gem install service_manager
	updatedb
fi



# set the environmental variables
export SSLYZE_PATH=`which sslyze`
export SQLMAP_PATH=`which sqlmap`

# save environmental variables to .bashrc
cat << EOF >> $HOME_FOLDER/.bashrc

# configure environmental variables for Gauntlt
export DIRB_WORDLISTS=`locate dirb | grep "/dirb/wordlists$"`
export SSLYZE_PATH=`which sslyze`
export SQLMAP_PATH=`which sqlmap`
EOF

# chown the environment
cd $GAUNTLT_DIR
chown -R `whoami` ./
updatedb

# start gruyere
# cd $GAUNTLT_DIR/vendor/gruyere
# bash ./manual_launch.sh
# gauntlt

