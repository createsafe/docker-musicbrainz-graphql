'use strict';

const express = require('express');
const {postgraphile} = require('postgraphile');
const cors = require('cors');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

const app = express();
app.use(cors);
app.use(postgraphile('postgres://musicbrainz@db/musicbrainz', 'musicbrainz', {graphiql: true}))
app.get('/', (req, res) => {
  res.send('Hello world\n');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
