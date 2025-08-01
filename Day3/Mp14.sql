-- Average Calories Burned Per Workout
SELECT 
  workout_id,
  AVG(calories_burned) AS avg_calories
FROM workouts
GROUP BY workout_id;

-- Users With More Than 10 Workout Sessions (HAVING)
SELECT 
  u.user_id,
  u.name AS user_name,
  COUNT(w.workout_id) AS total_sessions
FROM users u
JOIN workouts w ON u.user_id = w.user_id
GROUP BY u.user_id, u.name
HAVING total_sessions > 10;

-- INNER JOIN - Users ↔ Workouts
SELECT 
  u.user_id,
  u.name AS user_name,
  w.workout_id,
  w.type,
  w.calories_burned
FROM users u
INNER JOIN workouts w ON u.user_id = w.user_id;

-- LEFT JOIN - Trainers ↔ Users
SELECT 
  t.trainer_id,
  t.name AS trainer_name,
  u.user_id,
  u.name AS user_name
FROM trainers t
LEFT JOIN users u ON t.trainer_id = u.trainer_id;

--  SELF JOIN - Users With Similar Goals
SELECT 
  u1.user_id AS user1,
  u2.user_id AS user2,
  g1.goal_type
FROM goals g1
JOIN users u1 ON g1.user_id = u1.user_id

JOIN goals g2 ON g1.goal_type = g2.goal_type
JOIN users u2 ON g2.user_id = u2.user_id

WHERE u1.user_id <> u2.user_id;
