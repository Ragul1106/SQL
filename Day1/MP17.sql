CREATE DATABASE job_portal_db;
USE job_portal_db;

CREATE TABLE companies (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    description TEXT,
    company_id INT,
    location VARCHAR(100),
    posted_date DATE,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

CREATE TABLE applicants (
    applicant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    applicant_id INT,
    job_id INT,
    application_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (applicant_id) REFERENCES applicants(applicant_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);

INSERT INTO companies (name, location) VALUES
('TechNova', 'Bangalore'),
('CodeBase', 'Hyderabad'),
('InnoSoft', 'Chennai'),
('DataWiz', 'Pune'),
('Cloudify', 'Mumbai');

INSERT INTO jobs (title, description, company_id, location, posted_date) VALUES
('Frontend Developer', 'ReactJS experience needed', 1, 'Remote', '2025-07-01'),
('Backend Developer', 'Django expert required', 2, 'Hyderabad', '2025-07-03'),
('Data Analyst', 'Proficiency in SQL and Excel', 3, 'Chennai', '2025-07-05'),
('DevOps Engineer', 'AWS + Docker skills', 4, 'Pune', '2025-07-07'),
('UI/UX Designer', 'Figma and Adobe XD knowledge', 1, 'Remote', '2025-07-09'),
('Project Manager', 'Agile certification preferred', 5, 'Mumbai', '2025-07-10'),
('Mobile Developer', 'Flutter experience required', 2, 'Hyderabad', '2025-07-12'),
('Cloud Architect', 'Google Cloud experience', 5, 'Remote', '2025-07-14'),
('ML Engineer', 'TensorFlow or PyTorch experience', 3, 'Chennai', '2025-07-16'),
('Support Engineer', 'Good communication skills', 4, 'Pune', '2025-07-18');

INSERT INTO applicants (name, email) VALUES
('Ravi Kumar', 'ravi@example.com'),
('Anjali Sharma', 'anjali@example.com'),
('Mohit Singh', 'mohit@example.com'),
('Sneha Das', 'sneha@example.com'),
('Raj Patel', 'raj@example.com'),
('Kavya Nair', 'kavya@example.com'),
('Deepak Rao', 'deepak@example.com'),
('Priya Menon', 'priya@example.com'),
('Siddharth Jain', 'sid@example.com'),
('Meera Iyer', 'meera@example.com');

INSERT INTO applications (applicant_id, job_id, application_date, status) VALUES
(1, 1, '2025-07-10', 'Pending'),
(1, 3, '2025-07-11', 'Pending'),
(2, 2, '2025-07-10', 'Reviewed'),
(3, 1, '2025-07-12', 'Accepted'),
(3, 5, '2025-07-13', 'Rejected'),
(4, 4, '2025-07-14', 'Pending'),
(5, 2, '2025-07-14', 'Reviewed'),
(5, 6, '2025-07-15', 'Pending'),
(6, 7, '2025-07-15', 'Pending'),
(7, 3, '2025-07-16', 'Accepted'),
(8, 8, '2025-07-16', 'Reviewed'),
(9, 9, '2025-07-17', 'Pending'),
(10, 10, '2025-07-18', 'Pending'),
(1, 6, '2025-07-19', 'Pending'),
(2, 4, '2025-07-19', 'Pending');

SELECT j.title, j.location, c.name AS company, a.application_date, a.status
FROM applications a
JOIN jobs j ON a.job_id = j.job_id
JOIN companies c ON j.company_id = c.company_id
WHERE a.applicant_id = 1;

SELECT c.name AS company, COUNT(app.application_id) AS total_applications
FROM companies c
JOIN jobs j ON c.company_id = j.company_id
JOIN applications app ON j.job_id = app.job_id
GROUP BY c.company_id, c.name;










