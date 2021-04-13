CREATE DATABASE DB1;

USE DB1;

CREATE TABLE Table1(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	isAdult NUMBER(1),
	age FLOAT
);

CREATE TABLE Table2(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	FOREIGN KEY name REFERENCES Table1(name)
);
SELECT name
,age
 FROM Table1 INNER JOIN
 Table2 ON Table1.name = Table2.name

SELECT name
,age
 FROM Table1 LEFT JOIN
 Table2 ON Table1.name = Table2.name

SELECT name
,age FROM Table1 GROUP BY age
 ORDER BY age
ASC
;

SELECT Table1.name
,age FROM Table1;

SELECT * FROM Table1;

SELECT name
 FROM Table2 GROUP BY age
 ORDER BY id
DESC
;

SELECT * FROM Table2;
