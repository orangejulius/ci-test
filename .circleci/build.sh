#!/bin/bash
set -euo pipefail

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update

sudo apt install -y docker-ce curl git
docker -v

# install node/npm for tests
NODE_VERSION='6.14.0'
git clone 'https://github.com/isaacs/nave.git'
bash nave/nave.sh 'usemain' "${NODE_VERSION}"

git clone https://github.com/pelias/dockerfiles.git -b circle

cp pelias.json dockerfiles/pelias.json

# download wof data separately, with a progress meter, so the build does not expire due to the length of time it takes
mkdir -p /tmp/whosonfirst/sqlite
pushd /tmp/whosonfirst/sqlite > /dev/null
echo @`date +%s` > whosonfirst-data-latest.db.timestamp
curl https://dist.whosonfirst.org/sqlite/whosonfirst-data-latest.db.bz2 | pv | bunzip2 > whosonfirst-data-latest.db
popd > /dev/null

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
