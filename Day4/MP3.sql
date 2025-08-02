-- Store Revenue as % of Total (Subquery in SELECT)
SELECT s.store_id, s.store_name,
       SUM(sl.quantity * p.price) AS revenue,
       ROUND((SUM(sl.quantity * p.price) / 
             (SELECT SUM(quantity * price)
              FROM sales
              JOIN products ON sales.product_id = products.product_id)) * 100, 2) AS revenue_percent
FROM stores s
JOIN sales sl ON s.store_id = sl.store_id
JOIN products p ON sl.product_id = p.product_id
GROUP BY s.store_id, s.store_name;

-- Top Sales Performer per Region (Correlated Subquery)
SELECT e.employee_id, e.name, st.region,
       SUM(s.quantity * p.price) AS total_sales
FROM employees e
JOIN stores st ON e.store_id = st.store_id
JOIN sales s ON e.employee_id = s.employee_id
JOIN products p ON s.product_id = p.product_id
GROUP BY e.employee_id, e.name, st.region
HAVING SUM(s.quantity * p.price) = (
    SELECT MAX(SUM(subs.quantity * subp.price))
    FROM employees sube
    JOIN stores subst ON sube.store_id = subst.store_id
    JOIN sales subs ON sube.employee_id = subs.employee_id
    JOIN products subp ON subs.product_id = subp.product_id
    WHERE subst.region = st.region
    GROUP BY sube.employee_id
);

-- Combine Online and Offline Sales (UNION)
SELECT sale_id, store_id, product_id, quantity, sale_type
FROM sales
WHERE sale_type = 'online'
UNION
SELECT sale_id, store_id, product_id, quantity, sale_type
FROM sales
WHERE sale_type = 'offline';

-- Product Performance Category (CASE WHEN)
SELECT p.product_id, p.product_name, SUM(s.quantity) AS total_sold,
    CASE 
        WHEN SUM(s.quantity) >= 1000 THEN 'Top Seller'
        WHEN SUM(s.quantity) BETWEEN 500 AND 999 THEN 'Medium'
        ELSE 'Low'
    END AS performance_category
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name;

-- Monthly Sales Trends Using DATE, MONTH, YEAR
SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month,
       SUM(quantity * p.price) AS monthly_sales
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month;

-- Store-Level Performance (JOIN + GROUP BY + SUM) 
SELECT st.store_id, st.store_name,
       SUM(s.quantity * p.price) AS total_revenue,
       COUNT(DISTINCT s.sale_id) AS total_sales,
       SUM(s.quantity) AS total_items_sold
FROM stores st
JOIN sales s ON st.store_id = s.store_id
JOIN products p ON s.product_id = p.product_id
GROUP BY st.store_id, st.store_name;
     