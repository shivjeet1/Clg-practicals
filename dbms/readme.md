# SQL Commands

## Connect as system
```
Connect system
Password: cse123
```

## Create user
```
Create user <username> identified by <password>;
```

## Grant privileges
```
grant Create user, Create session, Connect, resources, Create table to <username>;
```

## Connect as new user
```
Connect r382/r382;
```

## Select from a table
```
select * from <table>;
```

## Create table
```
Create table test(
  rn number,
  name varchar(20),
  sub1 number,
  sub2 number
);
```

## Alter table
```
Alter table test add sub3 number;
```

## Insert into table
```
insert into test values (1, 'ram', 56, 78, 78);
```

## Show table
```
select * from test;
```


## Commonly Used SQL Commands

### Insert Example
```
INSERT INTO test (rn, name, sub1, sub2, sub3)
VALUES (2, 'john', 67, 89, 76);
```

### Join Example
```
SELECT a.rn, a.name, b.total_marks
FROM test a
JOIN marks b ON a.rn = b.rn;
```

### Group By Example
```
SELECT name, AVG(sub1) AS avg_marks
FROM test
GROUP BY name;
```

### Order By Example
```
SELECT * FROM test
ORDER BY sub1 DESC;
```

### Aggregate Functions
```
SELECT COUNT(*) AS total_students,
       MAX(sub1) AS max_marks,
       MIN(sub1) AS min_marks,
       AVG(sub1) AS avg_marks
FROM test;
```


## Advanced SQL Examples

### Subquery Example
```
SELECT name, sub1
FROM test
WHERE sub1 > (SELECT AVG(sub1) FROM test);
```

### Constraints Example
```
CREATE TABLE student (
  rn NUMBER PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  age NUMBER CHECK (age > 0)
);
```

### View Example
```
CREATE VIEW test_view AS
SELECT name, (sub1 + sub2 + sub3) AS total_marks
FROM test;
```

### Trigger Example
```
CREATE OR REPLACE TRIGGER test_trigger
BEFORE INSERT ON test
FOR EACH ROW
BEGIN
  :NEW.sub3 := NVL(:NEW.sub3, 0);
END;
/
```

### Update Example
```
UPDATE test
SET sub1 = 90
WHERE rn = 1;
```

### Delete Example
```
DELETE FROM test
WHERE rn = 2;
```

### Drop Table Example
```
DROP TABLE test;
```


## Detailed Joins

### Inner Join
```
SELECT t1.rn, t1.name, t2.total_marks
FROM test t1
INNER JOIN marks t2 ON t1.rn = t2.rn;
```

### Left Join
```
SELECT t1.rn, t1.name, t2.total_marks
FROM test t1
LEFT JOIN marks t2 ON t1.rn = t2.rn;
```

### Right Join
```
SELECT t1.rn, t1.name, t2.total_marks
FROM test t1
RIGHT JOIN marks t2 ON t1.rn = t2.rn;
```

### Full Join
```
SELECT t1.rn, t1.name, t2.total_marks
FROM test t1
FULL OUTER JOIN marks t2 ON t1.rn = t2.rn;
```

## Normalization

### 1NF (First Normal Form)
- Ensure the table has atomic values
- No repeating groups
Example:
```
rn | name | sub1 | sub2 | sub3
```

### 2NF (Second Normal Form)
- Must be in 1NF
- No partial dependency on a composite key

### 3NF (Third Normal Form)
- Must be in 2NF
- No transitive dependencies between attributes

Normalization improves:
- Data integrity
- Avoids redundancy
- Simplifies maintenance
