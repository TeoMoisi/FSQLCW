CREATE DATABASE DB1;

USE DB1;

CREATE TABLE Table1(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	isAdult BOOLEAN,
	age FLOAT
);
INSERT INTO Table1 (id,name,age) VALUES (8,'Teofana Moisi',65);
INSERT INTO Table1 (id,name,isAdult) VALUES (9,'John',false), (9,'John',10,false);
DELETE FROM Table1 WHERE age=
1
 AND id<
6 OR name=
"Teofana"
;
UPDATE Table1
SET age=8
,name='Teo',address='Adr.1'
WHERE id>
8
 AND name=
"Teofana"
;
SELECT age
 FROM Table1 WHERE age<
20
 GROUP BY address
;

SELECT MIN( age ) FROM Table1 WHERE age>
20

SELECT COUNT( age ) FROM Table1 WHERE age<
20

SELECT SUM( age ) FROM Table1 WHERE age>
20

SELECT MIN(age) FROM Table1;

SELECT address
 FROM Table1 WHERE age>
10
 GROUP BY address
;

SELECT name
,age FROM Table1 ORDER BY age
ASC
;

SELECT name
,age FROM Table1 GROUP BY age
 ORDER BY age
ASC
;

SELECT Table1.name
,age FROM Table1;

SELECT * FROM Table1;

ALTER TABLE Table1
ADD col3 BOOLEAN;

ALTER TABLE Table1
ADD (col4 FLOAT,PRIMARY KEY (col3,col4),col5 INT);

ALTER TABLE Table1
DROP COLUMN col3;

ALTER TABLE Table1
DROP COLUMN (col4,col3);

ALTER TABLE Table1
MODIFY (col4 BOOLEAN,col5 VARCHAR(255));


CREATE TABLE Table2(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	FOREIGN KEY (name) REFERENCES Table1(name)
);
INSERT INTO Table2 (id,name) VALUES (8,'Andrew');
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

DELETE * FROM Table1;
DROP TABLE Table3;

UPDATE Table3
SET age=6
,name='John'
;
DROP TABLE Table3;

INSERT INTO Table1 (id,name,age,isAdult) VALUES (8,'John',65,true);
SELECT * FROM Table1;

ALTER TABLE Table1
ADD age INT;

SELECT name
,age FROM Table1 ORDER BY age
ASC
;

ALTER TABLE Table1
MODIFY (col4 BOOLEAN,col5 VARCHAR(255));
