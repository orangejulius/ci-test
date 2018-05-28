#!/bin/bash
set -euo pipefail

DATA_DIR="${DATA_DIR:-/tmp}"

# download dockerfiles while other things are running
cd $DATA_DIR/dockerfiles
docker-compose pull &

# download wof data separately, with a progress meter, so the build does not expire due to the length of time it takes
mkdir -p $DATA_DIR/whosonfirst/sqlite
cd $DATA_DIR/whosonfirst/sqlite
echo @`date +%s` > whosonfirst-data-latest.db.timestamp
curl https://dist.whosonfirst.org/sqlite/whosonfirst-data-latest.db.bz2 | pv | bunzip2 > whosonfirst-data-latest.db

# also download other custom data
cd $DATA_DIR/openaddresses
wget https://s3.amazonaws.com/data.openaddresses.io/openaddr-collected-us_west.zip
wget https://s3.amazonaws.com/data.openaddresses.io/openaddr-collected-us_west-sa.zip
for archive in `ls -1 *.zip`; do
  unzip -oq $archive
done
rm *.zip

# download polylines file
curl https://s3.amazonaws.com/pelias-data.nextzen.org/polylines/california-2018-05-28.polyline.gz | gunzip > $DATA_DIR/polylines/extract.0sv
