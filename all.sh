#!/bin/bash
set -euxo pipefail

export DATA_DIR="${DATA_DIR:-/tmp}"

bash 00_*
bash 01_*
bash 02_*
bash 03_*
bash 04_*
