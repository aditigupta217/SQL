-- Create Database
CREATE DATABASE IF NOT EXISTS ADITI;
USE ADITI;

-- Drop tables if they exist (to avoid conflicts while testing)
DROP TABLE IF EXISTS COURSE;
DROP TABLE IF EXISTS DEPARTMENT;
DROP TABLE IF EXISTS INSTRUCTOR;

-- Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL UNIQUE
);

-- Create INSTRUCTOR table
CREATE TABLE INSTRUCTOR (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(50) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID)
);

-- Create COURSE table
CREATE TABLE COURSE (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50) NOT NULL UNIQUE,
    Credits INT CHECK (Credits > 0),
    DeptID INT,
    InstructorID INT,
    FOREIGN KEY (DeptID) REFERENCES DEPARTMENT(DeptID),
    FOREIGN KEY (InstructorID) REFERENCES INSTRUCTOR(InstructorID)
);

-- Insert sample data into DEPARTMENT
INSERT INTO DEPARTMENT VALUES 
(1, 'Computer Science'),
(2, 'Electrical'),
(3, 'Mechanical');

-- Insert sample data into INSTRUCTOR
INSERT INTO INSTRUCTOR VALUES 
(10, 'Dr. Sharma', 1),
(11, 'Dr. Verma', 2),
(12, 'Dr. Iyer', 3);

-- Insert sample data into COURSE
INSERT INTO COURSE VALUES 
(101, 'DBMS', 4, 1, 10),
(102, 'Networks', 3, 1, 11),
(103, 'Thermodynamics', 5, 3, 12);

-- Check data
SELECT * FROM DEPARTMENT;
SELECT * FROM INSTRUCTOR;
SELECT * FROM COURSE;
