CREATE DATABASE FSQLTEST;

USE FSQLTEST;

CREATE TABLE Users(
	userId INT PRIMARY KEY,
	name VARCHAR(255),
	age INT,
	isAdult NUMBER(1)
);
SELECT COUNT( name ) FROM Users WHERE city=
"London"
 AND age=
20

SELECT MAX( age ) FROM Users WHERE city=
"London"
