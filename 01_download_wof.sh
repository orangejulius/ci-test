#!/bin/bash
set -euo pipefail

# download wof data separately, with a progress meter, so the build does not expire due to the length of time it takes
mkdir -p /tmp/whosonfirst/sqlite
pushd /tmp/whosonfirst/sqlite > /dev/null
echo @`date +%s` > whosonfirst-data-latest.db.timestamp
curl https://dist.whosonfirst.org/sqlite/whosonfirst-data-latest.db.bz2 | pv | bunzip2 > whosonfirst-data-latest.db
popd > /dev/null
