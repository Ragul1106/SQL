
CREATE DATABASE Employee_Performance;
USE Employee_Performance;
-- 1. Create Departments Table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100)
);

-- 2. Create Employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    manager_id INT,
    dept_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 3. Create Reviews Table
CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    emp_id INT,
    review_date DATE,
    score INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Insert Departments
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'HR');

-- Insert Employees (some with managers)
INSERT INTO employees (emp_id, emp_name, manager_id, dept_id) VALUES
(1, 'Alice', NULL, 1),     -- Manager of Engineering
(2, 'Bob', 1, 1),
(3, 'Charlie', 1, 1),
(4, 'Diana', NULL, 2),     -- Manager of Marketing
(5, 'Eve', 4, 2),
(6, 'Frank', NULL, 3);     -- Manager of HR

-- Insert Reviews
INSERT INTO reviews (review_id, emp_id, review_date, score) VALUES
(101, 2, '2025-01-15', 88),
(102, 2, '2025-06-10', 92),
(103, 3, '2025-01-20', 75),
(104, 5, '2025-05-12', 81),
(105, 6, '2025-04-05', NULL), -- Incomplete
(106, 3, '2025-07-01', 80);

--  1. SELF JOIN: Employees with their managers
SELECT 
    e.emp_name AS Employee,
    m.emp_name AS Manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

--  2. ROW_NUMBER(): Order reviews per employee by date
SELECT 
    r.emp_id,
    e.emp_name,
    r.review_date,
    r.score,
    ROW_NUMBER() OVER (PARTITION BY r.emp_id ORDER BY r.review_date DESC) AS row_num
FROM reviews r
JOIN employees e ON r.emp_id = e.emp_id;

--  3. Average score per department
SELECT 
    d.dept_name,
    ROUND(AVG(r.score), 2) AS avg_score
FROM reviews r
JOIN employees e ON r.emp_id = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
WHERE r.score IS NOT NULL
GROUP BY d.dept_name;

--  4. CASE for rating conversion
SELECT 
    e.emp_name,
    r.score,
    CASE 
        WHEN r.score >= 90 THEN 'Excellent'
        WHEN r.score >= 75 THEN 'Good'
        ELSE 'Average'
    END AS rating
FROM reviews r
JOIN employees e ON r.emp_id = e.emp_id
WHERE r.score IS NOT NULL;

--  5. IS NOT NULL: Completed reviews only
SELECT 
    e.emp_name,
    r.review_date,
    r.score
FROM reviews r
JOIN employees e ON r.emp_id = e.emp_id
WHERE r.score IS NOT NULL;

--  6. Subquery to fetch latest review per employee
SELECT 
    e.emp_name,
    (
        SELECT r2.score
        FROM reviews r2
        WHERE r2.emp_id = e.emp_id AND r2.score IS NOT NULL
        ORDER BY r2.review_date DESC
        LIMIT 1
    ) AS latest_score
FROM employees e;

--  7. Sort by review score and department
SELECT 
    e.emp_name,
    d.dept_name,
    r.score
FROM reviews r
JOIN employees e ON r.emp_id = e.emp_id
JOIN departments d ON e.dept_id = d.dept_id
WHERE r.score IS NOT NULL
ORDER BY r.score DESC, d.dept_name ASC;
