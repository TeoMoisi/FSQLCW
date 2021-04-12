
CREATE TABLE Table1(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	isAdult NUMBER(1),
	age INT
);

CREATE TABLE Table2(
	id INT PRIMARY KEY,
	name VARCHAR(255),
	FOREIGN KEY name REFERENCES Table1(name)
);

CREATE TABLE Table3(
	address VARCHAR(255),
	name VARCHAR(255),
	city VARCHAR(255),
	PRIMARY KEY (address,name,city)
);
