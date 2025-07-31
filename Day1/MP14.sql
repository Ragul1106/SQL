CREATE DATABASE event_portal;
USE event_portal;

CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE registrations (
    reg_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    event_id INT,
    registration_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (event_id) REFERENCES events(event_id)
);

INSERT INTO events (event_name, event_date, location) VALUES
('Tech Talk 2025', '2025-08-10', 'Chennai'),
('AI Summit', '2025-09-15', 'Bangalore'),
('Startup Expo', '2025-10-01', 'Delhi'),
('Data Science Bootcamp', '2025-07-25', 'Mumbai');

INSERT INTO users (user_name, email) VALUES
('Ravi Kumar', 'ravi@example.com'),
('Anita Sharma', 'anita@example.com'),
('John Doe', 'john@example.com'),
('Priya Raj', 'priya@example.com');

INSERT INTO registrations (user_id, event_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3),
(4, 4);

SELECT e.event_name, COUNT(r.reg_id) AS total_registrations
FROM events e
LEFT JOIN registrations r ON e.event_id = r.event_id
GROUP BY e.event_name;

SELECT event_name, event_date, location
FROM events
WHERE event_date > CURDATE()
ORDER BY event_date;








