-- Students Who Scored Above Class Average (Using Subquery in WHERE) 
SELECT s.student_id, s.name
FROM students s
WHERE s.student_id IN (
    SELECT r.student_id
    FROM results r
    GROUP BY r.student_id
    HAVING AVG(r.marks) > (
        SELECT AVG(marks) FROM results
    )
);

-- Average Marks Per Subject (Using FROM Subquery)
SELECT subject_id, AVG_marks
FROM (
    SELECT subject_id, AVG(marks) AS AVG_marks
    FROM results
    GROUP BY subject_id
) AS subject_avg;

-- Combine Midterm and Final Results (UNION ALL)
SELECT student_id, subject_id, marks AS score, 'midterm' AS exam_type
FROM results
WHERE exam_type = 'midterm'
UNION ALL
SELECT student_id, subject_id, marks AS score, 'final' AS exam_type
FROM results
WHERE exam_type = 'final';

-- Grade Students Based on Marks (CASE)  
SELECT student_id, subject_id, marks,
    CASE
        WHEN marks >= 90 THEN 'A+'
        WHEN marks >= 80 THEN 'A'
        WHEN marks >= 70 THEN 'B'
        WHEN marks >= 60 THEN 'C'
        WHEN marks >= 50 THEN 'D'
        ELSE 'F'
    END AS grade
FROM results;

-- JOIN Students → Results → Subjects & GROUP BY Course Level
SELECT c.course_level, COUNT(DISTINCT s.student_id) AS total_students, AVG(r.marks) AS average_marks
FROM students s
JOIN results r ON s.student_id = r.student_id
JOIN subjects sub ON r.subject_id = sub.subject_id
JOIN courses c ON s.course_id = c.course_id
GROUP BY c.course_level;

-- Students Enrolled in the Last Year (Date Function)
SELECT student_id, name, enrollment_date
FROM students
WHERE enrollment_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

  
