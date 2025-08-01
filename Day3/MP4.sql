--  Task: Hospital Patient Records

--  1. Total patients treated per doctor (COUNT)
SELECT 
  d.doctor_id,
  d.doctor_name,
  COUNT(DISTINCT a.patient_id) AS total_patients
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name;

--  2. Average treatment cost per doctor (AVG)
SELECT 
  d.doctor_id,
  d.doctor_name,
  AVG(t.treatment_cost) AS avg_treatment_cost
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
JOIN treatments t ON a.appointment_id = t.appointment_id
GROUP BY d.doctor_id, d.doctor_name;

--  3. Doctors who treated more than 10 patients (HAVING)
SELECT 
  d.doctor_id,
  d.doctor_name,
  COUNT(DISTINCT a.patient_id) AS total_patients
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name
HAVING COUNT(DISTINCT a.patient_id) > 10;

--  4. INNER JOIN: Appointments + Doctors
SELECT 
  a.appointment_id,
  p.patient_name,
  d.doctor_name,
  a.appointment_date
FROM appointments a
INNER JOIN patients p ON a.patient_id = p.patient_id
INNER JOIN doctors d ON a.doctor_id = d.doctor_id;

--  5. RIGHT JOIN: All doctors, including those with no appointments
SELECT 
  d.doctor_id,
  d.doctor_name,
  a.appointment_id,
  a.appointment_date
FROM appointments a
RIGHT JOIN doctors d ON a.doctor_id = d.doctor_id;

--  6. SELF JOIN on patients to find those with same birth date
SELECT 
  p1.patient_name AS patient_1,
  p2.patient_name AS patient_2,
  p1.birth_date
FROM patients p1
JOIN patients p2 ON p1.birth_date = p2.birth_date 
                 AND p1.patient_id < p2.patient_id;
