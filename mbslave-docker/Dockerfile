FROM postgres:9.6

RUN apt-get update && apt-get install -y \
    wget python python-psycopg2 && rm -rf /var/lib/apt/lists/*

ADD https://github.com/lalinsky/mbslave/archive/master.tar.gz /mbslave/
RUN tar -xzf /mbslave/master.tar.gz --strip-components=1 -C /mbslave/ \
    && rm /mbslave/master.tar.gz
COPY mbslave.conf /mbslave/
COPY init-musicbrainz.sh /docker-entrypoint-initdb.d
RUN mkdir -p /mbdumps && chown -R postgres:postgres /mbdumps
COPY mbdump-sample.tar.bz2 /mbdumps
