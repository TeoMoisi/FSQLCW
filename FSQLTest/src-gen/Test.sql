CREATE DATABASE DB1;

USE DB1;

CREATE TABLE Table1(
	id INT PRIMARY KEY
	name VARCHAR(255)
	isAdult NUMBER(1)
	age INT
)

INSERT INTO Table1 (name, age
) VALUES (Teofana, 65);
INSERT INTO Table1 (name, age
) VALUES (John, 7), (Julia, 10);
DELETE FROM Table1 WHERE age=1









CREATE TABLE Table2(
	id INT PRIMARY KEY
	name VARCHAR(255)
	FOREIGN KEY name REFERENCES Table1(name)
)



CREATE TABLE Table3(
	address VARCHAR(255)
	name VARCHAR(255)
	city VARCHAR(255)
	PRIMARY KEY (address, name, city)
)
DROP TABLE Table1;
