CREATE DATABASE hospital_db;
USE hospital_db;

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT, 
    department_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT, 
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(255) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
);

CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT, 
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(10),
    phone_number VARCHAR(20),
    address TEXT
);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT, -- Use SERIAL for PostgreSQL
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    reason TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE
);

INSERT INTO departments (department_name) VALUES
('Cardiology'),
('Pediatrics'),
('General Medicine'),
('Orthopedics'),
('Dermatology');

INSERT INTO doctors (first_name, last_name, specialty, phone_number, email, department_id) VALUES
('John', 'Doe', 'Cardiologist', '555-1001', 'john.doe@hospital.com', 1), 
('Jane', 'Smith', 'Pediatrician', '555-1002', 'jane.smith@hospital.com', 2), 
('Robert', 'Johnson', 'General Practitioner', '555-1003', 'robert.j@hospital.com', 3),
('Emily', 'Davis', 'Orthopedic Surgeon', '555-1004', 'emily.d@hospital.com', 4), 
('Michael', 'Brown', 'Cardiologist', '555-1005', 'michael.b@hospital.com', 1), 
('Sarah', 'Wilson', 'Dermatologist', '555-1006', 'sarah.w@hospital.com', 5), 
('David', 'Miller', 'General Practitioner', '555-1007', 'david.m@hospital.com', 3), 
('Jessica', 'Moore', 'Pediatrician', '555-1008', 'jessica.m@hospital.com', 2), 
('Chris', 'Taylor', 'Orthopedic Surgeon', '555-1009', 'chris.t@hospital.com', 4), 
('Laura', 'Anderson', 'General Practitioner', '555-1010', 'laura.a@hospital.com', 3);

INSERT INTO patients (first_name, last_name, date_of_birth, gender, phone_number, address) VALUES
('Alice', 'Green', '1990-05-10', 'Female', '555-2001', '123 Oak St, City'),
('Bob', 'White', '1985-11-22', 'Male', '555-2002', '456 Pine Ave, Town'),
('Charlie', 'Black', '2010-03-15', 'Male', '555-2003', '789 Maple Rd, Village'),
('Diana', 'Grey', '1972-07-01', 'Female', '555-2004', '101 Elm St, City'),
('Edward', 'Blue', '1998-01-20', 'Male', '555-2005', '202 Birch Ln, Town'),
('Fiona', 'Red', '2005-09-03', 'Female', '555-2006', '303 Cedar Dr, Village'),
('George', 'Yellow', '1960-04-18', 'Male', '555-2007', '404 Spruce Ct, City'),
('Hannah', 'Purple', '1993-12-05', 'Female', '555-2008', '505 Willow Way, Town'),
('Ian', 'Orange', '1980-02-28', 'Male', '555-2009', '606 Ash Blvd, Village'),
('Julia', 'Pink', '2000-06-12', 'Female', '555-2010', '707 Poplar Pk, City'),
('Kevin', 'Brown', '1975-08-07', 'Male', '555-2011', '808 Fir Grv, Town'),
('Liam', 'Green', '2015-01-01', 'Male', '555-2012', '909 Palm Ave, Village'),
('Mia', 'White', '1991-10-25', 'Female', '555-2013', '111 Sycamore St, City'),
('Noah', 'Black', '1988-03-08', 'Male', '555-2014', '222 Redwood Rd, Town'),
('Olivia', 'Grey', '2002-09-19', 'Female', '555-2015', '333 Cypress Ln, Village');

INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, reason) VALUES
(1, 1, '2025-08-01', '09:00:00', 'Routine check-up'),
(2, 3, '2025-08-01', '09:30:00', 'Fever and cough'),
(3, 2, '2025-08-01', '10:00:00', 'Child wellness visit'),
(4, 1, '2025-08-02', '11:00:00', 'Chest pain evaluation'),
(5, 4, '2025-08-02', '11:30:00', 'Knee injury follow-up'),
(6, 2, '2025-08-02', '13:00:00', 'Vaccination'),
(7, 3, '2025-08-03', '14:00:00', 'Annual physical'),
(8, 5, '2025-08-03', '14:30:00', 'Heart murmur check'),
(9, 6, '2025-08-03', '15:00:00', 'Skin rash'),
(10, 7, '2025-08-04', '09:00:00', 'Headache consultation'),
(11, 8, '2025-08-04', '09:30:00', 'Pediatric emergency'),
(12, 9, '2025-08-04', '10:00:00', 'Fracture assessment'),
(13, 10, '2025-08-05', '11:00:00', 'General consultation'),
(14, 1, '2025-08-05', '11:30:00', 'Blood pressure review'),
(15, 3, '2025-08-05', '13:00:00', 'Follow-up for chronic condition'),
(1, 4, '2025-08-06', '14:00:00', 'Shoulder pain'),
(2, 5, '2025-08-06', '14:30:00', 'ECG reading'),
(3, 6, '2025-08-07', '09:00:00', 'Mole check'),
(4, 7, '2025-08-07', '09:30:00', 'Fatigue symptoms'),
(5, 8, '2025-08-07', '10:00:00', 'Child development check');

SELECT
    a.appointment_date,
    a.appointment_time,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    d.specialty,
    a.reason
FROM
    appointments a
JOIN
    patients p ON a.patient_id = p.patient_id
JOIN
    doctors d ON a.doctor_id = d.doctor_id
WHERE
    a.appointment_date = '2025-08-01'
ORDER BY
    a.appointment_time;
    
SELECT
    d.first_name,
    d.last_name,
    d.specialty,
    dep.department_name
FROM
    doctors d
JOIN
    departments dep ON d.department_id = dep.department_id
WHERE
    dep.department_name = 'Cardiology'
ORDER BY
    d.last_name, d.first_name;
    
SELECT
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    d.specialty,
    COUNT(a.appointment_id) AS number_of_patients_seen -- Counts appointments, not unique patients
FROM
    doctors d
LEFT JOIN
    appointments a ON d.doctor_id = a.doctor_id
GROUP BY
    d.doctor_id, d.first_name, d.last_name, d.specialty
ORDER BY
    number_of_patients_seen DESC, d.last_name;