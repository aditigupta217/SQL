USE XYZ;

DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department(
DeptID INT PRIMARY KEY,
DeptName VARCHAR(20)
);

CREATE TABLE Employee(
EmpID INT PRIMARY KEY,
EmpName VARCHAR(50),
Salary DECIMAL(10,2),
DeptID INT,
FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

INSERT INTO Department VALUES (1, 'HR'), (2, 'IT'), (3, 'Finance');

INSERT INTO Employee VALUES (101, 'Aditi', 60000, 2);
INSERT INTO Employee VALUES (102, 'Rahul', 45000, 1);
INSERT INTO Employee VALUES (103, 'Neha', 75000, 3);

ALTER TABLE Employee
ADD Status VARCHAR(20) DEFAULT 'Active';

ALTER TABLE Employee
ADD CONSTRAINT chk_salary CHECK (Salary > 20000);

ALTER TABLE Employee
ADD CONSTRAINT unique_empname UNIQUE (EmpName);

ALTER TABLE Employee
DROP CONSTRAINT chk_salary;

SELECT * FROM Employee;
SELECT * FROM Department;

-- INNER JOIN
SELECT e.EmpName, e.Salary, d.DeptName
FROM Employee e
INNER JOIN Department d ON e.DeptID = d.DeptID;

-- LEFT JOIN
SELECT d.DeptName, e.EmpName, e.Salary
FROM Department d
LEFT JOIN Employee e ON d.DeptID = e.DeptID;

-- RIGHT JOIN
SELECT e.EmpName, e.Salary, d.DeptName
FROM Employee e
RIGHT JOIN Department d ON e.DeptID = d.DeptID;

ALTER TABLE Employee
ADD ManagerID INT NULL;

ALTER TABLE Employee
ADD CONSTRAINT fk_manager FOREIGN KEY (ManagerID) REFERENCES Employee(EmpID);


INSERT INTO Employee (EmpID, EmpName, Salary, DeptID, ManagerID)
VALUES (101, 'Rahul', 90000, 1, NULL);

INSERT INTO Employee (EmpID, EmpName, Salary, DeptID, ManagerID)
VALUES (102, 'Aditi', 60000, 2, 101);

INSERT INTO Employee (EmpID, EmpName, Salary, DeptID, ManagerID)
VALUES (103, 'Neha', 50000, 2, 101);

INSERT INTO Employee (EmpID, EmpName, Salary, DeptID, ManagerID)
VALUES (104, 'Meera', 40000, 3, 102);


-- Average salary department-wise
SELECT d.DeptName, AVG(e.Salary) AS AvgSalary
FROM Employee e
JOIN Department d ON e.DeptID = d.DeptID
GROUP BY d.DeptName;

-- HAVING average > 50000
SELECT d.DeptName, AVG(e.Salary) AS AvgSalary
FROM Employee e
JOIN Department d ON e.DeptID = d.DeptID
GROUP BY d.DeptName
HAVING AVG(e.Salary) > 50000;

-- Subquery: salary greater than average
SELECT EmpName, Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

DELETE FROM Employee WHERE EmpID > 0;


INSERT INTO Employee (EmpID, EmpName, Salary, DeptID, ManagerID)
VALUES (101, 'Rahul', 90000, 1, NULL);

INSERT INTO Employee (EmpID, EmpName, Salary, DeptID, ManagerID)
VALUES (102, 'Aditi', 60000, 2, 101),
       (103, 'Neha', 50000, 2, 101);

INSERT INTO Employee (EmpID, EmpName, Salary, DeptID, ManagerID)
VALUES (104, 'Meera', 40000, 3, 102);

SELECT e.EmpName AS Employee, m.EmpName AS Manager
FROM Employee e
INNER JOIN Employee m ON e.ManagerID = m.EmpID;
