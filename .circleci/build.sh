#!/bin/bash
set -euo pipefail

apt install docker curl docker-compose git
docker -v

# install node/npm for tests
NODE_VERSION='6.14.0'
git clone 'https://github.com/isaacs/nave.git'
bash nave/nave.sh 'usemain' "${NODE_VERSION}"

git clone https://github.com/pelias/dockerfiles.git -b circle

cp pelias.json dockerfiles/pelias.json

# run full build with dockerfiles, this also starts services
cd dockerfiles
docker-compose ps
docker-compose version
docker run ubuntu whoami
docker pull pelias/api:staging
bash ./build.sh
cd ..


# run tests
git clone https://github.com/pelias/acceptance-tests.git
cd acceptance-tests
npm i
npm test -- -e local test_cases/portland/*.json
