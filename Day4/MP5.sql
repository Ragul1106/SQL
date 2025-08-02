-- Total Patients Per Doctor (Subquery in FROM)
SELECT doctor_id, total_patients
FROM (
    SELECT doctor_id, COUNT(DISTINCT patient_id) AS total_patients
    FROM appointments
    GROUP BY doctor_id
) AS doctor_patient_count;

-- Patients Treated More Than 3 Times (Subquery in WHERE)
SELECT * FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM treatments
    GROUP BY patient_id
    HAVING COUNT(*) > 3
);

-- Flag Critical Patients (CASE)
SELECT p.patient_id, p.name,
       COUNT(t.treatment_id) AS treatment_count,
       SUM(t.bill_amount) AS total_bill,
       CASE
           WHEN COUNT(t.treatment_id) > 5 OR SUM(t.bill_amount) > 10000 THEN 'Critical'
           ELSE 'Stable'
       END AS patient_status
FROM patients p
LEFT JOIN treatments t ON p.patient_id = t.patient_id
GROUP BY p.patient_id, p.name;

-- Longest Stay Patient Per Department (Correlated Subquery)
SELECT p.patient_id, p.name, p.department,
       DATEDIFF(p.discharge_date, p.admission_date) AS stay_duration
FROM patients p
WHERE DATEDIFF(p.discharge_date, p.admission_date) = (
    SELECT MAX(DATEDIFF(p2.discharge_date, p2.admission_date))
    FROM patients p2
    WHERE p2.department = p.department
);

-- Patients Treated in the Last 30 Days (DATE Function)
SELECT DISTINCT p.patient_id, p.name, t.treatment_date
FROM patients p
JOIN treatments t ON p.patient_id = t.patient_id
WHERE t.treatment_date >= CURDATE() - INTERVAL 30 DAY;

-- Combine Outpatient and Inpatient Records (UNION)
-- Outpatient records
SELECT patient_id, name, 'outpatient' AS type, admission_date, discharge_date
FROM patients
WHERE patient_type = 'outpatient'

UNION

-- Inpatient records
SELECT patient_id, name, 'inpatient' AS type, admission_date, discharge_date
FROM patients
WHERE patient_type = 'inpatient';
      