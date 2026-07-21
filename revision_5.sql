CREATE TABLE admin_users (
id INT PRIMARY KEY,
 name VARCHAR(100),
 email VARCHAR(100),
 gender ENUM('Male', 'Female', 'Other'),
 date_of_birth DATE,
 salary INT
);

INSERT INTO admin_users (id, name, email, gender, date_of_birth, salary) VALUES
(101, 'Anil Kumar', 'anil@example.com', 'Male', '1985-04-12', 60000),
(102, 'Pooja Sharma', 'pooja@example.com', 'Female', '1992-09-20', 58000),
(103, 'Rakesh Yadav', 'rakesh@example.com', 'Male', '1989-11-05', 54000),
(104, 'Fatima Begum', 'fatima@example.com', 'Female', '1990-06-30', 62000);

select * from admin_users;

SELECT NAME FROM USERS
UNION 
SELECT NAME FROM ADMIN_USERS;

ALTER TABLE USERS 
ADD column REFERRED_BY_ID INT;

update USERS SET REFERRED_BY_ID = 1 WHERE ID IN (1,2,3,4,5,7,8,9);
SELECT * FROM USERS;

UPDATE USERS SET REFERRED_BY_ID = 2 WHERE ID IN (11,12);

SELECT 
a.id,
a.name as user_name,
b.name as referred_name
from users a
inner join users b on a.referred_by_id = b.id;

CREATE VIEW rich_users AS 
SELECT * from users where salary > 70000;

select * from rich_users;

show indexes from users;

-- subqueries 
SELECT AVG(salary) FROM users;

SELECT * FROM users WHERE salary > (SELECT AVG(salary) FROM users);

SELECT id,name,referred_by_id FROM users
WHERE referred_by_id IN(
SELECT ID FROM users WHERE salary > 62000);

-- Group by and Having 
SELECT gender, AVG(salary) AS 'Average Salary' , COUNT(*) AS 'Count'
FROM users WHERE id < 100 GROUP BY gender;

SELECT gender, AVG(salary) AS 'Average Salary' , COUNT(*) AS 'Count'
FROM users WHERE id < 100 GROUP BY gender WITH ROLLUP
HAVING AVG(salary)<65000 ; -- where use before group by , and having after group by

SELECT REFERRED_BY_ID, COUNT(*) AS 'TOTAL_REFERRED' FROM USERS 
WHERE REFERRED_BY_ID IS NOT NULL
GROUP BY REFERRED_BY_ID 
HAVING COUNT(*) > 1;


