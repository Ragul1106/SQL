-- Get employees who earn more than 50,000 and work in Sales or Marketing
SELECT name, salary, department
FROM employees
WHERE salary > 50000 AND department IN ('Sales', 'Marketing');

-- Retrieve all distinct department names
SELECT DISTINCT department
FROM employees;

-- Find employees whose names end with 'an'
SELECT *
FROM employees
WHERE name LIKE '%an';

-- Select employees who do not have a manager (manager_id is NULL)
SELECT *
FROM employees
WHERE manager_id IS NULL;

-- Find employees whose salary is between 40,000 and 80,000
SELECT *
FROM employees
WHERE salary BETWEEN 40000 AND 80000;

-- Display all employees sorted by department (A–Z) and salary (high to low)
SELECT *
FROM employees
ORDER BY department ASC, salary DESC;

