-- Retrieve pets that are not yet adopted
SELECT *
FROM pets
WHERE adopted = FALSE;

-- Retrieve pets aged between 1 and 5 years
SELECT *
FROM pets
WHERE age BETWEEN 1 AND 5;

-- Find pets with breed containing "shepherd"
SELECT *
FROM pets
WHERE breed LIKE '%shepherd%';

-- Show name, breed, and species
SELECT name, breed, species
FROM pets;

-- Identify pets with NULL owner_name
SELECT *
FROM pets
WHERE owner_name IS NULL;

-- List distinct species
SELECT DISTINCT species
FROM pets;

-- Sort pets by age ascending, then name ascending
SELECT *
FROM pets
ORDER BY age ASC, name ASC;
