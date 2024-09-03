const express = require('express');
const ejs = require('ejs');
const path = require('path');
const app = express();
const cookieParser = require('cookie-parser');
require('dotenv').config()

app.use((req, res, next) => {
  console.log(`Request: ${req.method} ${req.originalUrl}`);
  next();
});


const PORT = process.env.PORT || 3333;

const db_mongo = require('./src/database/mongo');

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(cookieParser());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
  res.setHeader('Access-Control-Allow-Headers', '*');
  res.setHeader('Access-Control-Allow-Credentials', true);
  next();
});

app.use(express.static(__dirname + '/views'));
app.use(express.static(__dirname + '/public'));

require('./src/router/user/user.query')(app);
require('./src/router/api/api.query')(app);

app.get("*", function (req, res) {
  res.status(404).send('Not found');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});
