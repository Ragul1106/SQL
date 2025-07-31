CREATE DATABASE company_hr;
USE company_hr;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);


CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    attendance_date DATE NOT NULL,
    in_time TIME,
    out_time TIME,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    UNIQUE (employee_id, attendance_date)
);

INSERT INTO departments (department_name) VALUES
('HR'), ('IT'), ('Finance'), ('Sales'), ('Marketing');

INSERT INTO employees (name, email, department_id) VALUES
('Alice', 'alice@company.com', 1),
('Bob', 'bob@company.com', 1),
('Cathy', 'cathy@company.com', 2),
('David', 'david@company.com', 2),
('Eva', 'eva@company.com', 3),
('Frank', 'frank@company.com', 3),
('Grace', 'grace@company.com', 4),
('Henry', 'henry@company.com', 4),
('Ivy', 'ivy@company.com', 5),
('Jake', 'jake@company.com', 5),
('Liam', 'liam@company.com', 2),
('Mona', 'mona@company.com', 3),
('Nina', 'nina@company.com', 4),
('Oscar', 'oscar@company.com', 5),
('Paul', 'paul@company.com', 1);

INSERT INTO attendance (employee_id, attendance_date, in_time, out_time) VALUES
-- Alice
(1, '2025-07-29', '09:00:00', '17:00:00'),
(1, '2025-07-30', '09:10:00', '17:05:00'),
-- Bob
(2, '2025-07-30', '08:55:00', '17:00:00'),
-- Cathy
(3, '2025-07-29', '09:05:00', '17:10:00'),
(3, '2025-07-30', '09:00:00', '16:45:00'),
-- David
(4, '2025-07-29', '09:30:00', '17:20:00'),
-- Eva
(5, '2025-07-30', '09:15:00', '17:30:00'),
-- Frank
(6, '2025-07-29', '09:00:00', '16:30:00'),
(6, '2025-07-30', '09:10:00', '17:00:00'),
-- Grace
(7, '2025-07-29', '08:50:00', '17:15:00'),
-- Henry
(8, '2025-07-29', '09:00:00', '17:00:00'),
(8, '2025-07-30', '09:05:00', '17:10:00'),
-- Ivy
(9, '2025-07-30', '09:00:00', '17:00:00'),
-- Jake
(10, '2025-07-29', '09:00:00', '17:00:00'),
-- Liam
(11, '2025-07-30', '09:00:00', '16:55:00'),
-- Mona
(12, '2025-07-29', '09:20:00', '17:30:00'),
(12, '2025-07-30', '09:00:00', '17:00:00'),
-- Nina
(13, '2025-07-29', '08:45:00', '17:10:00'),
-- Oscar
(14, '2025-07-30', '09:15:00', '17:20:00'),
-- Paul
(15, '2025-07-30', '09:05:00', '17:10:00');

SELECT 
  e.name,
  a.attendance_date,
  TIMEDIFF(a.out_time, a.in_time) AS working_hours
FROM attendance a
JOIN employees e ON a.employee_id = e.employee_id;

SELECT 
  e.name,
  COUNT(a.attendance_id) AS present_days
FROM employees e
LEFT JOIN attendance a ON e.employee_id = a.employee_id
GROUP BY e.name;

SELECT 
  e.name,
  (2 - COUNT(a.attendance_id)) AS absent_days
FROM employees e
LEFT JOIN attendance a ON e.employee_id = a.employee_id
GROUP BY e.name;





