-- Hospital Patient Visit Tracker 

-- 1. Create database tables
CREATE DATABASE hospital_tracker;
USE hospital_tracker;

-- Create departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(50),
    head_doctor_id INT
);

-- Create doctors table
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(50),
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Update departments foreign key after doctors table exists
ALTER TABLE departments
ADD FOREIGN KEY (head_doctor_id) REFERENCES doctors(doctor_id);

-- Create patients table
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender CHAR(1),
    phone VARCHAR(20),
    insurance_provider VARCHAR(50)
);

-- Create appointments table
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    department_id INT,
    appointment_date DATETIME NOT NULL,
    end_date DATETIME,
    visit_type ENUM('routine', 'emergency', 'follow-up', 'surgery'),
    diagnosis VARCHAR(100),
    status ENUM('scheduled', 'completed', 'cancelled', 'no-show'),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 2. Insert sample data
-- Insert departments
INSERT INTO departments VALUES
(1, 'Cardiology', 'Floor 3', NULL),
(2, 'Pediatrics', 'Floor 2', NULL),
(3, 'Oncology', 'Floor 4', NULL),
(4, 'Emergency', 'Floor 1', NULL),
(5, 'Neurology', 'Floor 5', NULL);

-- Insert doctors
INSERT INTO doctors VALUES
(101, 'James', 'Wilson', 'Cardiologist', 1, '2015-06-10'),
(102, 'Lisa', 'Cuddy', 'Pediatrician', 2, '2010-03-15'),
(103, 'Greg', 'House', 'Diagnostician', 3, '2008-11-22'),
(104, 'Eric', 'Foreman', 'Neurologist', 5, '2012-09-05'),
(105, 'Allison', 'Cameron', 'Immunologist', 3, '2014-07-30'),
(106, 'Robert', 'Chase', 'Surgeon', 1, '2016-02-18'),
(107, 'Remy', 'Hadley', 'Psychiatrist', 5, '2018-04-25'),
(108, 'Chris', 'Taub', 'Plastic Surgeon', 4, '2013-08-12');

-- Update department heads
UPDATE departments SET head_doctor_id = 101 WHERE department_id = 1;
UPDATE departments SET head_doctor_id = 102 WHERE department_id = 2;
UPDATE departments SET head_doctor_id = 103 WHERE department_id = 3;
UPDATE departments SET head_doctor_id = 108 WHERE department_id = 4;
UPDATE departments SET head_doctor_id = 104 WHERE department_id = 5;

-- Insert patients
INSERT INTO patients VALUES
(1001, 'John', 'Smith', '1980-05-15', 'M', '555-0101', 'Blue Cross'),
(1002, 'Emily', 'Davis', '1992-11-22', 'F', '555-0102', 'Aetna'),
(1003, 'Michael', 'Johnson', '1975-03-08', 'M', '555-0103', 'Medicare'),
(1004, 'Sarah', 'Wilson', '1988-07-30', 'F', '555-0104', 'United Health'),
(1005, 'David', 'Brown', '1995-01-10', 'M', '555-0105', 'Cigna'),
(1006, 'Jessica', 'Taylor', '1983-09-17', 'F', '555-0106', 'Blue Cross'),
(1007, 'Daniel', 'Anderson', '1970-12-05', 'M', '555-0107', 'Medicaid'),
(1008, 'Olivia', 'Thomas', '1990-04-28', 'F', '555-0108', 'Aetna');

-- Insert appointments
INSERT INTO appointments VALUES
(5001, 1001, 101, 1, '2023-01-10 09:00:00', '2023-01-10 09:30:00', 'routine', 'Hypertension', 'completed'),
(5002, 1002, 102, 2, '2023-01-15 10:30:00', '2023-01-15 11:15:00', 'routine', 'Annual checkup', 'completed'),
(5003, 1003, 103, 3, '2023-02-05 14:00:00', '2023-02-05 15:30:00', 'follow-up', 'Cancer screening', 'completed'),
(5004, 1004, 101, 1, '2023-02-20 08:45:00', '2023-02-20 09:30:00', 'routine', 'Heart palpitations', 'completed'),
(5005, 1005, 104, 5, '2023-03-01 13:15:00', '2023-03-01 14:00:00', 'emergency', 'Migraine', 'completed'),
(5006, 1001, 106, 1, '2023-03-15 11:00:00', '2023-03-15 12:30:00', 'surgery', 'Bypass surgery', 'completed'),
(5007, 1003, 105, 3, '2023-04-02 10:00:00', NULL, 'follow-up', 'Chemotherapy', 'scheduled'),
(5008, 1002, 108, 4, '2023-04-10 16:30:00', '2023-04-10 17:45:00', 'emergency', 'Broken arm', 'completed'),
(5009, 1005, 104, 5, '2023-05-05 09:30:00', '2023-05-05 10:15:00', 'routine', 'Neurological exam', 'completed'),
(5010, 1004, 108, 4, '2023-05-20 22:15:00', '2023-05-21 01:30:00', 'emergency', 'Appendicitis', 'completed'),
(5011, 1001, 101, 1, '2023-06-01 14:00:00', '2023-06-01 14:45:00', 'follow-up', 'Post-op check', 'completed'),
(5012, 1003, 103, 3, '2023-06-15 15:30:00', NULL, 'follow-up', 'Cancer treatment', 'scheduled'),
(5013, 1002, 102, 2, '2023-07-01 08:00:00', '2023-07-01 08:30:00', 'routine', 'Vaccination', 'completed'),
(5014, 1005, 107, 5, '2023-07-10 11:45:00', '2023-07-10 12:30:00', 'routine', 'Anxiety consult', 'completed'),
(5015, 1004, 101, 1, '2023-08-05 10:15:00', NULL, 'routine', 'Cardiac checkup', 'scheduled'),
(5016, 1006, 108, 4, '2023-08-12 18:20:00', '2023-08-12 20:45:00', 'emergency', 'Severe burns', 'completed'),
(5017, 1007, 102, 2, '2023-08-15 09:30:00', '2023-08-15 10:00:00', 'routine', 'Child wellness', 'completed'),
(5018, 1008, 105, 3, '2023-08-20 13:00:00', NULL, 'follow-up', 'Immunotherapy', 'scheduled');

-- 3. Analysis Queries

-- 1. Use LEFT JOIN to show all patients, even those with no appointments
SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    COUNT(a.appointment_id) AS appointment_count
FROM patients p
LEFT JOIN appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, patient_name
ORDER BY appointment_count;

-- 2. Filter data using BETWEEN for date range of visits
SELECT 
    a.appointment_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    dept.department_name,
    a.appointment_date,
    a.visit_type,
    a.diagnosis
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN departments dept ON a.department_id = dept.department_id
WHERE a.appointment_date BETWEEN '2023-03-01' AND '2023-06-30'
AND a.status = 'completed'
ORDER BY a.appointment_date;

-- 3. Aggregate visit counts per department
SELECT 
    d.department_name,
    COUNT(a.appointment_id) AS total_visits,
    SUM(CASE WHEN a.visit_type = 'emergency' THEN 1 ELSE 0 END) AS emergency_visits,
    SUM(CASE WHEN a.visit_type = 'routine' THEN 1 ELSE 0 END) AS routine_visits,
    ROUND(COUNT(a.appointment_id) / (SELECT COUNT(*) FROM appointments) * 100, 2) AS percentage_of_total
FROM departments d
LEFT JOIN appointments a ON d.department_id = a.department_id
GROUP BY d.department_name
ORDER BY total_visits DESC;

-- 4. Use FULL OUTER JOIN to get all appointments and doctors, even if missing
SELECT 
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    a.appointment_id,
    a.appointment_date,
    a.visit_type
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id

UNION

SELECT 
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    a.appointment_id,
    a.appointment_date,
    a.visit_type
FROM appointments a
LEFT JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE d.doctor_id IS NULL
ORDER BY doctor_name, appointment_date;

-- 5. Use subquery in FROM to summarize daily appointments
SELECT 
    appointment_date AS date,
    daily_stats.visit_count,
    daily_stats.patient_count,
    daily_stats.emergency_count
FROM (
    SELECT 
        DATE(appointment_date) AS appointment_date,
        COUNT(*) AS visit_count,
        COUNT(DISTINCT patient_id) AS patient_count,
        SUM(CASE WHEN visit_type = 'emergency' THEN 1 ELSE 0 END) AS emergency_count
    FROM appointments
    WHERE status = 'completed'
    GROUP BY DATE(appointment_date)
) AS daily_stats
ORDER BY date;

-- 6. Use CASE to flag emergency vs. routine
SELECT 
    a.appointment_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    dept.department_name,
    a.appointment_date,
    a.visit_type,
    CASE 
        WHEN a.visit_type = 'emergency' THEN 'URGENT'
        WHEN a.visit_type = 'surgery' THEN 'CRITICAL'
        ELSE 'STANDARD'
    END AS priority_level,
    CASE
        WHEN a.visit_type = 'emergency' THEN 'RED'
        WHEN a.visit_type = 'surgery' THEN 'ORANGE'
        WHEN a.visit_type = 'follow-up' THEN 'YELLOW'
        ELSE 'GREEN'
    END AS color_code
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN departments dept ON a.department_id = dept.department_id
ORDER BY 
    CASE 
        WHEN priority_level = 'URGENT' THEN 1
        WHEN priority_level = 'CRITICAL' THEN 2
        ELSE 3
    END,
    a.appointment_date;

-- 7. Combine regular and emergency visits using UNION
SELECT 
    'Regular Visit' AS visit_category,
    COUNT(*) AS visit_count,
    AVG(TIMESTAMPDIFF(MINUTE, appointment_date, end_date)) AS avg_duration_minutes
FROM appointments
WHERE visit_type IN ('routine', 'follow-up')
AND status = 'completed'

UNION

SELECT 
    'Emergency Visit' AS visit_category,
    COUNT(*) AS visit_count,
    AVG(TIMESTAMPDIFF(MINUTE, appointment_date, end_date)) AS avg_duration_minutes
FROM appointments
WHERE visit_type = 'emergency'
AND status = 'completed';