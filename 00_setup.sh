#!/bin/bash
set -euo pipefail

# set up required ubuntu dependencies
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install -y docker-ce curl git pv

# install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod ugo+x /usr/local/bin/docker-compose

# start docker
sudo /etc/init.d/docker start

# install node/npm for tests
NODE_VERSION='6.14.0'
git clone 'https://github.com/isaacs/nave.git'
sudo bash nave/nave.sh 'usemain' "${NODE_VERSION}"

#install dockerfiles
git clone https://github.com/pelias/dockerfiles.git -b circle

# copy over overwritten files
cp pelias.json dockerfiles/pelias.json
cp pelias.json ~/pelias.json
cp docker-compose.yml dockerfiles/

# install acceptance tests
git clone https://github.com/pelias/acceptance-tests.git -b portland-tests
cd acceptance-tests
npm i
