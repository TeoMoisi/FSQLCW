CREATE DATABASE DB1;

USE DB1;

CREATE TABLE Table1(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	isAdult NUMBER(1),
	age FLOAT
);
INSERT INTO Table1 (id,name,age,isAdult) VALUES (8,"Teofana Moisi",65,true);
INSERT INTO Table1 (id,name,age,isAdult) VALUES (9,"John",9,false), (9,"John",10,false);

CREATE TABLE Table2(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	FOREIGN KEY name REFERENCES Table1(name)
);
INSERT INTO Table2 (id,name) VALUES (8,"Andrew");
DELETE * FROM Table1;
DROP TABLE Table1;
