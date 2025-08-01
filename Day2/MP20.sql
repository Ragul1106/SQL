-- Filter items with price > 500 and quantity >= 2
SELECT *
FROM sales
WHERE price > 500 AND quantity >= 2;

-- Find items with "Pro" in the item_name
SELECT *
FROM sales
WHERE item_name LIKE '%Pro%';

-- Check for NULL quantity
SELECT *
FROM sales
WHERE quantity IS NULL;

-- List all distinct categories
SELECT DISTINCT category
FROM sales;

-- Sort records by sale_date (latest first), then by price (highest first)
SELECT *
FROM sales
ORDER BY sale_date DESC, price DESC;
