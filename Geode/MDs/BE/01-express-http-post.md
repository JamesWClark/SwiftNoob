-

# HTTP Post in Express

Previously we created a **messages** table.

Our goal here is to insert a record into the database using HTTP Post method.

First we need to install the **body-parser** dependency, so open terminal, go to your Node folder, and do that...

    npm install body-parser --save

Then, we include it in **index.js** along with those other requires at the top:

    var bodyParser = require('body-parser');

Create an Express app after all your database connection code.

    // web server
    var app = express();

Middleware is a piece of software that we run in between every HTTP request to our server.

In this case, we want to be configure body-parser to handle JSON.

We also want to allow cross domain requests to our web server.

    // use middlewares
    app.use(bodyParser.json());
    app.use(allowCrossDomain);

Next, we create an HTTP Post route on the `/user` path of our web server.

The idea is that new messages can be created by sending some JSON data to for example `http://ourdomain.com/message`.

    app.post('/message', function(req, res) {
        connection.query({
            sql : 'INSERT INTO messages(timestamp, sender, recipient, message) VALUES(NOW(), ?, ?, ?)',
            values : [ req.body.message_id, req.body.sender, req.body.recipient, req.body.message ]
        }, function(error, results) {
            if(error) throw error;
            res.status(201).send(results);
        });
    });

To actually run the Express web server, we need to listen on a specific port. Ports below 1024 require admin privilege. 3000 is typical, so we'll use that.

    app.listen(3000, function() {
        console.log('listening at http://localhost:3000');
    });

Finally, we need to implement the **allowCrossDomain** function we added to middleware earlier.

Add this to the end of your code:

    /**
    * Middleware:
    * allows cross domain requests
    * ends preflight checks
    */
    function allowCrossDomain(req, res, next) {
        res.setHeader('Access-Control-Allow-Origin', '*');
        res.setHeader('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE');
        res.setHeader('Access-Control-Allow-Headers', 'Authorization');

        // end pre flights
        if (req.method === 'OPTIONS') {
            res.writeHead(204);
            res.end();
        } else {
            next();
        }
    }

Run the web server from terminal.

    node index

Get the Advanced REST Client (ARC) app from the Google Chrome app store.

Add an **application/json** header.

![Imgur](https://i.imgur.com/7Su8OEO.png)

Send the following JSON

    { "message_id": 2, "sender" : "John", "recipient" : "JT", "message" : "Hi hey hello" }

![Imgur](https://i.imgur.com/60e0mfk.png)

Login to your database and verify it 

    SELECT * FROM messages;

Test a few more...