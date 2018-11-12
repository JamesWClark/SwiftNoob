-

# Node.js Express MySQL

* Setup a Node.js web server with Express
* Connect to a MySQL database engine with Node.js

## Team Folder

By now you should have a folder named after your team project.

You should also have opened this folder as a project within **Visual Studio Code**

Alternatively you may be using the **VBoxShared** folder we created previously.

Either way, you need to go into this folder with Terminal

    cd <path to folder>

For example

    cd ~/Documents/VBoxShared

Make a new folder called **Node** and go into it with Terminal

    mkdir Node && cd Node

## Package.json

Initialize **package.json**

    npm init

It's okay to accept all the defaults

    package name: (node) 
    version: (1.0.0) 
    description: 
    entry point: (index.js) 
    test command: 
    git repository: 
    keywords: 
    author: 
    license: (ISC)

Answer **yes** then verify the contents with the **cat** command

    cat package.json

It should look like this:

    {
    "name": "node",
    "version": "1.0.0",
    "description": "",
    "main": "index.js",
    "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1"
    },
    "author": "",
    "license": "ISC"
    }

## Node Package Manager (NPM)

Next, we use **npm** to install Express. The `--save` flag records the dependency in **package.json**.

    npm install express --save

Then we use it to install **mysql**

    npm install mysql --save;

## index.js

Using **Visual Studio Code**, File > New File

Save as **index.js**

Require three dependencies:

    var mysql = require('mysql');
    var http = require('http'); // http protocol
    var express = require('express'); // web server

Configure a connetion to  MySQL, but be sure to use your own app name

Also use the new **dev** acount created in a previous step.

    var connection = mysql.createConnection({
        host     : 'localhost',
        user     : 'dev',
        password : 'hawklets1',
        database : '<your app name here>'
    });

Here we attempt to connect and then run a pointless query as proof of connection

    connection.connect();

    connection.query('SELECT 1 + 1 AS solution', function (error, results, fields) {
        if (error) throw error;
        console.log('Successful connection. 1 + 1 = ', results[0].solution);
    });

Finally, run the index with this command

    node index