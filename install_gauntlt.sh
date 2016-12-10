#!/bin/bash

apt-get update
apt-get install -y locate
updatedb

gem install gauntlt --no-rdoc --no-ri
