CREATE DATABASE airline_db;
USE airline_db;

CREATE TABLE airports (
    airport_id INT AUTO_INCREMENT PRIMARY KEY,
    airport_name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE flights (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_number VARCHAR(20) NOT NULL UNIQUE,
    origin_airport_id INT,
    destination_airport_id INT,
    departure_time DATETIME,
    arrival_time DATETIME,
    FOREIGN KEY (origin_airport_id) REFERENCES airports(airport_id),
    FOREIGN KEY (destination_airport_id) REFERENCES airports(airport_id)
);

CREATE TABLE passengers (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT,
    flight_id INT,
    seat_number VARCHAR(10),
    booking_date DATE,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

INSERT INTO airports (airport_name, city, country) VALUES
('Chennai International', 'Chennai', 'India'),
('Indira Gandhi International', 'Delhi', 'India'),
('Kempegowda International', 'Bangalore', 'India'),
('Chhatrapati Shivaji Intl', 'Mumbai', 'India'),
('Rajiv Gandhi International', 'Hyderabad', 'India');

INSERT INTO flights (flight_number, origin_airport_id, destination_airport_id, departure_time, arrival_time) VALUES
('AI101', 1, 2, '2025-08-01 09:00:00', '2025-08-01 11:00:00'),
('AI102', 2, 3, '2025-08-01 13:00:00', '2025-08-01 15:00:00'),
('AI103', 3, 4, '2025-08-02 07:00:00', '2025-08-02 09:30:00'),
('AI104', 4, 5, '2025-08-03 17:00:00', '2025-08-03 19:30:00'),
('AI105', 1, 5, '2025-08-04 06:30:00', '2025-08-04 09:00:00');

INSERT INTO passengers (name, email) VALUES
('Ravi', 'ravi@email.com'),
('Sneha', 'sneha@email.com'),
('Amit', 'amit@email.com'),
('Tina', 'tina@email.com'),
('Karan', 'karan@email.com'),
('Meena', 'meena@email.com'),
('Vikram', 'vikram@email.com'),
('Anjali', 'anjali@email.com'),
('Deepak', 'deepak@email.com'),
('Nisha', 'nisha@email.com');

INSERT INTO bookings (passenger_id, flight_id, seat_number, booking_date) VALUES
(1, 1, '12A', '2025-07-28'),
(2, 1, '12B', '2025-07-28'),
(3, 2, '10A', '2025-07-29'),
(4, 2, '10B', '2025-07-29'),
(5, 3, '9C', '2025-07-30'),
(6, 4, '8A', '2025-07-30'),
(7, 5, '7D', '2025-07-31'),
(8, 5, '7E', '2025-07-31'),
(9, 3, '9A', '2025-07-31'),
(10, 4, '8C', '2025-07-31');

SELECT f.flight_number, f.departure_time, f.arrival_time
FROM flights f
JOIN airports a1 ON f.origin_airport_id = a1.airport_id
JOIN airports a2 ON f.destination_airport_id = a2.airport_id
WHERE a1.city = 'Chennai' AND a2.city = 'Delhi';

SELECT p.name, p.email, b.seat_number
FROM bookings b
JOIN passengers p ON b.passenger_id = p.passenger_id
JOIN flights f ON b.flight_id = f.flight_id
WHERE f.flight_number = 'AI101';










