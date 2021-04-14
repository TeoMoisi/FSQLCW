CREATE DATABASE FSQLTEST;

USE FSQLTEST;

CREATE TABLE Users(
	userId INT PRIMARY KEY,
	name VARCHAR(255),
	age INT,
	isAdult BOOLEAN
);

CREATE TABLE Posts(
	postId INT PRIMARY KEY,
	userId INT,
	FOREIGN KEY (userId) REFERENCES Users(userId),
	content VARCHAR(255)
);
ALTER TABLE Users
ADD (city VARCHAR(255),occupation VARCHAR(255));

ALTER TABLE Users
DROP COLUMN occupation;

INSERT INTO Users (userId,name,age,isAdult,city) VALUES (1,'John Doe',16,false,'London'), (2,'Jane Doe',20,true,'London'), (3,'Jonny Doe',20,true,'Liverpool'), (4,'Mark Doe',22,true,'London'), (5,'Steve Doe',35,true,'London');
SELECT name
,city FROM Users WHERE age>=
20

DELETE FROM Users WHERE age<
20
 AND city=
"London"
;
SELECT postId
,userId,content
 FROM Users INNER JOIN
 Posts ON Posts.postId = Users.userId

UPDATE Users
SET city='LONDON'
,
WHERE city=
"London"
;
SELECT name
,age FROM Users GROUP BY city
HAVING age>=
20
 ORDER BY age
ASC
;
