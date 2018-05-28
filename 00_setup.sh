#!/bin/bash
set -euo pipefail

DATA_DIR="${DATA_DIR:-/tmp}"
mkdir -p $DATA_DIR

#install dockerfiles
git clone https://github.com/pelias/dockerfiles.git -b aws-ci

# copy over overwritten files
cp pelias.json dockerfiles/pelias.json
cp pelias.json ~/pelias.json
cp docker-compose.yml dockerfiles/

# install acceptance tests
git clone https://github.com/pelias/acceptance-tests.git -b portland-tests
cd acceptance-tests
npm i

# make require directories
cd $DATA_DIR
mkdir -p whosonfirst openaddresses polylines elasticsearch openstreetmap tiger
