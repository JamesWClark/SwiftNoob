Before you can proceed with this task, you need to pull the SQL code from Github. Your database guy should have created that by now. Add the table to your database using their create table syntax.

It's time to collect Google logins. The app designer is sending login information to your server. You need to pass it along to the database.

So, it's your job to setup the route to handle this task.

Along with your previously created `messages` route, we now add this post method to the `users` route.

    app.post('/user', function(req, res) {
        console.log(req.body);
        connection.query({
            sql : 'INSERT IGNORE INTO users(user_id, fullName, givenName, familyName, email, imageUrl) VALUES(?, ?, ?, ?, ?, ?)',
            values : [ req.body.userId, req.body.fullName, req.body.givenName, req.body.familyName, req.body.email, req.body.imageUrl ]
        }, function(error, results) {
            if(error) throw error;
            res.status(201).send(results);
        });
    });

The idea is to send back a 201 status code, object created.

Now, test the route with the advanced rest client.