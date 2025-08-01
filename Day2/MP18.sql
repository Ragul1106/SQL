-- Retrieve orders placed in the last 7 days
SELECT *
FROM orders
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY);

-- Find customers whose names start with 'R'
SELECT *
FROM orders
WHERE customer_name LIKE 'R%';

-- Check for orders with NULL status
SELECT *
FROM orders
WHERE status IS NULL;

-- List all distinct delivery addresses
SELECT DISTINCT address
FROM orders;

-- Sort all orders by order_date (latest first), then by total (highest first)
SELECT *
FROM orders
ORDER BY order_date DESC, total DESC;
