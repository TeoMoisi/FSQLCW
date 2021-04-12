CREATE DATABASE DB1;

USE DB1;

CREATE TABLE Table1(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	isAdult NUMBER(1),
	age INT
);
INSERT INTO Table1 (id,name,age,isAdult) VALUES (5,Teofana Moisi,65.7,false);

CREATE TABLE Table2(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	FOREIGN KEY name REFERENCES Table1(name)
);
INSERT INTO Table2 (name,) VALUES (Teofana Moisi,);

CREATE TABLE Table3(
	address VARCHAR(255),
	name VARCHAR(255),
	city VARCHAR(255),
	PRIMARY KEY (address,name,city)
);
