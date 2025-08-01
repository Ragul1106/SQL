-- Task: Employee Management System

-- 1. Show average salary per department (GROUP BY)
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- 2. Count employees per department (COUNT)
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;

-- 3. Find departments with more than 5 employees (HAVING)
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;

-- 4. INNER JOIN to show employees and their department names
SELECT 
  e.employee_id, 
  e.name AS employee_name, 
  d.name AS department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- 5. LEFT JOIN to find departments without employees
SELECT 
  d.department_id, 
  d.name AS department_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

--  6. SELF JOIN to show each employee with their manager name
SELECT 
  e1.employee_id, 
  e1.name AS employee_name, 
  e2.name AS manager_name
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;
