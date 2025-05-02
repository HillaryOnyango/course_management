-- Creating the course_management database
CREATE DATABASE course_management;


-- Creating Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE NOT NULL
);

-- Creating Instructors table
CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Creating Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

-- Creating Enrollments table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Inserting sample data into Students
INSERT INTO Students (student_id, first_name, last_name, email, date_of_birth) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@email.com', '2000-03-15'),
(2, 'Bob', 'Smith', 'bob.smith@email.com', '1999-07-22'),
(3, 'Carol', 'Williams', 'carol.williams@email.com', '2001-01-10'),
(4, 'David', 'Brown', 'david.brown@email.com', '2000-11-30'),
(5, 'Emma', 'Jones', 'emma.jones@email.com', '1998-05-18'),
(6, 'Frank', 'Garcia', 'frank.garcia@email.com', '2002-02-25'),
(7, 'Grace', 'Miller', 'grace.miller@email.com', '2001-09-12'),
(8, 'Henry', 'Davis', 'henry.davis@email.com', '1999-12-05'),
(9, 'Isabella', 'Martinez', 'isabella.martinez@email.com', '2000-06-20'),
(10, 'James', 'Wilson', 'james.wilson@email.com', '2001-04-08');

-- Inserting sample data into Instructors
INSERT INTO Instructors (instructor_id, first_name, last_name, email) VALUES
(1, 'John', 'Smith', 'john.smith@email.com'),
(2, 'Mary', 'Johnson', 'mary.johnson@email.com'),
(3, 'Robert', 'Lee', 'robert.lee@email.com');

-- Inserting sample data into Courses
INSERT INTO Courses (course_id, course_name, course_description, instructor_id) VALUES
(1, 'Database Systems', 'Introduction to relational databases', 1),
(2, 'Web Development', 'Building modern web applications', 2),
(3, 'Data Structures', 'Fundamental data structures and algorithms', 1),
(4, 'Machine Learning', 'Intro to ML concepts', 3),
(5, 'Software Engineering', 'Software development methodologies', 2);

-- Inserting sample data into Enrollments
INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade) VALUES
(1, 1, 1, '2025-01-10', 'A'),
(2, 1, 2, '2025-01-10', 'B'),
(3, 2, 1, '2025-01-10', 'C'),
(4, 2, 3, '2025-01-10', 'F'),
(5, 3, 2, '2025-01-10', 'A'),
(6, 3, 3, '2025-01-10', 'B'),
(7, 3, 4, '2025-01-10', 'A'),
(8, 4, 1, '2025-01-10', 'F'),
(9, 5, 2, '2025-01-10', 'B'),
(10, 5, 4, '2025-01-10', 'A'),
(11, 6, 3, '2025-01-10', 'C'),
(12, 7, 1, '2025-01-10', 'A'),
(13, 7, 2, '2025-01-10', 'F'),
(14, 8, 4, '2025-01-10', 'B'),
(15, 9, 5, '2025-01-10', 'A');

-- Query 1: Students who enrolled in at least one course
SELECT DISTINCT s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id;

-- Query 2: Students enrolled in more than two courses
SELECT s.first_name, s.last_name, COUNT(e.course_id) as course_count
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) > 2;

-- Query 3: Courses with total enrolled students
SELECT c.course_name, COUNT(e.student_id) as total_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- Query 4: Average grade per course
SELECT c.course_name, 
       AVG(CASE 
           WHEN e.grade = 'A' THEN 4
           WHEN e.grade = 'B' THEN 3
           WHEN e.grade = 'C' THEN 2
           WHEN e.grade = 'D' THEN 1
           WHEN e.grade = 'F' THEN 0
           ELSE NULL
       END) as avg_grade
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- Query 5: Students who haven’t enrolled in any course
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- Query 6: Students with their average grade across all courses
SELECT s.first_name, s.last_name,
       AVG(CASE 
           WHEN e.grade = 'A' THEN 4
           WHEN e.grade = 'B' THEN 3
           WHEN e.grade = 'C' THEN 2
           WHEN e.grade = 'D' THEN 1
           WHEN e.grade = 'F' THEN 0
           ELSE NULL
       END) as avg_grade
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name;

-- Query 7: Instructors with the number of courses they teach
SELECT i.first_name, i.last_name, COUNT(c.course_id) as course_count
FROM Instructors i
LEFT JOIN Courses c ON i.instructor_id = c.instructor_id
GROUP BY i.instructor_id, i.first_name, i.last_name;

-- Query 8: Students enrolled in a course taught by “John Smith”
SELECT DISTINCT s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Instructors i ON c.instructor_id = i.instructor_id
WHERE i.first_name = 'John' AND i.last_name = 'Smith';

-- Query 9: Top 3 students by average grade
SELECT s.first_name, s.last_name,
       AVG(CASE 
           WHEN e.grade = 'A' THEN 4
           WHEN e.grade = 'B' THEN 3
           WHEN e.grade = 'C' THEN 2
           WHEN e.grade = 'D' THEN 1
           WHEN e.grade = 'F' THEN 0
           ELSE NULL
       END) as avg_grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY avg_grade DESC
LIMIT 3;

-- Query 10: Students failing (grade = ‘F’) in more than one course
SELECT s.first_name, s.last_name, COUNT(e.grade) as failing_courses
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.grade = 'F'
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.grade) > 1;

-- Creating VIEW for student course summary
CREATE VIEW student_course_summary AS
SELECT s.first_name, s.last_name, c.course_name, e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- Creating INDEX on Enrollments.student_id
CREATE INDEX idx_student_id ON Enrollments(student_id);

-- Creating table for enrollment logs
CREATE TABLE Enrollment_Logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    enrollment_id INT,
    student_id INT,
    course_id INT,
    log_date DATETIME,
    action VARCHAR(50)
);

-- Creating trigger for logging new enrollments
CREATE OR REPLACE FUNCTION log_enrollment_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Enrollment_Logs (enrollment_id, student_id, course_id, log_date, action)
    VALUES (NEW.enrollment_id, NEW.student_id, NEW.course_id, NOW(), 'NEW_ENROLLMENT');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_new_enrollment
AFTER INSERT ON Enrollments
FOR EACH ROW
EXECUTE FUNCTION log_enrollment_insert();

-- Query information about triggers on a specific table
SELECT 
    tgname AS trigger_name,
    tgrelid::regclass AS table_name,
    tgenabled AS enabled,
    tgtype AS type,
    proname AS function_name
FROM pg_trigger
JOIN pg_proc ON pg_trigger.tgfoid = pg_proc.oid
WHERE tgrelid = 'Enrollments'::regclass
  AND tgname = 'log_new_enrollment';

