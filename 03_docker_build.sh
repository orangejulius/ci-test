#!/bin/bash
set -euo pipefail

# run full build with dockerfiles, this also starts services
cd dockerfiles
echo "DATA_DIR=$DATA_DIR" > .env
bash ./build.sh
docker-compose ps

# give libpostal some time to boot
sleep 30
