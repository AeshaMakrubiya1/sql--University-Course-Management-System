CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    Email VARCHAR(50),
    BirthDate DATE,
    EnrollmentDate DATE
);
INSERT INTO Students VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '2000-05-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '1999-11-20', '2021-08-01');

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Department INT,
    Credits INT
);

INSERT INTO Courses VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data structures', 2, 4);

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE,
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);
INSERT INTO Instructors VALUES
(1, 'Alice', 'Johnson', '2018-09-15', 1,80000),
(2, 'Bob', 'Lee', '2019-03-20', 2, 75000);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE
);

INSERT INTO Enrollments VALUES
(1,1,101,'2022-08-01'),
(2,2,102,'2021-08-01');


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);  

INSERT INTO Departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics');


INSERT INTO Students VALUES (3, 'Mark', 'Taylor', 'mark@email.com', '2001-02-02', '2023-01-01');
UPDATE Students SET Email = 'mark.taylor@email.com' WHERE StudentID = 3;
DELETE FROM Students WHERE StudentID = 3;
SELECT * FROM Students;


SELECT * FROM Students WHERE EnrollmentDate > '2022-01-01';

SELECT * FROM Courses
WHERE DepartmentID = 2
LIMIT 5;

SELECT CourseID, COUNT(StudentID) AS StudentCount
FROM Enrollments
GROUP BY CourseID
HAVING COUNT(StudentID) > 5;


SELECT StudentID
FROM Enrollments
WHERE CourseID IN (101, 102)
GROUP BY StudentID
HAVING COUNT(DISTINCT CourseID) = 2;

SELECT DISTINCT StudentID
FROM Enrollments
WHERE CourseID IN (101,102);


SELECT AVG(Credits) AS AverageCredits
FROM Courses;


SELECT MAX(Salary)
FROM Instructors
WHERE DepartmentID = 1;

SELECT d.DepartmentName, COUNT(e.StudentID) AS StudentCount
FROM Departments d
JOIN Courses c ON d.DepartmentID = c.DepartmentID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY d.DepartmentName;

SELECT s.FirstName, s.LastName, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

SELECT s.FirstName, c.CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID;

SELECT StudentID
FROM Enrollments
WHERE CourseID IN (
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(StudentID) >10
);

SELECT StudentID, YEAR(EnrollmentDate) AS EnrollmentYear
FROM Enrollments;

SELECT CONCAT(FirstName, ' ', LastName) AS InstructorName
FROM Instructors;


SELECT CourseID,
SUM(COUNT(StudentID)) OVER (ORDER BY CourseID) AS RunningTotal
FROM Enrollments
GROUP BY CourseID;

SELECT StudentID,
CASE 
    WHEN EnrollmentDATE < DATE_SUB(CURDATE(), INTERVAL 4 YEAR) THEN 'Senior'
    ELSE 'Junior'
END AS Status
FROM Students;