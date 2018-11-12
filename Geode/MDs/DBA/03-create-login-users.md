Create new users from Google login. Store their information here:

    CREATE TABLE IF NOT EXISTS users (
        user_id     VARCHAR(26)     NOT NULL,
        fullName    VARCHAR(256)    NOT NULL,
        givenName   VARCHAR(256)    NOT NULL,
        familyName  VARCHAR(256)    NOT NULL,
        email       VARCHAR(256)    NOT NULL,
        imageUrl    VARCHAR(256)    NOT NULL,
        PRIMARY KEY (user_id)    
    );

Give your ip address to the backend guy. Have him try connecting to your database engine from his web server.