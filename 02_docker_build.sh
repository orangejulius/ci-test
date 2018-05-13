#!/bin/bash
set -euo pipefail

# run full build with dockerfiles, this also starts services
cp docker-compose.yml dockerfiles/
cd dockerfiles
bash ./build.sh
cd ..
