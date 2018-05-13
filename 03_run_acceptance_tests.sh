#!/bin/bash
set -euo pipefail

# run tests
git clone https://github.com/pelias/acceptance-tests.git -b portland-tests
cd acceptance-tests
npm i
npm test -- -e local test_cases/portland/*.json || true
