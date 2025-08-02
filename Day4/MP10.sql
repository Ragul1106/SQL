-- Agents Whose Sales Are Above Company Average (Subquery)
SELECT agent_id, name,
       SUM(s.sale_price) AS total_sales
FROM agents a
JOIN sales s ON a.agent_id = s.agent_id
GROUP BY agent_id, name
HAVING SUM(s.sale_price) > (
    SELECT AVG(agent_sales)
    FROM (
        SELECT agent_id, SUM(sale_price) AS agent_sales
        FROM sales
        GROUP BY agent_id
    ) AS avg_sales
);

-- Categorize Property Types (CASE)
SELECT property_id, address,
       CASE
           WHEN property_type = 'res' THEN 'Residential'
           WHEN property_type = 'comm' THEN 'Commercial'
           ELSE 'Other'
       END AS category
FROM properties;

-- Sold vs Still Listed Properties (UNION ALL)
-- Sold properties
SELECT p.property_id, p.address, 'Sold' AS status
FROM properties p
JOIN sales s ON p.property_id = s.property_id

UNION ALL

-- Still listed (not sold)
SELECT p.property_id, p.address, 'Listed' AS status
FROM properties p
LEFT JOIN sales s ON p.property_id = s.property_id
WHERE s.property_id IS NULL;

-- Highest Sale Per Agent (Correlated Subquery)
SELECT s.agent_id, a.name, s.sale_price
FROM sales s
JOIN agents a ON s.agent_id = a.agent_id
WHERE s.sale_price = (
    SELECT MAX(s2.sale_price)
    FROM sales s2
    WHERE s2.agent_id = s.agent_id
);

-- Agent Sales by City (JOIN + GROUP BY)
SELECT a.city, a.agent_id, a.name,
       SUM(s.sale_price) AS total_sales
FROM agents a
JOIN sales s ON a.agent_id = s.agent_id
GROUP BY a.city, a.agent_id, a.name
ORDER BY a.city;

-- Days Between Listing and Sale (DATEDIFF)
SELECT p.property_id, p.address, p.listed_date, s.sale_date,
       DATEDIFF(s.sale_date, p.listed_date) AS days_to_sell
FROM properties p
JOIN sales s ON p.property_id = s.property_id;
      