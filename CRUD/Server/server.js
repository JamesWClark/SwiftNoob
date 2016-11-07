/*
 * It's important to escape characters to avoid SQL injection 
 * https://github.com/mysqljs/mysql#escaping-query-values
 * 
 * HTTP status codes
 * https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
 */ 

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

// logger that prevents circular object reference in javascript
var log = function(msg, obj) {
    console.log('\n');
    if(obj) {
        try {
            console.log(msg + JSON.stringify(obj));
        } catch(err) {
            var simpleObject = {};
            for (var prop in obj ){
                if (!obj.hasOwnProperty(prop)){
                    continue;
                }
                if (typeof(obj[prop]) == 'object'){
                    continue;
                }
                if (typeof(obj[prop]) == 'function'){
                    continue;
                }
                simpleObject[prop] = obj[prop];
            }
            console.log('circular-' + msg + JSON.stringify(simpleObject)); // returns cleaned up JSON
        }        
    } else {
        console.log(msg);
    }
};

connection.connect();

connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
    if(err) throw err;
    console.log('The solution is: ' + rows[0].solution);
});

var app = express();

// makes it possible to parse JSON
app.use(bodyParser.json());

// best be ready to handle invalid json
app.use(function(error, req, res, next) {
    if (error instanceof SyntaxError) {
        res.status(400).send('Bad Request');
    } else {
        next();
    }
});


/* POST - CREATE */
app.post('/task', function(req, res) {
    console.log('/task req.body = ' + JSON.stringify(req.body));
    var insert = 'INSERT INTO tasks SET ?';
    connection.query(insert, req.body, function(err, rows) {
        if(err) {
            res.status(400).send('Bad Request');
        } else {
            res.status(201).send('Created');
        }
    });
});

/* GET - READ */
app.get('/tasks', function(req, res) {
    var select = 'SELECT * FROM tasks';
    connection.query(select, function(err, rows) {
        res.send({ data : rows });
    });
});

app.get('/task/:id', function(req, res) {
    var select = 'SELECT * FROM tasks WHERE task_id = ?';
    connection.query(select, [req.params.id], function(err, rows) {
        res.send({ data : rows });
    });
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
