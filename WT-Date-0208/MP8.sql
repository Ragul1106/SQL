CREATE DATABASE university_course_dashboard;
USE university_course_dashboard;

-- 1. Create departments table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100)
);

-- 2. Create students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 3. Create courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(20),
    course_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 4. Create enrollments table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade INT,  -- NULL means dropped or incomplete
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert sample departments
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics');

-- Insert sample students
INSERT INTO students (student_id, student_name, dept_id) VALUES
(1, 'Alice', 1),
(2, 'Bob', 1),
(3, 'Charlie', 2),
(4, 'Diana', 3),
(5, 'Eve', 1),
(6, 'Frank', 2);

-- Insert sample courses
INSERT INTO courses (course_id, course_code, course_name, dept_id) VALUES
(101, 'CS101', 'Python Programming', 1),
(102, 'CS102', 'SQL Databases', 1),
(103, 'MA101', 'Calculus', 2),
(104, 'PH101', 'Mechanics', 3),
(105, 'CS103', 'Data Structures', 1);

-- Insert sample enrollments
INSERT INTO enrollments (enrollment_id, student_id, course_id, grade) VALUES
(1, 1, 101, 85),
(2, 1, 102, 78),
(3, 2, 101, 90),
(4, 2, 102, NULL), -- dropped
(5, 3, 103, 88),
(6, 4, 104, 45),
(7, 5, 101, NULL), -- dropped
(8, 6, 103, 72),
(9, 1, 105, 91),
(10, 2, 105, 82);

--  1. GROUP BY to get enrollment count per course
SELECT 
    c.course_name,
    COUNT(e.enrollment_id) AS total_enrolled
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- 2. Subquery in FROM: Find course with highest number of dropouts
SELECT 
    course_name,
    drop_count
FROM (
    SELECT 
        c.course_name,
        COUNT(*) AS drop_count
    FROM courses c
    JOIN enrollments e ON c.course_id = e.course_id
    WHERE e.grade IS NULL
    GROUP BY c.course_name
) AS sub
ORDER BY drop_count DESC
LIMIT 1;

-- 3. LEFT JOIN to find students not enrolled in any course
SELECT 
    s.student_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

--  4. CASE for pass/fail grade mapping
SELECT 
    s.student_name,
    c.course_name,
    e.grade,
    CASE 
        WHEN e.grade IS NULL THEN 'Dropped'
        WHEN e.grade >= 50 THEN 'Pass'
        ELSE 'Fail'
    END AS status
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

--  5. IN to filter courses by a list of codes
SELECT 
    course_name,
    course_code
FROM courses
WHERE course_code IN ('CS101', 'CS102', 'CS103');

--  6. INTERSECT to find students who completed both Python and SQL
SELECT student_id 
FROM enrollments 
WHERE course_id = 101 AND grade IS NOT NULL

INTERSECT

SELECT student_id 
FROM enrollments 
WHERE course_id = 102 AND grade IS NOT NULL;

