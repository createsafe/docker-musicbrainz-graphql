# createsafe-graphite

1. Download the sample DB: https://drive.google.com/open?id=1Mu9PAtzpsr1UNJtt3w0kltpURaR1MrwE

You cannot use the one from their website, as it's in a diff format from the actual db dumps (why?).

Once you've downloaded the DB and cloned this repo, put the sample db (mbdump-sample.tar.bz2) into the mbslave directory in the repo.

```sh
npm run init
npm start
```

This will run docker compose, setup the node and db containers, and run the node server on port 49000.

Open localhost:49000/graphiql for testing the queries against the sample db.
