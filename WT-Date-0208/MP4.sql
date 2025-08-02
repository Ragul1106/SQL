-- Online Course Platform 

-- 1. Create database tables
CREATE DATABASE course_platform;
USE course_platform;

-- Create students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    registration_date DATE,
    country VARCHAR(50)
);

-- Create courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    duration_weeks INT,
    created_date DATE
);

-- Create enrollments table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    completion_status ENUM('in-progress', 'completed', 'dropped'),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Create grades table
CREATE TABLE grades (
    grade_id INT PRIMARY KEY,
    enrollment_id INT,
    score DECIMAL(5, 2),
    assignment_name VARCHAR(100),
    submission_date DATE,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);

-- 2. Insert sample data
-- Insert students
INSERT INTO students VALUES
(1001, 'John', 'Smith', 'john.smith@email.com', '2022-01-15', 'USA'),
(1002, 'Emily', 'Davis', 'emily.davis@email.com', '2022-03-22', 'UK'),
(1003, 'Michael', 'Johnson', 'michael.j@email.com', '2021-11-05', 'Canada'),
(1004, 'Sarah', 'Wilson', 'sarah.wilson@email.com', '2023-02-10', 'Australia'),
(1005, 'David', 'Brown', 'david.b@email.com', '2021-07-30', 'USA'),
(1006, 'Jessica', 'Taylor', 'jessica.t@email.com', '2023-01-05', 'UK'),
(1007, 'Daniel', 'Anderson', 'daniel.a@email.com', '2022-09-12', 'Germany'),
(1008, 'Olivia', 'Thomas', 'olivia.t@email.com', '2022-05-18', 'France'),
(1009, 'James', 'White', 'james.w@email.com', '2023-03-01', 'USA'),
(1010, 'Sophia', 'Lee', 'sophia.l@email.com', '2022-07-22', 'Japan');

-- Insert courses
INSERT INTO courses VALUES
(101, 'Introduction to Python', 'Dr. Alex Chen', 'Programming', 49.99, 8, '2021-09-10'),
(102, 'Data Science Fundamentals', 'Prof. Maria Garcia', 'Data Science', 79.99, 12, '2022-01-15'),
(103, 'Web Development Bootcamp', 'Sarah Johnson', 'Web Development', 99.99, 10, '2022-03-05'),
(104, 'Machine Learning Basics', 'Dr. Raj Patel', 'AI/ML', 89.99, 14, '2021-11-20'),
(105, 'Digital Marketing 101', 'Chris Wilson', 'Marketing', 59.99, 6, '2023-01-10'),
(106, 'Advanced SQL', 'Dr. Lisa Wong', 'Databases', 69.99, 8, '2022-05-15'),
(107, 'Cybersecurity Essentials', 'Mark Thompson', 'Security', 79.99, 10, '2022-07-01');

-- Insert enrollments
INSERT INTO enrollments VALUES
(5001, 1001, 101, '2023-01-10', 'completed'),
(5002, 1002, 102, '2023-01-15', 'completed'),
(5003, 1003, 103, '2023-02-05', 'in-progress'),
(5004, 1004, 101, '2023-02-20', 'completed'),
(5005, 1005, 104, '2023-03-01', 'completed'),
(5006, 1001, 106, '2023-03-15', 'in-progress'),
(5007, 1003, 107, '2023-04-02', 'in-progress'),
(5008, 1002, 104, '2023-04-10', 'completed'),
(5009, 1005, 105, '2023-05-05', 'completed'),
(5010, 1004, 107, '2023-05-20', 'in-progress'),
(5011, 1001, 102, '2023-06-01', 'completed'),
(5012, 1003, 104, '2023-06-15', 'completed'),
(5013, 1002, 101, '2023-07-01', 'in-progress'),
(5014, 1005, 103, '2023-07-10', 'in-progress'),
(5015, 1004, 105, '2023-08-05', 'completed'),
(5016, 1006, 101, '2023-01-15', 'completed'),
(5017, 1007, 102, '2023-02-10', 'completed'),
(5018, 1008, 103, '2023-03-05', 'in-progress'),
(5019, 1009, 104, '2023-04-01', 'completed'),
(5020, 1010, 105, '2023-05-10', 'completed');

-- Insert grades (adding 3 grades per enrollment for completed courses)
INSERT INTO grades VALUES
-- Grades for enrollment 5001 (Python)
(6001, 5001, 85.5, 'Module 1 Quiz', '2023-01-17'),
(6002, 5001, 92.0, 'Module 2 Project', '2023-01-24'),
(6003, 5001, 88.5, 'Final Exam', '2023-02-07'),

-- Grades for enrollment 5002 (Data Science)
(6004, 5002, 78.0, 'Data Analysis Assignment', '2023-01-22'),
(6005, 5002, 85.5, 'Machine Learning Project', '2023-02-05'),
(6006, 5002, 91.0, 'Capstone Project', '2023-02-12'),

-- Grades for enrollment 5004 (Python)
(6007, 5004, 92.5, 'Module 1 Quiz', '2023-02-27'),
(6008, 5004, 87.0, 'Module 2 Project', '2023-03-06'),
(6009, 5004, 95.0, 'Final Exam', '2023-03-13'),

-- Grades for enrollment 5005 (ML Basics)
(6010, 5005, 76.5, 'Linear Regression Assignment', '2023-03-08'),
(6011, 5005, 82.0, 'Classification Project', '2023-03-15'),
(6012, 5005, 88.5, 'Final Exam', '2023-03-22'),

-- Grades for enrollment 5008 (ML Basics)
(6013, 5008, 91.0, 'Linear Regression Assignment', '2023-04-17'),
(6014, 5008, 94.5, 'Classification Project', '2023-04-24'),
(6015, 5008, 89.0, 'Final Exam', '2023-05-01'),

-- Grades for enrollment 5009 (Digital Marketing)
(6016, 5009, 84.0, 'SEO Assignment', '2023-05-12'),
(6017, 5009, 79.5, 'Social Media Campaign', '2023-05-19'),
(6018, 5009, 87.0, 'Final Project', '2023-05-26'),

-- Grades for enrollment 5011 (Data Science)
(6019, 5011, 88.0, 'Data Analysis Assignment', '2023-06-08'),
(6020, 5011, 92.5, 'Machine Learning Project', '2023-06-15'),
(6021, 5011, 85.0, 'Capstone Project', '2023-06-22'),

-- Grades for enrollment 5012 (ML Basics)
(6022, 5012, 93.0, 'Linear Regression Assignment', '2023-06-22'),
(6023, 5012, 89.5, 'Classification Project', '2023-06-29'),
(6024, 5012, 97.0, 'Final Exam', '2023-07-06'),

-- Grades for enrollment 5015 (Digital Marketing)
(6025, 5015, 81.0, 'SEO Assignment', '2023-08-12'),
(6026, 5015, 84.5, 'Social Media Campaign', '2023-08-19'),
(6027, 5015, 90.0, 'Final Project', '2023-08-26'),

-- Grades for enrollment 5016 (Python)
(6028, 5016, 79.0, 'Module 1 Quiz', '2023-01-22'),
(6029, 5016, 85.5, 'Module 2 Project', '2023-01-29'),
(6030, 5016, 82.0, 'Final Exam', '2023-02-05'),

-- Grades for enrollment 5017 (Data Science)
(6031, 5017, 87.5, 'Data Analysis Assignment', '2023-02-17'),
(6032, 5017, 91.0, 'Machine Learning Project', '2023-02-24'),
(6033, 5017, 84.5, 'Capstone Project', '2023-03-03'),

-- Grades for enrollment 5019 (ML Basics)
(6034, 5019, 89.0, 'Linear Regression Assignment', '2023-04-08'),
(6035, 5019, 92.5, 'Classification Project', '2023-04-15'),
(6036, 5019, 95.0, 'Final Exam', '2023-04-22'),

-- Grades for enrollment 5020 (Digital Marketing)
(6037, 5020, 82.5, 'SEO Assignment', '2023-05-17'),
(6038, 5020, 88.0, 'Social Media Campaign', '2023-05-24'),
(6039, 5020, 91.5, 'Final Project', '2023-05-31');

-- 3. Analysis Queries

-- 1. Get list of students using SELECT, filter by course name
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email,
    e.enrollment_date
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Introduction to Python'
ORDER BY e.enrollment_date;

-- 2. Use INNER JOIN to show enrolled students with scores
SELECT 
    c.course_name,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    AVG(g.score) AS average_score,
    e.completion_status
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id
INNER JOIN grades g ON e.enrollment_id = g.enrollment_id
WHERE e.completion_status = 'completed'
GROUP BY c.course_name, student_name, e.completion_status
ORDER BY c.course_name, average_score DESC;

-- 3. CASE to assign grade categories (A/B/C)
SELECT 
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    AVG(g.score) AS average_score,
    CASE
        WHEN AVG(g.score) >= 90 THEN 'A'
        WHEN AVG(g.score) >= 80 THEN 'B'
        WHEN AVG(g.score) >= 70 THEN 'C'
        WHEN AVG(g.score) >= 60 THEN 'D'
        ELSE 'F'
    END AS grade_category
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN grades g ON e.enrollment_id = g.enrollment_id
WHERE e.completion_status = 'completed'
GROUP BY student_name, c.course_name
ORDER BY grade_category, average_score DESC;

-- 4. Use AVG() to get average marks per course
SELECT 
    c.course_name,
    COUNT(DISTINCT e.student_id) AS student_count,
    AVG(g.score) AS average_score,
    MAX(g.score) AS highest_score,
    MIN(g.score) AS lowest_score
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN grades g ON e.enrollment_id = g.enrollment_id
WHERE e.completion_status = 'completed'
GROUP BY c.course_name
ORDER BY average_score DESC;

-- 5. Use GROUP BY + HAVING to show only courses with more than 5 students
-- (Using 5 instead of 50 since our sample data is small)
SELECT 
    c.course_name,
    COUNT(DISTINCT e.student_id) AS student_count
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING student_count > 3
ORDER BY student_count DESC;

-- 6. Use IN to get students enrolled in specific courses
SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    e.enrollment_date
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_id IN (101, 102, 104) -- Python, Data Science, ML Basics
ORDER BY c.course_name, e.enrollment_date;

-- 7. Use a correlated subquery to get top student in each course
SELECT 
    c.course_name,
    CONCAT(s.first_name, ' ', s.last_name) AS top_student,
    top_grades.average_score
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN students s ON e.student_id = s.student_id
JOIN (
    SELECT 
        e.course_id,
        e.student_id,
        AVG(g.score) AS average_score
    FROM enrollments e
    JOIN grades g ON e.enrollment_id = g.enrollment_id
    WHERE e.completion_status = 'completed'
    GROUP BY e.course_id, e.student_id
) AS top_grades ON c.course_id = top_grades.course_id AND s.student_id = top_grades.student_id
WHERE (top_grades.course_id, top_grades.average_score) IN (
    SELECT 
        e.course_id,
        MAX(avg_score)
    FROM (
        SELECT 
            e.course_id,
            e.student_id,
            AVG(g.score) AS avg_score
        FROM enrollments e
        JOIN grades g ON e.enrollment_id = g.enrollment_id
        WHERE e.completion_status = 'completed'
        GROUP BY e.course_id, e.student_id
    ) AS course_avg
    GROUP BY e.course_id
)
ORDER BY c.course_name;
