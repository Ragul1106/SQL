-- 1. Jobs Applied by Applicants with More Than 3 Applications (Subquery in WHERE)
SELECT j.job_id, j.title, a.applicant_id, a.name
FROM jobs j
JOIN applications app ON j.job_id = app.job_id
JOIN applicants a ON app.applicant_id = a.applicant_id
WHERE a.applicant_id IN (
    SELECT applicant_id
    FROM applications
    GROUP BY applicant_id
    HAVING COUNT(*) > 3
);


-- 2. Application Status with CASE
SELECT app.application_id, app.applicant_id, app.job_id,
       CASE app.status
           WHEN 'S' THEN 'Shortlisted'
           WHEN 'R' THEN 'Rejected'
           WHEN 'P' THEN 'In Review'
           ELSE 'Unknown'
       END AS status_label
FROM applications app;


-- 3. Applications Per Job (JOIN + GROUP BY)
SELECT j.job_id, j.title, COUNT(app.application_id) AS total_applications
FROM jobs j
JOIN applications app ON j.job_id = app.job_id
GROUP BY j.job_id, j.title;


-- 4. Combine Full-Time and Internship Roles (UNION)
SELECT job_id, title, 'Full-Time' AS job_type
FROM jobs
WHERE job_type = 'Full-Time'

UNION

SELECT job_id, title, 'Internship' AS job_type
FROM jobs
WHERE job_type = 'Internship';


-- 5. Most Applied Job per Applicant (Correlated Subquery)
SELECT a.applicant_id, a.name, j.job_id, j.title
FROM applicants a
JOIN applications app ON a.applicant_id = app.applicant_id
JOIN jobs j ON app.job_id = j.job_id
WHERE app.job_id = (
    SELECT job_id
    FROM applications
    WHERE applicant_id = a.applicant_id
    GROUP BY job_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


-- 6. Recent Applications in Last 30 Days (Date Filtering)
SELECT application_id, applicant_id, job_id, applied_at
FROM applications
WHERE applied_at >= CURDATE() - INTERVAL 30 DAY;