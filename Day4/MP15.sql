-- Users Who Abandoned Carts More Than 3 Times (Subquery + COUNT)
SELECT user_id
FROM carts
WHERE status = 'abandoned'
GROUP BY user_id
HAVING COUNT(*) > 3;

-- Label Cart Status (CASE)
SELECT cart_id, user_id,
       CASE
           WHEN status = 'completed' THEN 'Completed'
           WHEN status = 'abandoned' THEN 'Abandoned'
           ELSE 'Unknown'
       END AS cart_status
FROM carts;

-- Items Added to Cart vs Purchased (UNION)
-- Items added to cart
SELECT c.user_id, p.product_id, p.name, 'Added to Cart' AS action
FROM carts c
JOIN cart_items ci ON c.cart_id = ci.cart_id
JOIN products p ON ci.product_id = p.product_id

UNION

-- Items actually purchased
SELECT o.user_id, p.product_id, p.name, 'Purchased' AS action
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- Most Abandoned Product per User (Correlated Subquery)
SELECT c.user_id, ci.product_id, p.name,
       COUNT(*) AS abandon_count
FROM carts c
JOIN cart_items ci ON c.cart_id = ci.cart_id
JOIN products p ON ci.product_id = p.product_id
WHERE c.status = 'abandoned'
GROUP BY c.user_id, ci.product_id, p.name
HAVING COUNT(*) = (
    SELECT MAX(prod_count)
    FROM (
        SELECT COUNT(*) AS prod_count
        FROM carts c2
        JOIN cart_items ci2 ON c2.cart_id = ci2.cart_id
        WHERE c2.status = 'abandoned' AND c2.user_id = c.user_id
        GROUP BY ci2.product_id
    ) AS sub
);

-- Cart Abandonments in the Last 7 Days (Date Filtering)
SELECT cart_id, user_id, created_at
FROM carts
WHERE status = 'abandoned'
  AND created_at >= CURDATE() - INTERVAL 7 DAY;


-- Cart Conversion Rate (JOIN + GROUP BY)
SELECT u.user_id,
       COUNT(DISTINCT c.cart_id) AS total_carts,
       COUNT(DISTINCT o.order_id) AS completed_orders,
       ROUND(
         (COUNT(DISTINCT o.order_id) * 100.0) / NULLIF(COUNT(DISTINCT c.cart_id), 0), 2
       ) AS conversion_rate_percent
FROM users u
LEFT JOIN carts c ON u.user_id = c.user_id
LEFT JOIN orders o ON c.cart_id = o.cart_id
GROUP BY u.user_id;

 
  

  