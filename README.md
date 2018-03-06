# createsafe-graphite

1.  Download the sample DB: https://drive.google.com/open?id=1Mu9PAtzpsr1UNJtt3w0kltpURaR1MrwE

You cannot use the one from their website, as it's in a diff format from the actual db dumps (why?).

Once you've downloaded the DB and cloned this repo, put the sample db (mbdump-sample.tar.bz2) into the mbslave directory in the repo.

Now there are two steps to run.

1.  initialize the database.

```sh
npm run init
```

The database will begin to initialize. You should see mesages like `CREATE VIEW`, `CREATE INDEX`, etc. when the initialization has concluded you will get a message like `INITIALIZATION DONE, PRESS CTRL+C to end container, and run with npm run start`. Now stop the process, and run the next command.

2.  run the container

```sh
npm run start
```

This will run docker compose, setup the node and db containers, and run the node server on port 49000.

Open localhost:49000/graphiql to open the graphql playground.

You can inspect all available queries by clicking 'docs' in the upper right hand corner.

![image](https://user-images.githubusercontent.com/954596/37054508-aba4827e-2144-11e8-820e-29f31acea82f.png)
