--  Task: Online Retail Order Tracking

-- 1. Total amount spent per customer (SUM)
SELECT 
  c.customer_id,
  c.customer_name,
  SUM(oi.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name;

-- 2. Products sold count and total revenue (COUNT, SUM)
SELECT 
  p.product_id,
  p.product_name,
  COUNT(oi.order_item_id) AS items_sold,
  SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

-- 3. Group sales by product and filter with HAVING SUM > 10,000
SELECT 
  p.product_id,
  p.product_name,
  SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity * p.price) > 10000;

-- 4. INNER JOIN orders ↔ order_items, order_items ↔ products
SELECT 
  o.order_id,
  o.order_date,
  p.product_name,
  oi.quantity,
  (oi.quantity * p.price) AS item_total
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id;

-- 5. LEFT JOIN to show customers without orders
SELECT 
  c.customer_id,
  c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 6. RIGHT JOIN to show products that were never sold
SELECT 
  p.product_id,
  p.product_name
FROM order_items oi
RIGHT JOIN products p ON oi.product_id = p.product_id
WHERE oi.order_item_id IS NULL;
