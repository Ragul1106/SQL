-- Dish Popularity Percentage (SELECT Subquery)
SELECT d.dish_id, d.name,
       (SELECT SUM(quantity) FROM orders) AS total_orders,
       SUM(o.quantity) AS dish_orders,
       ROUND(SUM(o.quantity) * 100.0 / (SELECT SUM(quantity) FROM orders), 2) AS popularity_percent
FROM dishes d
JOIN orders o ON d.dish_id = o.dish_id
GROUP BY d.dish_id, d.name;

-- Order Volume by Area (FROM Subquery)
SELECT area, total_orders
FROM (
    SELECT r.area, COUNT(o.order_id) AS total_orders
    FROM orders o
    JOIN dishes d ON o.dish_id = d.dish_id
    JOIN restaurants r ON d.restaurant_id = r.restaurant_id
    GROUP BY r.area
) AS area_orders; 

-- Bucket Customers Based on Total Orders (CASE)
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders,
    CASE
        WHEN COUNT(o.order_id) >= 50 THEN 'Platinum'
        WHEN COUNT(o.order_id) >= 20 THEN 'Gold'
        WHEN COUNT(o.order_id) >= 5 THEN 'Silver'
        ELSE 'Bronze'
    END AS customer_tier
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- Top Customer in Each Area (Correlated Subquery)
SELECT c.customer_id, c.name, c.area, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.area
HAVING COUNT(o.order_id) = (
    SELECT MAX(order_count)
    FROM (
        SELECT c2.customer_id, COUNT(o2.order_id) AS order_count
        FROM customers c2
        JOIN orders o2 ON c2.customer_id = o2.customer_id
        WHERE c2.area = c.area
        GROUP BY c2.customer_id
    ) AS area_top
);

-- Compare Delivery vs Pickup Orders (UNION ALL)
-- Delivery Orders
SELECT order_id, customer_id, dish_id, 'Delivery' AS order_mode
FROM orders
WHERE order_type = 'delivery'

UNION ALL

-- Pickup Orders
SELECT order_id, customer_id, dish_id, 'Pickup' AS order_mode
FROM orders
WHERE order_type = 'pickup';

-- Group Orders by Delivery Date (DATE Functions)
SELECT order_date, COUNT(*) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;
    