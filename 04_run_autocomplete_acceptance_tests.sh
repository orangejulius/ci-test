#!/bin/bash
set -euo pipefail

# run tests
cd acceptance-tests
npm test -- -e local -o autocomplete test_cases/portland/*.json || true
