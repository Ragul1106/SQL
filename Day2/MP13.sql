-- Retrieve active members aged between 20 and 40
SELECT name, age, plan_type
FROM members
WHERE status = 'Active' AND age BETWEEN 20 AND 40;

-- List all distinct membership plan types
SELECT DISTINCT plan_type
FROM members;

-- Find members whose names start with "S"
SELECT *
FROM members
WHERE name LIKE 'S%';

-- Check members with NULL status
SELECT *
FROM members
WHERE status IS NULL;

-- Sort members by age (youngest first), then alphabetically by name
SELECT *
FROM members
ORDER BY age ASC, name ASC;
