#!/bin/bash
set -euo pipefail

# run full build with dockerfiles, this also starts services
cd dockerfiles
bash ./build.sh

# give libpostal some time to boot
sleep 30
