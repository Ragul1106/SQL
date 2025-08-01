--  1. Total enrollments per course
SELECT 
  c.course_id,
  c.title AS course_title,
  COUNT(e.enrollment_id) AS total_enrollments
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.title;

--  2. Average completion rate per instructor
SELECT 
  i.instructor_id,
  i.name AS instructor_name,
  AVG(e.completion_rate) AS avg_completion_rate
FROM instructors i
JOIN courses c ON i.instructor_id = c.instructor_id
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY i.instructor_id, i.name;

--  3. Courses with more than 20 completions
SELECT 
  c.course_id,
  c.title AS course_title,
  COUNT(e.enrollment_id) AS completed_enrollments
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
WHERE e.is_completed = TRUE
GROUP BY c.course_id, c.title
HAVING COUNT(e.enrollment_id) > 20;

--  4. INNER JOIN users and courses via enrollments
SELECT 
  u.user_id,
  u.name AS user_name,
  c.title AS course_title,
  e.enrollment_date
FROM users u
JOIN enrollments e ON u.user_id = e.user_id
JOIN courses c ON e.course_id = c.course_id;

--  5. LEFT JOIN to list all courses even if they have no enrollments
SELECT 
  c.course_id,
  c.title AS course_title,
  e.enrollment_id
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id;

--  6. SELF JOIN to compare users who completed the same course
SELECT 
  u1.name AS user_1,
  u2.name AS user_2,
  c.title AS course_title
FROM enrollments e1
JOIN enrollments e2 ON e1.course_id = e2.course_id 
  AND e1.user_id < e2.user_id 
  AND e1.is_completed = TRUE 
  AND e2.is_completed = TRUE
JOIN users u1 ON e1.user_id = u1.user_id
JOIN users u2 ON e2.user_id = u2.user_id
JOIN courses c ON e1.course_id = c.course_id;
