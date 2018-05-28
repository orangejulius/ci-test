#!/bin/bash
set -euxo pipefail

# pull docker images as a separate step, for timing
cd dockerfiles
docker-compose pull
