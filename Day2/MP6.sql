-- Retrieve active courses priced below ₹1000
SELECT title, category, price
FROM courses
WHERE status = 'active' AND price < 1000;

-- List unique instructor names
SELECT DISTINCT instructor
FROM courses;

-- Get courses whose title starts with 'Data'
SELECT *
FROM courses
WHERE title LIKE 'Data%';

-- Select courses belonging to Tech or Business category
SELECT *
FROM courses
WHERE category IN ('Tech', 'Business');

-- Find courses that have no assigned instructor
SELECT *
FROM courses
WHERE instructor IS NULL;

-- List all courses sorted by highest price first, then shortest duration
SELECT *
FROM courses
ORDER BY price DESC, duration ASC;
