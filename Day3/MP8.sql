--  1. Total orders per restaurant
SELECT 
  r.restaurant_id,
  r.name AS restaurant_name,
  COUNT(o.order_id) AS total_orders
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name;

--  2. Sum of order values per delivery agent
SELECT 
  d.agent_id,
  d.name AS agent_name,
  SUM(o.total_amount) AS total_delivered_value
FROM delivery_agents d
JOIN orders o ON d.agent_id = o.delivery_agent_id
GROUP BY d.agent_id, d.name;

--  3. Restaurants with revenue > ₹50,000
SELECT 
  r.restaurant_id,
  r.name AS restaurant_name,
  SUM(o.total_amount) AS total_revenue
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name
HAVING SUM(o.total_amount) > 50000;

--  4. INNER JOIN: restaurants ↔ orders
SELECT 
  r.name AS restaurant_name,
  o.order_id,
  o.total_amount,
  o.order_date
FROM restaurants r
INNER JOIN orders o ON r.restaurant_id = o.restaurant_id;

--  5. LEFT JOIN: delivery agents ↔ orders
SELECT 
  d.agent_id,
  d.name AS agent_name,
  o.order_id,
  o.total_amount
FROM delivery_agents d
LEFT JOIN orders o ON d.agent_id = o.delivery_agent_id;

--  6. SELF JOIN to find restaurants in the same location
SELECT 
  r1.name AS restaurant_1,
  r2.name AS restaurant_2,
  r1.location
FROM restaurants r1
JOIN restaurants r2 
  ON r1.location = r2.location AND r1.restaurant_id < r2.restaurant_id;
