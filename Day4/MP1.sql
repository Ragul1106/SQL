-- Subquery in SELECT to calculate customer’s average order value.
SELECT 
  c.customer_id,
  c.name,
  c.email,
  -- Subquery in SELECT to get average order value
  (
    SELECT AVG(o.total_amount)
    FROM orders o
    WHERE o.customer_id = c.customer_id
  ) AS avg_order_value
FROM customers c;

--  Subquery in FROM to get total revenue per product.
SELECT 
  p.product_id,
  p.product_name,
  pr.total_revenue
FROM products p
JOIN (
  SELECT 
    oi.product_id,
    SUM(oi.quantity * oi.price) AS total_revenue
  FROM order_items oi
  GROUP BY oi.product_id
) pr ON p.product_id = pr.product_id;

--  Correlated subquery to find customers whose orders are above their own average.
SELECT DISTINCT o.customer_id
FROM orders o
WHERE o.total_amount > (
  SELECT AVG(o2.total_amount)
  FROM orders o2
  WHERE o2.customer_id = o.customer_id
);

--  UNION to combine old and new customers.
-- Assume old customers registered before 2023 and new in or after 2023
SELECT customer_id, 'Old' AS type
FROM customers
WHERE YEAR(registration_date) < 2023

UNION

SELECT customer_id, 'New' AS type
FROM customers
WHERE YEAR(registration_date) >= 2023;

--  INTERSECT to find customers who placed orders and submitted reviews.
SELECT customer_id FROM orders
INTERSECT
SELECT customer_id FROM reviews;

--  CASE to categorize customers: High Spender, Medium, Low.
SELECT 
  c.customer_id,
  c.name,
  SUM(o.total_amount) AS total_spent,
  CASE 
    WHEN SUM(o.total_amount) >= 5000 THEN 'High Spender'
    WHEN SUM(o.total_amount) BETWEEN 2000 AND 4999 THEN 'Medium Spender'
    ELSE 'Low Spender'
  END AS category
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

--  Use DATE() and YEAR() to filter orders in current year.
SELECT *
FROM orders
WHERE YEAR(order_date) = YEAR(CURDATE());
