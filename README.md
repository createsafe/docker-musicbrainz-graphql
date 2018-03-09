# docker-musicbrainz-graphql

This project is a way to get up and running quickly with Docker, Graphql, and the Musicbrainz Database by leveraging the power of graphile. In under 10 minutes, you will be able to immediatly begin work with the MusicBrainz DB. The returned data follows [the Relay specification.](https://facebook.github.io/relay/graphql/connections.htm)

![image](https://user-images.githubusercontent.com/954596/37055130-84fce718-2146-11e8-88b3-8e9a4c3e34d2.png)

## Quick Start

There are only 3 three steps to follow to get this up and running

1.  Get the database
2.  Provision Docker
3.  Run the container

### 1. Get the database

If you don't want to pull down the full production dump, you can download the [sample db](https://drive.google.com/open?id=1Mu9PAtzpsr1UNJtt3w0kltpURaR1MrwE).
If you're using the full db export, skip to step 2.

You cannot use the sample from their website, as unfrotunately it's in a diff format from the full db dumps (why?).

Once you've downloaded the DB and cloned this repo, put the sample db (mbdump-sample.tar.bz2) into the mbslave directory in the repo.

Now there are two more steps to run.

### 2. Provision Docker

```sh
npm run init_db:test
```

Or to pull the full Musicbrainz DB

```sh
npm run init_db:production
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

If you'd like a sample query to immediately see results, try this:

```gql
query getAll {
  allTracks(first: 100) {
    nodes {
      name
    }
  }
}
```

![musicbrainz](https://user-images.githubusercontent.com/954596/37055656-da0e3738-2147-11e8-9654-cb8935df3036.gif)
