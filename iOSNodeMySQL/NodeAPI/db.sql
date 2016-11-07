CREATE DATABASE MyApp;

USE MyApp;

CREATE TABLE IF NOT EXISTS people (
  person_id     INT(11)             NOT NULL AUTO_INCREMENT,
  first_name    VARCHAR(50)         NOT NULL,
  last_name     VARCHAR(50)         NOT NULL,
  email         VARCHAR(254)        DEFAULT NULL,
  birth_date    DATE                DEFAULT NULL,
  PRIMARY KEY (person_id)
);

CREATE TABLE IF NOT EXISTS tasks (
  task_id       INT(11)             NOT NULL AUTO_INCREMENT,
  subject       VARCHAR(45)         DEFAULT NULL,
  start_date    DATE                DEFAULT NULL,
  end_date      DATE                DEFAULT NULL,
  description   VARCHAR(200)        DEFAULT NULL,
  PRIMARY KEY (task_id)
);


/* CREATE */
INSERT INTO tasks(subject, description)
VALUES('kitchen','do the dishes; take out trash');

/* READ */
SELECT task_id
FROM tasks;

/* UPDATE */
UPDATE tasks
SET description = 'clean the house'
WHERE task_id = 1;

/* DELETE */
DELETE FROM tasks
WHERE task_id = 1;


INSERT INTO tasks
SET subject = 'garage', description = 'clean the oil spill';