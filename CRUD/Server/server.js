var http = require('http');
var mysql = require('mysql');
var express = require('express');
var bodyParser = require('body-parser');

var connection = mysql.createConnection({
    host : 'localhost',
    user : 'root',
    password : 'hawklet',
    database : 'myapp'
});

connection.connect();

connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
    if(err) throw err;
    console.log('The solution is: ' + rows[0].solution);
});

var app = express();

// makes it possible to parse HTTP body (as json)
app.use(bodyParser.urlencoded({
    extended: true
}));


/* POST - CREATE */
app.post('/task', function(req, res) {
    console.log('post task');
});

/* GET - READ */
app.get('/task/:id', function(req, res) {
    console.log('get task with id: ' + req.params.id);
});

/* PUT - UPDATE */
app.put('/task/:id', function(req, res) {
    console.log('put task with id: ' + req.params.id);
});

/* DELETE */
app.delete('/task/:id', function(req, res) {
    console.log('delete task with id: ' + req.params.id);
});

http.createServer(app).listen(3000);

console.log('http://localhost:3000/');
