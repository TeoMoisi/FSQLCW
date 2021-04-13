CREATE DATABASE DB1;

USE DB1;

CREATE TABLE Table1(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	isAdult NUMBER(1),
	age INT
);
INSERT INTO Table1 (id,name,age,isAdult) VALUES (8,"Teofana Moisi",65,true);
INSERT INTO Table1 (id,name,age,isAdult) VALUES (9,"John",7,false), (9,"Julia",10,false);
DELETE FROM Table1 WHERE age=
1
 AND id<
6 OR name=
"Teofana"
;
UPDATE Table1
SET age=8
,name="bjhbjh",address="jksnv"
WHERE id>
8
 AND name=
"teo"
;

CREATE TABLE Table2(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	FOREIGN KEY name REFERENCES Table1(name)
);
INSERT INTO Table2 (id,name) VALUES (8,"Teofana Moisi");
SELECT name
,age
 FROM Table1 INNER JOIN
 Table2 ON Table1.name = Table2.name

SELECT name
,age
 FROM Table1 LEFT JOIN
 Table2 ON Table1.name = Table2.name


CREATE TABLE Table3(
	address VARCHAR(255),
	name VARCHAR(255),
	city VARCHAR(255),
	PRIMARY KEY (address,name,city)
);
DROP TABLE Table1;
