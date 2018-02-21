'use strict';

const express = require('express');
const {Client} = require('pg');

const client = new Client();

client.connect().then(() => {
  console.log(client);
});


// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
  res.send('Hello world\n');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
