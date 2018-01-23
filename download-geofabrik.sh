#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

cd /import

if [ "$#" -ne 1 ]; then
    echo "We need only 1 area parameter!"
    exit
fi

AREA=$1
DOCKER_COMPOSE_FILE=./docker-compose-config.yml

FILENAME=${AREA}.osm.pbf
FILEURL=http://download.geofabrik.de/north-america/us/${AREA}-latest.osm.pbf

echo "--------------------------------------------"
echo Downloading ${FILENAME} from ${FILEURL}
echo "--------------------------------------------"
wget -O ${FILENAME} ${FILEURL}

ls *.osm.pbf  -la
osmconvert  --out-statistics  ${AREA}.osm.pbf  > ./osmstat.txt
