CREATE DATABASE DB1;

USE DB1;

CREATE TABLE Table1(
	id INT PRIMARY KEY
	name VARCHAR(255)
	isAdult NUMBER(1)
	age INT
)

INSERT INTO Table1 (name,age,isAdult) VALUES (Teofana Moisi,65.7,false);
INSERT INTO Table1 (name,age) VALUES (John,7), (Julia,10);
DELETE FROM Table1 WHERE age<=1
 AND id<6
 OR name=Teofana

DELETE * FROM Table1
UPDATE Table1
SET age=6
,address=Roadhbjhv

UPDATE Table1
SET age=8
,name=bjhbjh,address=jksnv
WHERE id>8
 AND name=teo







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
