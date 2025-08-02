-- Average Sessions Per Member (Subquery)
SELECT m.member_id, m.name,
       COUNT(s.session_id) AS session_count
FROM members m
JOIN sessions s ON m.member_id = s.member_id
GROUP BY m.member_id, m.name
HAVING COUNT(s.session_id) > (
    SELECT AVG(session_total)
    FROM (
        SELECT COUNT(*) AS session_total
        FROM sessions
        GROUP BY member_id
    ) AS avg_sessions
);

-- Bucket Members by Fitness Goal Completion (CASE)
SELECT m.member_id, m.name, m.fitness_goals_completed,
       CASE
           WHEN m.fitness_goals_completed >= 10 THEN 'Elite'
           WHEN m.fitness_goals_completed >= 5 THEN 'Intermediate'
           WHEN m.fitness_goals_completed >= 1 THEN 'Beginner'
           ELSE 'Not Started'
       END AS goal_category
FROM members m;

-- Most Active Member per Trainer (Correlated Subquery)
SELECT s.trainer_id, t.name AS trainer_name, s.member_id, m.name AS member_name, COUNT(*) AS total_sessions
FROM sessions s
JOIN trainers t ON s.trainer_id = t.trainer_id
JOIN members m ON s.member_id = m.member_id
GROUP BY s.trainer_id, s.member_id, t.name, m.name
HAVING COUNT(*) = (
    SELECT MAX(member_session_count)
    FROM (
        SELECT COUNT(*) AS member_session_count
        FROM sessions s2
        WHERE s2.trainer_id = s.trainer_id
        GROUP BY s2.member_id
    ) AS subq
);

-- Session Count Per Trainer (JOIN + GROUP BY)
SELECT t.trainer_id, t.name,
       COUNT(s.session_id) AS session_count
FROM trainers t
LEFT JOIN sessions s ON t.trainer_id = s.trainer_id
GROUP BY t.trainer_id, t.name
ORDER BY session_count DESC;

-- Expired vs Active Memberships (UNION ALL)
-- Active memberships
SELECT member_id, name, 'Active' AS status
FROM members
WHERE membership_expiry_date >= CURRENT_DATE

UNION ALL

-- Expired memberships
SELECT member_id, name, 'Expired' AS status
FROM members
WHERE membership_expiry_date < CURRENT_DATE;

-- Memberships Expiring This Month (Date Filter)
SELECT member_id, name, membership_expiry_date
FROM members
WHERE MONTH(membership_expiry_date) = MONTH(CURRENT_DATE)
  AND YEAR(membership_expiry_date) = YEAR(CURRENT_DATE);

   
  