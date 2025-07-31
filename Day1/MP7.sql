CREATE DATABASE course_portal;
USE course_portal;

CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT, -- Use SERIAL for PostgreSQL
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE courses (
course_ID INT auto_increment primary key,
course_name VARCHAR(100) not null unique,
description text,
instructor_id INT, 
FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) ON DELETE SET NULL 
);

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT, -- Use SERIAL for PostgreSQL
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    enrollment_date DATE
);

CREATE TABLE registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT, 
    student_id INT,
    course_id INT,
    registration_date DATE NOT NULL,
    UNIQUE (student_id, course_id), 
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

INSERT INTO instructors (first_name, last_name, email) VALUES
('Alice', 'Smith', 'alice.smith@example.com'),
('Bob', 'Johnson', 'bob.johnson@example.com'),
('Charlie', 'Brown', 'charlie.brown@example.com');

INSERT INTO courses (course_name, description,  instructor_id) VALUES
('Introduction to Programming', 'Fundamentals of coding in Python.',  1), 
('Database Management', 'SQL and relational database concepts.',  2), 
('Web Development Basics', 'HTML, CSS, and JavaScript fundamentals.',  1), 
('Data Structures & Algorithms', 'Advanced topics in computer science.',  3), 
('Linear Algebra', 'Concepts and applications in linear algebra.', NULL);

INSERT INTO students (first_name, last_name, email, enrollment_date) VALUES
('Anna', 'Lee', 'anna.lee@example.com', '2023-09-01'),
('Ben', 'Carter', 'ben.carter@example.com', '2023-09-01'),
('Chloe', 'Davis', 'chloe.davis@example.com', '2023-09-15'),
('David', 'Evans', 'david.evans@example.com', '2023-10-01'),
('Eva', 'Foster', 'eva.foster@example.com', '2024-01-01'),
('Frank', 'Green', 'frank.green@example.com', '2024-01-15'),
('Grace', 'Hall', 'grace.hall@example.com', '2024-02-01'),
('Harry', 'Irving', 'harry.irving@example.com', '2024-03-01');

INSERT INTO registrations (student_id, course_id, registration_date) VALUES
(1, 1, '2023-09-05'),  
(1, 2, '2023-09-05'), 
(2, 1, '2023-09-06'), 
(3, 3, '2023-09-20'), 
(4, 2, '2023-10-05'), 
(4, 4, '2023-10-05'), 
(5, 1, '2024-01-02'), 
(6, 3, '2024-01-20');

SELECT
    c.course_name,
    COUNT(r.student_id) AS number_of_students
FROM
    courses c
LEFT JOIN
    registrations r ON c.course_id = r.course_id
GROUP BY
    c.course_id, c.course_name
ORDER BY
    number_of_students DESC;
    
SELECT
    s.first_name,
    s.last_name,
    s.email
FROM
    students s
LEFT JOIN
    registrations r ON s.student_id = r.student_id
WHERE
    r.student_id IS NULL;