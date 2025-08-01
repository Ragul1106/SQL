-- Select products priced between 100 and 1000
SELECT name, category, price
FROM products
WHERE price BETWEEN 100 AND 1000;

-- Find products where the name contains the word 'phone'
SELECT *
FROM products
WHERE name LIKE '%phone%';

-- Show products that have no description (description is NULL)
SELECT *
FROM products
WHERE description IS NULL;

-- Get a unique list of all suppliers
SELECT DISTINCT supplier
FROM products;

-- Find products that are out of stock or priced above 5000
SELECT *
FROM products
WHERE stock = 0 OR price > 5000;

-- Order products by category (A–Z), then by price from highest to lowest
SELECT *
FROM products
ORDER BY category ASC, price DESC;
