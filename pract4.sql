--- Drop database if already exists
DROP DATABASE IF EXISTS ADITI;

-- Create new database
CREATE DATABASE ADITI;
USE ADITI;

-- ===========================
-- Step 1: Create DEPARTMENT
-- ===========================
CREATE TABLE DEPARTMENT(
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(50) NOT NULL
);

-- ===========================
-- Step 2: Create STUDENT
-- ===========================
CREATE TABLE STUDENT(
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Marks INT CHECK (Marks BETWEEN 0 AND 100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
        ON DELETE CASCADE
);

-- ===========================
-- Step 3: Create COURSE
-- ===========================
CREATE TABLE COURSE(
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50) NOT NULL UNIQUE,
    Credits INT CHECK (Credits BETWEEN 1 AND 5),
    StudentID INT,
    FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID)
        ON DELETE CASCADE,
    DeptID INT NULL,   -- ✅ Allow NULL because ON DELETE SET NULL
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
        ON DELETE SET NULL
);

-- ===========================
-- Step 4: Insert sample data
-- ===========================
INSERT INTO DEPARTMENT VALUES 
(10, 'CSE', 'RBU'),
(20, 'ECE', 'RBU');

INSERT INTO STUDENT VALUES 
(1, 'Aditi', 'aditi@gmail.com', 85, 10);

INSERT INTO COURSE VALUES 
(101, 'DBMS', 4, 1, 10);

-- ===========================
-- Step 5: Check data
-- ===========================
SELECT * FROM DEPARTMENT;
SELECT * FROM STUDENT;
SELECT * FROM COURSE;
