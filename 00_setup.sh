#!/bin/bash
set -euo pipefail

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
