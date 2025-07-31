CREATE DATABASE voting_db;
USE voting_db;

CREATE TABLE voters (
    voter_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE candidates (
    candidate_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    party VARCHAR(50)
);

CREATE TABLE elections (
    election_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    date DATE NOT NULL
);

CREATE TABLE votes (
    vote_id INT AUTO_INCREMENT PRIMARY KEY,
    voter_id INT NOT NULL,
    candidate_id INT NOT NULL,
    election_id INT NOT NULL,
    vote_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (voter_id, election_id),
    FOREIGN KEY (voter_id) REFERENCES voters(voter_id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(candidate_id),
    FOREIGN KEY (election_id) REFERENCES elections(election_id)
);

INSERT INTO voters (name, email) VALUES
('Alice', 'alice@gmail.com'),
('Bob', 'bob@gmail.com'),
('Charlie', 'charlie@gmail.com'),
('David', 'david@gmail.com');

INSERT INTO candidates (name, party) VALUES
('Emma', 'Green Party'),
('Liam', 'Blue Party'),
('Olivia', 'Red Party');

INSERT INTO elections (title, date) VALUES
('2025 General Election', '2025-08-15'),
('2025 Student Council', '2025-08-20'),
('2025 City Mayor Election', '2025-09-01');

INSERT INTO votes (voter_id, candidate_id, election_id) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 1, 1),
(4, 3, 1),
(1, 2, 2),
(2, 2, 2),
(3, 2, 2);

SELECT c.name AS candidate_name, e.title AS election_title, COUNT(*) AS total_votes
FROM votes v
JOIN candidates c ON v.candidate_id = c.candidate_id
JOIN elections e ON v.election_id = e.election_id
GROUP BY c.name, e.title;

SELECT election_title, candidate_name, total_votes
FROM (
    SELECT 
        e.title AS election_title,
        c.name AS candidate_name,
        COUNT(*) AS total_votes,
        RANK() OVER (PARTITION BY e.election_id ORDER BY COUNT(*) DESC) as rnk
    FROM votes v
    JOIN candidates c ON v.candidate_id = c.candidate_id
    JOIN elections e ON v.election_id = e.election_id
    GROUP BY e.title, c.name, e.election_id
) AS ranked
WHERE rnk = 1;

UPDATE votes
SET candidate_id = 3
WHERE voter_id = 1 AND election_id = 2;










