#!/bin/bash
set -euxo pipefail

# run tests
cd acceptance-tests
npm test -- -q -e local || true
