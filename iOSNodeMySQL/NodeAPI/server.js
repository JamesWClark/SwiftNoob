var http       = require('http');
var mysql      = require('mysql');
var express    = require('express');
var bodyParser = require('body-parser');

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

var connection = mysql.createConnection({
    host     :   'localhost',
    user     :   'root',
    password :   'hawklet',
    database :   'myapp'
});

connection.connect();

connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
  if (err) throw err;
 
  console.log('The solution is: ', rows[0].solution);
});

var app = express();

app.use(bodyParser.urlencoded({
    extended: true
}));

app.get('/', function(req, res) {
    res.send('hello');
});

app.post('/task', function(req, res) {
    
    log('got /task post');
    log('req = ', req);
    log('req.body = ', req.body);
    log('req.body.data = ', req.body.data);
    
    // Multiple placeholders are mapped to values in the same order as passed. For example, in the following query foo equals a,
    // bar equals b, baz equals c, and id will be userId:

    connection.query('INSERT INTO tasks(subject) VALUES(?)', ['connected'], function(err, results) {
        console.log(results);
        res.send('got it');
    });     
});

http.createServer(app).listen(3000);

console.log('http://localhost:3000/');
