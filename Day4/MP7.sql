-- Completion Rate per Course (Subquery in FROM)
SELECT c.course_name, cr.total_enrolled, cr.total_completed,
       ROUND((cr.total_completed * 100.0 / cr.total_enrolled), 2) AS completion_rate
FROM (
    SELECT e.course_id,
           COUNT(DISTINCT e.student_id) AS total_enrolled,
           COUNT(DISTINCT comp.student_id) AS total_completed
    FROM enrollments e
    LEFT JOIN completion comp ON e.student_id = comp.student_id AND e.course_id = comp.course_id
    GROUP BY e.course_id
) AS cr
JOIN courses c ON cr.course_id = c.course_id;

-- Students Who Completed Both "SQL" and "Python" (INTERSECT)
-- Students who completed SQL
SELECT student_id FROM completion
WHERE course_id = (SELECT course_id FROM courses WHERE course_name = 'SQL')
INTERSECT
-- Students who completed Python
SELECT student_id FROM completion
WHERE course_id = (SELECT course_id FROM courses WHERE course_name = 'Python');

-- All Students from Two Course Batches (UNION)
-- Students from batch 1 (e.g., SQL course)
SELECT student_id, course_id FROM enrollments
WHERE course_id = (SELECT course_id FROM courses WHERE course_name = 'SQL')

UNION

-- Students from batch 2 (e.g., Python course)
SELECT student_id, course_id FROM enrollments
WHERE course_id = (SELECT course_id FROM courses WHERE course_name = 'Python');

-- Grade Students Using CASE (A/B/C/F)
SELECT student_id, course_id, score,
    CASE
        WHEN score >= 90 THEN 'A'
        WHEN score >= 75 THEN 'B'
        WHEN score >= 60 THEN 'C'
        ELSE 'F'
    END AS grade
FROM completion;

-- Student with Highest Grade in Each Course (Correlated Subquery)
SELECT s.student_id, s.name, c.course_name, comp.score
FROM completion comp
JOIN students s ON comp.student_id = s.student_id
JOIN courses c ON comp.course_id = c.course_id
WHERE comp.score = (
    SELECT MAX(score)
    FROM completion c2
    WHERE c2.course_id = comp.course_id
);

-- Completion Trends Over Months (DATE Functions)
SELECT YEAR(completion_date) AS year, MONTH(completion_date) AS month,
       COUNT(*) AS completions
FROM completion
GROUP BY YEAR(completion_date), MONTH(completion_date)
ORDER BY year, month;
      