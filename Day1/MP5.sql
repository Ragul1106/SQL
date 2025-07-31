CREATE DATABASE gym_db;
USE gym_db;

CREATE TABLE trainers (
    trainer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100)
);

CREATE TABLE plans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_name VARCHAR(100) NOT NULL UNIQUE,
    duration_months INT NOT NULL,
    price DECIMAL(8, 2) NOT NULL
);


CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    trainer_id INT,
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id)
);


CREATE TABLE subscriptions (
    subscription_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    plan_id INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (plan_id) REFERENCES plans(plan_id)
);

INSERT INTO trainers (name, specialization) VALUES
('Alex', 'Strength'),
('Bella', 'Yoga'),
('Charlie', 'Cardio');

INSERT INTO plans (plan_name, duration_months, price) VALUES
('Basic', 1, 1000.00),
('Standard', 3, 2700.00),
('Premium', 6, 5000.00),
('Family', 12, 9000.00),
('Student', 3, 2000.00);

INSERT INTO members (name, email, trainer_id) VALUES
('Ravi', 'ravi@gym.com', 1),
('Sneha', 'sneha@gym.com', 2),
('Amit', 'amit@gym.com', 1),
('Tina', 'tina@gym.com', 3),
('Karan', 'karan@gym.com', 2),
('Meena', 'meena@gym.com', 3),
('Vikram', 'vikram@gym.com', 1),
('Anjali', 'anjali@gym.com', 2),
('Deepak', 'deepak@gym.com', 3),
('Nisha', 'nisha@gym.com', 1);

INSERT INTO subscriptions (member_id, plan_id, start_date, end_date) VALUES
(1, 1, '2025-07-01', '2025-07-31'),
(2, 2, '2025-06-15', '2025-09-15'),
(3, 3, '2025-01-01', '2025-06-30'),  
(4, 1, '2025-07-10', '2025-08-09'),
(5, 5, '2025-03-01', '2025-06-01'),  
(6, 4, '2025-07-01', '2026-06-30'),
(7, 1, '2025-07-15', '2025-08-14'),
(8, 3, '2025-02-01', '2025-07-30'),
(9, 2, '2025-05-01', '2025-08-01'),
(10, 4, '2025-07-01', '2026-06-30');

UPDATE subscriptions
SET plan_id = 3
WHERE member_id = 1;

DELETE FROM subscriptions
WHERE end_date < '2025-07-30';





