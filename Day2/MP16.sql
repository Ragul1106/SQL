-- Filter appointments within a given week ( 2025-07-01 to 2025-07-07)
SELECT *
FROM appointments
WHERE date BETWEEN '2025-07-01' AND '2025-07-07';

-- Find patients with "th" in their name
SELECT *
FROM appointments
WHERE patient_name LIKE '%th%';

-- Show doctor_name, date, and status
SELECT doctor_name, date, status
FROM appointments;

-- Check for appointments with NULL notes
SELECT *
FROM appointments
WHERE notes IS NULL;

-- List distinct doctors
SELECT DISTINCT doctor_name
FROM appointments;

-- Sort appointments by date descending
SELECT *
FROM appointments
ORDER BY date DESC;
