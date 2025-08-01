-- Task: University Course Enrollment

--  1. Count enrollments per course
SELECT 
  c.course_id,
  c.course_name,
  COUNT(e.enrollment_id) AS total_enrollments
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

--  2. Average grade per course
SELECT 
  c.course_id,
  c.course_name,
  AVG(e.grade) AS average_grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- 🔹 3. Use HAVING to show courses with avg grade > 75
SELECT 
  c.course_id,
  c.course_name,
  AVG(e.grade) AS average_grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING AVG(e.grade) > 75;

--  4. INNER JOIN students and their course grades
SELECT 
  s.student_id,
  s.student_name,
  c.course_name,
  e.grade
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

--  5. LEFT JOIN to list courses without enrollments
SELECT 
  c.course_id,
  c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;

--  6. SELF JOIN to show students with same course and grade (peer pairing)
SELECT 
  s1.student_name AS student_1,
  s2.student_name AS student_2,
  c.course_name,
  e1.grade
FROM enrollments e1
JOIN enrollments e2 ON e1.course_id = e2.course_id 
                    AND e1.grade = e2.grade 
                    AND e1.student_id < e2.student_id
JOIN students s1 ON e1.student_id = s1.student_id
JOIN students s2 ON e2.student_id = s2.student_id
JOIN courses c ON e1.course_id = c.course_id;
