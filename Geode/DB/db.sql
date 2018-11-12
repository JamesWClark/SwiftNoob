CREATE USER 'dba'@'localhost' 
IDENTIFIED WITH mysql_native_password 
BY 'hawklets1';

GRANT ALL PRIVILEGES ON * . * TO 'dba'@'localhost';

FLUSH PRIVILEGES;




CREATE TABLE IF NOT EXISTS messages (
    message_id    INT(11)         NOT NULL AUTO_INCREMENT,
    timestamp     DATE            NOT NULL,
    sender        VARCHAR(145)    NOT NULL,
    recipient     VARCHAR(145)    NOT NULL,
    message       VARCHAR(145)    NOT NULL,
    PRIMARY KEY (message_id)
);

CREATE TABLE IF NOT EXISTS users (
    user_id     VARCHAR(26)     NOT NULL,
    fullName    VARCHAR(256)    NOT NULL,
    givenName   VARCHAR(256)    NOT NULL,
    familyName  VARCHAR(256)    NOT NULL,
    email       VARCHAR(256)    NOT NULL,
    imageUrl    VARCHAR(256)    NOT NULL,
    PRIMARY KEY (user_id)    
);

INSERT INTO messages(timestamp, sender, recipient, message)
VALUES(NOW(), "John", "JT", "HEY");

INSERT INTO users(user_id, fullName, givenName, familyName, email, imageUrl)
VALUES(1,"JOHN THE BAPTIST", "JOHN", "BAPTIST", "JOHN@BAP.TIST", "HTTPS://1234.COM");

