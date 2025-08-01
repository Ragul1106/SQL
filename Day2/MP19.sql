-- Filter students with grades >= 80 in Math or English
SELECT *
FROM subject_enrollments
WHERE grade >= 80 AND subject IN ('Math', 'English');

-- LIKE search on student_name (e.g., names containing "an")
SELECT *
FROM subject_enrollments
WHERE student_name LIKE '%an%';

-- Check for NULL status
SELECT *
FROM subject_enrollments
WHERE status IS NULL;

-- List all distinct subjects
SELECT DISTINCT subject
FROM subject_enrollments;

-- Sort records by grade (highest first)
SELECT *
FROM subject_enrollments
ORDER BY grade DESC;
