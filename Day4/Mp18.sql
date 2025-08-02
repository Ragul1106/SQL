-- 1. Products Below Reorder Level (Subquery in WHERE)
SELECT p.product_id, p.product_name, i.quantity, i.reorder_level
FROM products p
JOIN inventory i ON p.product_id = i.product_id
WHERE i.quantity < (
    SELECT AVG(reorder_level)
    FROM inventory
);


-- 2. Categorize Products by Movement Speed (CASE)
SELECT p.product_id, p.product_name, SUM(o.quantity) AS total_orders,
       CASE
           WHEN SUM(o.quantity) > 1000 THEN 'Fast Moving'
           WHEN SUM(o.quantity) BETWEEN 500 AND 1000 THEN 'Medium Moving'
           ELSE 'Slow Moving'
       END AS movement_category
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name;


-- 3. Supplier with Least Delayed Deliveries (Correlated Subquery)
SELECT s.supplier_id, s.supplier_name
FROM suppliers s
WHERE (
    SELECT COUNT(*)
    FROM orders o
    WHERE o.supplier_id = s.supplier_id AND o.delivery_status = 'Delayed'
) = (
    SELECT MIN(delayed_count)
    FROM (
        SELECT supplier_id, COUNT(*) AS delayed_count
        FROM orders
        WHERE delivery_status = 'Delayed'
        GROUP BY supplier_id
    ) AS delays
);


-- 4. Fulfillment Rate by Supplier (JOIN + GROUP BY)
SELECT s.supplier_id, s.supplier_name,
       COUNT(o.order_id) AS total_orders,
       SUM(CASE WHEN o.delivery_status = 'Delivered' THEN 1 ELSE 0 END) AS fulfilled_orders,
       ROUND(100.0 * SUM(CASE WHEN o.delivery_status = 'Delivered' THEN 1 ELSE 0 END) / COUNT(o.order_id), 2) AS fulfillment_rate
FROM suppliers s
JOIN orders o ON s.supplier_id = o.supplier_id
GROUP BY s.supplier_id, s.supplier_name;


-- 5. Combine Online and Offline Stock (UNION ALL)
SELECT product_id, location_type, quantity
FROM inventory
WHERE location_type = 'Online'

UNION ALL

SELECT product_id, location_type, quantity
FROM inventory
WHERE location_type = 'Offline';


-- 6. Expiry Tracking – Products Expiring in Next 30 Days (Date Filtering)
SELECT product_id, product_name, expiry_date
FROM products 
WHERE expiry_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

