'use strict';

const express = require('express');
const {postgraphile} = require('postgraphile');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

setTimeout(() => {
    // App
  const app = express();
  app.use(postgraphile('postgres://musicbrainz@db/musicbrainz', 'musicbrainz', {graphiql: true}))
  app.get('/', (req, res) => {
    res.send('Hello world\n');
  });

  app.listen(PORT, HOST);
  console.log(`Running on http://${HOST}:${PORT}`);
}, 10000); 
/// THIS IS A TERRIBLE HACK TO LET DOCKER DB START, NEED TO FIGURE OUT HOW TO CHECK IF
// SERVICE IS UP AND NOT JUST CONTAINER

