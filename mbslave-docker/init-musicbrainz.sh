#!/bin/bash
sleep 1
echo "creating user"
createuser musicbrainz
sleep 1
echo "creating db"
createdb -l C -E UTF-8 -T template0 -O musicbrainz musicbrainz
sleep 1
psql musicbrainz -c 'CREATE EXTENSION cube;'
psql musicbrainz -c 'CREATE EXTENSION earthdistance;'

cd /mbslave

echo 'CREATE SCHEMA musicbrainz;' | ./mbslave-psql.py -S

./mbslave-remap-schema.py <sql/CreateTables.sql | ./mbslave-psql.py

mbdumps=/mbdumps
cd $mbdumps

DUMP_FILE=""

if [[ $MB_ENV == 'production' ]]; then
  echo 'SETTING UP PRODUCTION DB';
  DUMP_FILE="$mbdumps/mbdump.tar.bz2"; 
else
  echo 'SETTING UP SAMPLE DB';
  DUMP_FILE="$mbdumps/mbdump-sample.tar.bz2"; 
fi

if [[ -e $DUMP_FILE ]]; then
    echo -e "${ylbold}\nFound the dump files.${endColor}"
else
  if [[ $MB_ENV == 'production' ]]; then
    LATEST="$(wget -O - http://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/LATEST)"

    wget http://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/$LATEST/mbdump-cdstubs.tar.bz2
    wget http://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/$LATEST/mbdump-derived.tar.bz2
    wget http://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/$LATEST/mbdump-editor.tar.bz2
    wget http://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/$LATEST/mbdump.tar.bz2
  fi
fi

cd /mbslave

./mbslave-import.py $DUMP_FILE

if [[ $MB_ENV == 'production' ]]; then
  ./mbslave-import.py $mbdumps/mbdump-derived.tar.bz2 
  ./mbslave-import.py $mbdumps/mbdump-cdstubs.tar.bz2
  ./mbslave-import.py $mbdumps/mbdump-derived.tar.bz2 
  ./mbslave-import.py $mbdumps/mbdump-editor.tar.bz2
fi

./mbslave-remap-schema.py <sql/CreatePrimaryKeys.sql | ./mbslave-psql.py
# ./mbslave-remap-schema.py <sql/statistics/CreatePrimaryKeys.sql | ./mbslave-psql.py
# ./mbslave-remap-schema.py <sql/caa/CreatePrimaryKeys.sql | ./mbslave-psql.py
# ./mbslave-remap-schema.py <sql/wikidocs/CreatePrimaryKeys.sql | ./mbslave-psql.py
# ./mbslave-remap-schema.py <sql/documentation/CreatePrimaryKeys.sql | ./mbslave-psql.py

./mbslave-remap-schema.py <sql/CreateFKConstraints.sql | ./mbslave-psql.py

./mbslave-remap-schema.py <sql/CreateIndexes.sql | grep -v musicbrainz_collate | ./mbslave-psql.py
./mbslave-remap-schema.py <sql/CreateSlaveIndexes.sql | ./mbslave-psql.py

./mbslave-remap-schema.py <sql/CreateViews.sql | ./mbslave-psql.py

echo 'VACUUM ANALYZE;' | ./mbslave-psql.py
