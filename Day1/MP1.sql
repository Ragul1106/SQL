CREATE DATABASE school_db;
USE school_db;
CREATE TABLE students(
student_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE,
date_of_birth DATE,
enrollment_date DATE DEFAULT (CURRENT_DATE));

CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE,
    department VARCHAR(50)
);

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    credit_hours INT DEFAULT 3,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    grade DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE (student_id, course_id)
);

INSERT INTO teachers (first_name, last_name, email, hire_date, department) VALUES
('John', 'Smith', 'john.smith@school.edu', '2010-08-15', 'Mathematics'),
('Sarah', 'Johnson', 'sarah.j@school.edu', '2015-03-22', 'Science'),
('Michael', 'Williams', 'michael.w@school.edu', '2012-09-10', 'History'),
('Emily', 'Brown', 'emily.b@school.edu', '2018-01-05', 'English'),
('David', 'Jones', 'david.j@school.edu', '2008-11-30', 'Computer Science'),
('Jennifer', 'Garcia', 'jennifer.g@school.edu', '2019-04-18', 'Art'),
('Robert', 'Miller', 'robert.m@school.edu', '2014-07-25', 'Physical Education'),
('Lisa', 'Davis', 'lisa.d@school.edu', '2016-02-14', 'Music'),
('Thomas', 'Rodriguez', 'thomas.r@school.edu', '2011-10-08', 'Foreign Languages'),
('Patricia', 'Martinez', 'patricia.m@school.edu', '2017-06-12', 'Science'),
('James', 'Hernandez', 'james.h@school.edu', '2013-09-01', 'Mathematics');

INSERT INTO courses (course_name, course_code, credit_hours, teacher_id) VALUES
('Algebra I', 'MATH101', 4, 1),
('Biology', 'SCI201', 3, 2),
('World History', 'HIST301', 3, 3),
('English Literature', 'ENG101', 3, 4),
('Introduction to Programming', 'CS101', 4, 5),
('Drawing Fundamentals', 'ART105', 2, 6),
('Physical Education', 'PE102', 1, 7),
('Music Theory', 'MUS201', 3, 8),
('Spanish I', 'LANG101', 3, 9),
('Chemistry', 'SCI202', 4, 10),
('Geometry', 'MATH102', 4, 11),
('Creative Writing', 'ENG202', 3, 4);

INSERT INTO students (first_name, last_name, email, date_of_birth, enrollment_date) VALUES
('Emma', 'Wilson', 'emma.w@student.edu', '2005-03-15', '2022-09-01'),
('Noah', 'Taylor', 'noah.t@student.edu', '2005-07-22', '2022-09-01'),
('Olivia', 'Anderson', 'olivia.a@student.edu', '2005-01-30', '2022-09-01'),
('Liam', 'Thomas', 'liam.t@student.edu', '2005-11-08', '2022-09-01'),
('Ava', 'Jackson', 'ava.j@student.edu', '2005-05-19', '2022-09-01'),
('William', 'White', 'william.w@student.edu', '2005-09-12', '2022-09-01'),
('Sophia', 'Harris', 'sophia.h@student.edu', '2005-04-25', '2022-09-01'),
('Benjamin', 'Martin', 'benjamin.m@student.edu', '2005-08-03', '2022-09-01'),
('Isabella', 'Thompson', 'isabella.t@student.edu', '2005-02-14', '2022-09-01'),
('Mason', 'Garcia', 'mason.g@student.edu', '2005-06-28', '2022-09-01'),
('Charlotte', 'Martinez', 'charlotte.m@student.edu', '2005-10-17', '2022-09-01'),
('Elijah', 'Robinson', 'elijah.r@student.edu', '2005-12-05', '2022-09-01');

INSERT INTO enrollments (student_id, course_id, grade) VALUES
-- Emma Wilson
(1, 1, 92.5), (1, 2, 88.0), (1, 4, 95.0),
-- Noah Taylor
(2, 1, 85.0), (2, 5, 90.5), (2, 7, 100.0),
-- Olivia Anderson
(3, 2, 94.0), (3, 3, 89.5), (3, 9, 91.0),
-- Liam Thomas
(4, 4, 87.0), (4, 6, 92.0), (4, 8, 88.5),
-- Ava Jackson
(5, 5, 93.0), (5, 10, 89.0), (5, 12, 96.0),
-- William White
(6, 1, 84.5), (6, 3, 91.0), (6, 11, 86.0),
-- Sophia Harris
(7, 2, 90.0), (7, 4, 93.5), (7, 7, 100.0),
-- Benjamin Martin
(8, 5, 88.0), (8, 8, 92.5), (8, 10, 87.0),
-- Isabella Thompson
(9, 6, 95.0), (9, 9, 89.0), (9, 12, 94.0),
-- Mason Garcia
(10, 3, 86.5), (10, 7, 100.0), (10, 11, 90.0),
-- Charlotte Martinez (no enrollments - left empty)
-- Elijah Robinson
(12, 1, 91.0), (12, 4, 93.0), (12, 10, 88.5);

INSERT INTO students (first_name, last_name, email, date_of_birth) 
VALUES ('Ethan', 'Clark', 'ethan.c@student.edu', '2005-04-10');

SELECT * FROM students WHERE last_name = 'Wilson';

INSERT INTO enrollments (student_id, course_id) 
VALUES (11, 2); -- Enroll Charlotte Martinez in Biology

UPDATE teachers 
SET department = 'Science' 
WHERE teacher_id = 1;

DELETE FROM enrollments 
WHERE student_id = 5 AND course_id = 10;

SELECT 
    c.course_name,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email
FROM 
    courses c
JOIN 
    enrollments e ON c.course_id = e.course_id
JOIN 
    students s ON e.student_id = s.student_id
ORDER BY 
    c.course_name, s.last_name, s.first_name;
    
SELECT 
    c.course_name,
    COUNT(e.student_id) AS student_count
FROM 
    courses c
LEFT JOIN 
    enrollments e ON c.course_id = e.course_id
GROUP BY 
    c.course_name
ORDER BY 
    student_count DESC, c.course_name;

SELECT 
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.email
FROM 
    students s
LEFT JOIN 
    enrollments e ON s.student_id = e.student_id
WHERE 
    e.enrollment_id IS NULL;
