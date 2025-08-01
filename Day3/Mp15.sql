-- Revenue Generated Per Seller (SUM)
SELECT 
  s.seller_id,
  s.name AS seller_name,
  SUM(p.price) AS total_revenue
FROM sellers s
JOIN products pr ON s.seller_id = pr.seller_id
JOIN purchases p ON pr.product_id = p.product_id
GROUP BY s.seller_id, s.name;

-- : Most Purchased Products (COUNT)
SELECT 
  pr.product_id,
  pr.name AS product_name,
  COUNT(p.purchase_id) AS purchase_count
FROM products pr
JOIN purchases p ON pr.product_id = p.product_id
GROUP BY pr.product_id, pr.name
ORDER BY purchase_count DESC;

--  Sellers With Revenue > ₹1,00,000 (HAVING)
SELECT 
  s.seller_id,
  s.name AS seller_name,
  SUM(p.price) AS total_revenue
FROM sellers s
JOIN products pr ON s.seller_id = pr.seller_id
JOIN purchases p ON pr.product_id = p.product_id
GROUP BY s.seller_id, s.name
HAVING total_revenue > 100000;

--  INNER JOIN - Purchases ↔ Products ↔ Sellers
SELECT 
  p.purchase_id,
  p.price,
  pr.product_id,
  pr.name AS product_name,
  s.seller_id,
  s.name AS seller_name
FROM purchases p
INNER JOIN products pr ON p.product_id = pr.product_id
INNER JOIN sellers s ON pr.seller_id = s.seller_id;

--  LEFT JOIN - Sellers Without Products
SELECT 
  s.seller_id,
  s.name AS seller_name,
  pr.product_id,
  pr.name AS product_name
FROM sellers s
LEFT JOIN products pr ON s.seller_id = pr.seller_id;

-- SELF JOIN - Sellers From the Same City
SELECT 
  s1.seller_id AS seller1_id,
  s1.name AS seller1_name,
  s2.seller_id AS seller2_id,
  s2.name AS seller2_name,
  s1.city
FROM sellers s1
JOIN sellers s2 ON s1.city = s2.city AND s1.seller_id <> s2.seller_id;
