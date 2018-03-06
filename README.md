# createsafe-graphite

## Quick Start

There are only 3 three steps to follow to get this up and running

1.  Get the database
2.  Provision Docker
3.  Run the container

### 1. Get the database

Download the sample DB: https://drive.google.com/open?id=1Mu9PAtzpsr1UNJtt3w0kltpURaR1MrwE

You cannot use the one from their website, as unfrotunately it's in a diff format from the actual db dumps (why?).

Once you've downloaded the DB and cloned this repo, put the sample db (mbdump-sample.tar.bz2) into the mbslave directory in the repo.

Now there are two more steps to run.

### 2. Provision Docker

```sh
npm run init
```

The database will begin to initialize. You should see mesages like `CREATE VIEW`, `CREATE INDEX`, etc. when the initialization has concluded you will get a message like `INITIALIZATION DONE, PRESS CTRL+C to end container, and run with npm run start`. Now stop the process, and run the next command.

### 3. Run the container

```sh
npm run start
```

This will run docker compose, setup the node and db containers, and run the node server on port `49000`.
Navigating to `localhost:49000/graphiql` will now open the graphql playground.

You can inspect all available queries by clicking 'docs' in the upper right hand corner.
![image](https://user-images.githubusercontent.com/954596/37054508-aba4827e-2144-11e8-820e-29f31acea82f.png)
