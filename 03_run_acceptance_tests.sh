#!/bin/bash
set -euo pipefail

# run tests
cd acceptance-tests
npm test -- -e local test_cases/portland/*.json || true
