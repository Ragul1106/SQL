--  1. Total views per movie
SELECT 
  m.movie_id,
  m.title,
  COUNT(v.view_id) AS total_views
FROM movies m
JOIN views v ON m.movie_id = v.movie_id
GROUP BY m.movie_id, m.title;

--  2. Average watch time per genre
SELECT 
  m.genre,
  AVG(v.watch_time_minutes) AS avg_watch_time
FROM movies m
JOIN views v ON m.movie_id = v.movie_id
GROUP BY m.genre;

--  3. Movies with more than 500 views
SELECT 
  m.movie_id,
  m.title,
  COUNT(v.view_id) AS total_views
FROM movies m
JOIN views v ON m.movie_id = v.movie_id
GROUP BY m.movie_id, m.title
HAVING COUNT(v.view_id) > 500;

--  4. INNER JOIN views and movies
SELECT 
  v.view_id,
  u.user_name,
  m.title,
  v.watch_time_minutes,
  v.view_date
FROM views v
JOIN movies m ON v.movie_id = m.movie_id
JOIN users u ON v.user_id = u.user_id;

--  5. LEFT JOIN: users and subscriptions
SELECT 
  u.user_id,
  u.user_name,
  s.plan_name,
  s.start_date,
  s.end_date
FROM users u
LEFT JOIN subscriptions s ON u.subscription_id = s.subscription_id;

--  6. SELF JOIN on users to find friends with the same subscription plan
SELECT 
  u1.user_name AS user1,
  u2.user_name AS user2,
  s.plan_name
FROM users u1
JOIN users u2 ON u1.subscription_id = u2.subscription_id AND u1.user_id < u2.user_id
JOIN subscriptions s ON u1.subscription_id = s.subscription_id;
