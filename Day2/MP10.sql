-- List all vehicles serviced in the last 30 days
SELECT vehicle_no, service_type, cost
FROM services
WHERE service_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- Find vehicle numbers that end with '9'
SELECT vehicle_no
FROM services
WHERE vehicle_no LIKE '%9';

-- Filter services where cost is between 500 and 2000
SELECT vehicle_no, service_type, cost
FROM services
WHERE cost BETWEEN 500 AND 2000;

-- Identify records with no technician assigned
SELECT *
FROM services
WHERE technician IS NULL;

-- List all unique service types
SELECT DISTINCT service_type
FROM services;

-- Sort service records by service_date (latest first), then by cost ascending
SELECT *
FROM services
ORDER BY service_date DESC, cost ASC;
