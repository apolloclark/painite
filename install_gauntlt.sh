#!/bin/bash

apt-get update
apt-get install -y locate
updatedb

# install RVM, source, install Ruby 2.3.0
gpg --keyserver hkp://keys.gnupg.net --recv-keys \
    409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
usermod -a -G rvm `whoami`
source /etc/profile.d/rvm.sh
echo 'source /etc/profile.d/rvm.sh' >> /etc/profile
/bin/bash -l -c "rvm requirements;"
rvm use 2.3.0 --default --install --fuzzy
	
cd ~
git clone https://github.com/gauntlt/gauntlt
cd gauntlt
export HOME_FOLDER=/root
source ./install_gauntlt_deps.sh
bash ./ready_to_rumble.sh
gauntlt
