#!/bin/bash
set -euo pipefail

git clone https://github.com/pelias/dockerfiles.git

cp pelias.json dockerfiles/pelias.json

# run full build with dockerfiles, this also starts services
cd dockerfiles
ls
bash ./build.sh
cd ..

# install node/npm for tests
NODE_VERSION='6.14.0'
git clone 'https://github.com/isaacs/nave.git'
./nave/nave.sh 'usemain' "${NODE_VERSION}"

# run tests
git clone https://github.com/pelias/acceptance-tests.git
cd acceptance-tests
npm i
npm test -- -e local test_cases/portland/*.json
