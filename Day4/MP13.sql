-- Plan-wise Average Revenue (Subquery in FROM)
SELECT p.plan_id, p.name AS plan_name, avg_data.avg_revenue
FROM plans p
JOIN (
    SELECT plan_id, AVG(amount) AS avg_revenue
    FROM payments
    GROUP BY plan_id
) AS avg_data ON p.plan_id = avg_data.plan_id;

-- User Activity Status (CASE)
SELECT u.user_id, u.name, s.status,
       CASE
           WHEN s.status = 'active' THEN 'Active'
           WHEN s.status = 'trial' THEN 'Trial'
           WHEN s.status = 'inactive' THEN 'Inactive'
           ELSE 'Unknown'
       END AS activity_label
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id;

-- Paid and Free-Tier Users (UNION)
-- Paid users
SELECT u.user_id, u.name, 'Paid' AS tier
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
JOIN plans p ON s.plan_id = p.plan_id
WHERE p.price > 0

UNION

-- Free-tier users
SELECT u.user_id, u.name, 'Free' AS tier
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
JOIN plans p ON s.plan_id = p.plan_id
WHERE p.price = 0;

-- Monthly Revenue Trends (JOIN + GROUP BY)
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
       SUM(amount) AS monthly_revenue
FROM payments
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY month;

-- Longest-Subscribed Users (Correlated Subquery)
SELECT s.user_id, u.name, DATEDIFF(s.end_date, s.start_date) AS duration_days
FROM subscriptions s
JOIN users u ON s.user_id = u.user_id
WHERE DATEDIFF(s.end_date, s.start_date) = (
    SELECT MAX(DATEDIFF(s2.end_date, s2.start_date))
    FROM subscriptions s2
    WHERE s2.user_id = s.user_id
);

-- Renewal Reminders (Date Filter)
SELECT s.user_id, u.name, s.end_date
FROM subscriptions s
JOIN users u ON s.user_id = u.user_id
WHERE s.end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY);
    
  