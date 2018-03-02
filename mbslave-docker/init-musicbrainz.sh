#!/bin/bash
createuser musicbrainz
createdb -l C -E UTF-8 -T template0 -O musicbrainz musicbrainz
psql musicbrainz -c 'CREATE EXTENSION cube;'
psql musicbrainz -c 'CREATE EXTENSION earthdistance;'

cd /mbslave

echo 'CREATE SCHEMA musicbrainz;' | ./mbslave-psql.py -S

./mbslave-remap-schema.py <sql/CreateTables.sql | ./mbslave-psql.py

mbdumps=/mbdumps
cd $mbdumps

# if [ -e "$mbdumps/mbdump.tar.bz2" ]; then
if [ -e "$mbdumps/mbdump-sample.tar.bz2" ]; then
    echo -e "${ylbold}\nFound the dump files.${endColor}"
else
  echo "would download here"
    # LATEST="$(wget -O - http://ftp.musicbrainz.org/pub/musicbrainz/data/sample/LATEST)"
    # wget http://ftp.musicbrainz.org/pub/musicbrainz/data/sample/$LATEST/mbdump-sample.tar.xz
    
    # wget http://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/$LATEST/mbdump-cdstubs.tar.bz2
    # wget http://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/$LATEST/mbdump-derived.tar.bz2
    # wget http://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/$LATEST/mbdump-editor.tar.bz2
    # wget http://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/$LATEST/mbdump.tar.bz2
fi

cd /mbslave

  ./mbslave-import.py $mbdumps/mbdump-sample.tar.bz2
# ./mbslave-import.py $mbdumps/mbdump.tar.bz2 $mbdumps/mbdump-derived.tar.bz2 $mbdumps/mbdump-cdstubs.tar.bz2 \
  # $mbdumps/mbdump-derived.tar.bz2 $mbdumps/mbdump-editor.tar.bz2

./mbslave-remap-schema.py <sql/CreatePrimaryKeys.sql | ./mbslave-psql.py

./mbslave-remap-schema.py <sql/CreateIndexes.sql | grep -v musicbrainz_collate | ./mbslave-psql.py
./mbslave-remap-schema.py <sql/CreateSlaveIndexes.sql | ./mbslave-psql.py

./mbslave-remap-schema.py <sql/CreateViews.sql | ./mbslave-psql.py

echo 'VACUUM ANALYZE;' | ./mbslave-psql.py
