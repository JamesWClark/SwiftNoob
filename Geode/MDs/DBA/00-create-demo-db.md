Create a project folder for your team app name

Open Visual Studio Code from Applications, then...

File > Open or ⌘ O, Select your project folder

File > New File or ⌘ N

Save as **db.sql**

Open terminal

Login to local mysql (disregard Ubuntu for now)

	mysql -u root -p

Password is **hawklets1**

Create a database

	create database <your app name here>;

Use the database

	use <your app name here>;

Edit **db.sql** and code in the following syntax to create a test table

    CREATE TABLE IF NOT EXISTS messages (
        message_id    INT(11)         NOT NULL AUTO_INCREMENT,
        timestamp     DATE            NOT NULL,
        sender        VARCHAR(145)    NOT NULL,
        recipient     VARCHAR(145)    NOT NULL,
        message       VARCHAR(145)    NOT NULL,
        PRIMARY KEY (message_id)
    );

Insert five test values

    INSERT INTO messages(timestamp, sender, recipient, message)
    VALUES(NOW(), 'Me', 'You', 'Hi!');

Write a query

    SELECT message_id, timestamp, sender, recipient, message
    FROM messages;

Update two test values

    UPDATE messages
    SET sender = 'You', recipient = 'Me', message = 'Bye¿'
    WHERE message_id = 1;

Run the same query

    SELECT message_id, timestamp, sender, recipient, message
    FROM messages;

Delete a value

    DELETE FROM messages
    WHERE message_id = 1;

Run a new query that counts how many total messages there are

    SELECT COUNT(message) AS "NumMessages"
    FROM messages;