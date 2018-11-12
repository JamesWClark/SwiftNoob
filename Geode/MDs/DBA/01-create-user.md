-

# Create a New User and Grant Privileges

## Login as Root

For this task, you must login as **root**.

    mysql -u root -p

Recall the password is **hawklets1**.

Previously we created the **<your app name here>** database. If you haven't already, please create it now.

## Create or Verify a Database

    CREATE DATABASE <your app name here>;

Use it.

    USE <your app name here>;

## Create a New User

Create a new user called **dev**.

    CREATE USER 'dev'@'localhost' 
    IDENTIFIED WITH mysql_native_password 
    BY 'hawklets1';

## Grant Privileges

Grant full access

    GRANT ALL PRIVILEGES ON * . * TO 'dev'@'localhost';

And don't forget to flush privileges

    FLUSH PRIVILEGES;

## Test the New User

Logout

    exit;

And test the new username

    mysql -u dev -p
