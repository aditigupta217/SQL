use temp2;
DROP TABLE IF EXISTS STUDENT; 
CREATE TABLE STUDENT (
    STUDENT_ID INT PRIMARY KEY,
    NAME VARCHAR(100),
    DEPT_ID VARCHAR(10),
    MARKS INT,
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID)
);

CREATE TABLE DEPARTMENT(
DEPT_ID VARCHAR(10) PRIMARY KEY,
DEPT_NAME VARCHAR(20),
HOD VARCHAR(20)
);

CREATE TABLE EMPLOYEE(
EMP_ID INT PRIMARY KEY,
EMP_NAME VARCHAR(100),
DEPT_ID VARCHAR(10),
SALARY DECIMAL(10,2),
JOB_TITLE VARCHAR(50),
FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT (DEPT_ID)
);

INSERT INTO Department (Dept_ID, Dept_Name, HOD) VALUES
('CSE', 'Computer', 'Dr. Rao'),
('ECE', 'Electronics', 'Dr. Joshi'),
('MECH', 'Mechanical', 'Dr. Singh');

INSERT INTO Student (Student_ID, Name, Dept_ID, Marks) VALUES
(101, 'Ram', 'CSE', 82),
(102, 'Priya', 'ECE', 75),
(103, 'Ankit', 'CSE', 90),
(104, 'Shyam', 'MECH', 60);

INSERT INTO Employee (Emp_ID, Emp_Name, Dept_ID, Salary, Job_Title) VALUES
(201, 'Amit', 'CSE', 65000, 'Manager'),
(202, 'Ravi', 'ECE', 55000, 'Engineer'),
(203, 'Meera', 'CSE', 72000, 'Analyst'),
(204, 'Neha', 'MECH', 45000, 'Technician');

SELECT NAME,MARKS FROM STUDENT
WHERE MARKS > (SELECT AVG(MARKS) FROM STUDENT);

SELECT EMP_NAME,SALARY FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = 'Ravi');

SELECT DISTINCT Dept_Name
FROM Department
WHERE Dept_ID IN (
    SELECT Dept_ID
    FROM Employee
    WHERE Salary > 70000
);

SELECT S.Name, S.Marks, S.Dept_ID
FROM Student S
WHERE Marks > (
    SELECT AVG(Marks)
    FROM Student
    WHERE Dept_ID = S.Dept_ID
);

SELECT E.EMP_NAME, E.DEPT_ID,E.SALARY FROM EMPLOYEE AS E
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE WHERE DEPT_ID = E.DEPT_ID);

SELECT DISTINCT D.Dept_Name
FROM Department D
WHERE EXISTS (
    SELECT 1
    FROM Student S
    WHERE S.Dept_ID = D.Dept_ID
    AND S.Marks < (
        SELECT AVG(Marks)
        FROM Student
        WHERE Dept_ID = S.Dept_ID
    )
);

SELECT UPPER(NAME) AS UPPERCASE_NAME, LENGTH(NAME) AS LENGTHNAME
FROM STUDENT;

SELECT SUBSTRING(Emp_Name, 1, 3) AS Short_Name
FROM Employee;

SELECT CONCAT(Emp_Name, ' - ', Job_Title) AS Emp_Details
FROM Employee;

DROP VIEW IF EXISTS CSE_Students;

CREATE VIEW CSE_Students AS
SELECT Student_ID, Name, Marks
FROM Student
WHERE Dept_ID = 'CSE';

SELECT * FROM CSE_Students;

CREATE VIEW High_Salary_Employees AS
SELECT Emp_Name, Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

SELECT * FROM High_Salary_Employees;

CREATE VIEW MARKS_ABOVE AS
SELECT NAME, MARKS FROM STUDENT
WHERE MARKS > 80;

SELECT * FROM MARKS_ABOVE;


CREATE TABLE Customers(
Cust_ID INT PRIMARY KEY, 
Cust_Name VARCHAR(50),
 Email VARCHAR(50),
 City VARCHAR(30)
 );
 
 CREATE TABLE Products(
 Prod_ID INT PRIMARY KEY,
 Prod_Name VARCHAR(40),
 Category VARCHAR(50),
 Price DECIMAL(10,2),
 Stock INT
 );
 
 CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Cust_ID INT,
    Order_Date DATE,
    Total_Amount DECIMAL(10,2),
    FOREIGN KEY (Cust_ID) REFERENCES Customers(Cust_ID)
);

CREATE TABLE Order_Details (
    Order_ID INT,
    Prod_ID INT,
    Quantity INT,
    PRIMARY KEY (Order_ID, Prod_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Prod_ID) REFERENCES Products(Prod_ID)
);

INSERT INTO Customers (Cust_ID, Cust_Name, Email, City) VALUES
(1, 'Aditi Gupta', 'aditi@gmail.com', 'Delhi'),
(2, 'Rohit Sharma', 'rohit@yahoo.com', 'Mumbai'),
(3, 'Neha Singh', 'neha@gmail.com', 'Delhi'),
(4, 'Vikram Patel', 'vikram@hotmail.com', 'Chennai'),
(5, 'Priya Verma', 'priya@gmail.com', 'Delhi');

 INSERT INTO Products (Prod_ID, Prod_Name, Category, Price, Stock) VALUES
(1, 'iPhone 14', 'Mobile', 90000, 50),
(2, 'Samsung Galaxy S23', 'Mobile', 85000, 40),
(3, 'Dell Laptop', 'Electronics', 60000, 20),
(4, 'HP Printer', 'Electronics', 12000, 15),
(5, 'Logitech Mouse', 'Accessories', 1500, 100);
 
 INSERT INTO Orders (Order_ID, Cust_ID, Order_Date, Total_Amount) VALUES
(101, 1, '2025-09-01', 95000),
(102, 2, '2025-09-05', 85000),
(103, 3, '2025-09-07', 13000),
(104, 4, '2025-09-10', 12000),
(105, 5, '2025-09-12', 155000);

INSERT INTO Order_Details (Order_ID, Prod_ID, Quantity) VALUES
(101, 1, 1),
(102, 2, 1),
(103, 4, 1),
(104, 3, 1),
(105, 1, 1),
(105, 5, 5);

 #1. Find all products whose price is higher than the average price of all products.
 
 SELECT * FROM Products
 WHERE Price > (SELECT AVG(Price) FROM Products );

SELECT DISTINCT c.Cust_ID, c.Cust_Name, c.Email, c.City
FROM Customers c
JOIN Orders o ON c.Cust_ID = o.Cust_ID
WHERE o.Total_Amount > 10000;

SELECT DISTINCT c.Cust_ID, c.Cust_Name, c.City
FROM Customers c
JOIN Orders o ON c.Cust_ID = o.Cust_ID
WHERE o.Total_Amount > (
    SELECT AVG(o2.Total_Amount)
    FROM Orders o2
    JOIN Customers c2 ON o2.Cust_ID = c2.Cust_ID
    WHERE c2.City = c.City
);

SELECT UPPER(Cust_Name) AS Customer_name, LENGTH(Cust_Name) AS Name_length 
FROM Customers;

SELECT SUBSTRING(Email, LOCATE('@', Email) + 1) AS Domain
FROM Customers;

SELECT REPLACE(Prod_Name, 'Phone', 'Mobile') AS Updated_Prod_Name
FROM Products;

CREATE VIEW Customer_Order_View AS
SELECT c.Cust_Name, p.Prod_Name, od.Quantity, o.Total_Amount
FROM Customers c
JOIN Orders o ON c.Cust_ID = o.Cust_ID
JOIN Order_Details od ON o.Order_ID = od.Order_ID
JOIN Products p ON od.Prod_ID = p.Prod_ID;

CREATE VIEW Top5_Expensive_Products AS
SELECT *
FROM Products
ORDER BY Price DESC
LIMIT 5;

CREATE VIEW Delhi_Customers_Orders AS
SELECT c.Cust_ID, c.Cust_Name, o.Order_ID, o.Order_Date, o.Total_Amount
FROM Customers c
JOIN Orders o ON c.Cust_ID = o.Cust_ID
WHERE c.City = 'Delhi';

