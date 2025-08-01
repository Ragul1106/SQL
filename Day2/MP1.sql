-- Retrieve students with grades above 80 and attendance > 90%
SELECT name, grade
FROM students
WHERE grade > 80 AND attendance > 90;

-- Use DISTINCT to list all subjects offered 
SELECT DISTINCT subject
FROM students;

-- Filter students whose name starts with "A"
SELECT *
FROM students
WHERE name LIKE 'A%';

-- Use IN to get students studying Math or Science
SELECT *
FROM students
WHERE subject IN ('Math', 'Science');

-- Find students with NULL email addresses
SELECT *
FROM students
WHERE email IS NULL;

-- Sort students by grade descending, then name ascending
SELECT *
FROM students
ORDER BY grade DESC, name ASC;
    
