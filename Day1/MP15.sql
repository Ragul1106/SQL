CREATE DATABASE rental_db;
USE rental_db;

CREATE TABLE vehicle_types (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(100),
    type_id INT,
    daily_rate DECIMAL(10,2),
    FOREIGN KEY (type_id) REFERENCES vehicle_types(type_id)
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT,
    customer_id INT,
    start_date DATE,
    end_date DATE,
    total_cost DECIMAL(10,2),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO vehicle_types (type_name) VALUES
('Car'), ('Bike'), ('Truck');

INSERT INTO vehicles (model, type_id, daily_rate) VALUES
('Honda City', 1, 1500.00),
('Bajaj Pulsar', 2, 500.00),
('Tata Ace', 3, 2000.00),
('Maruti Swift', 1, 1300.00);

INSERT INTO customers (name, phone, email) VALUES
('Rahul Verma', '9876543210', 'rahul@example.com'),
('Neha Mehta', '9123456780', 'neha@example.com'),
('Amit Singh', '9998887776', 'amit@example.com');

INSERT INTO rentals (vehicle_id, customer_id, start_date, end_date, total_cost) VALUES
(1, 1, '2025-07-01', '2025-07-05', 7500.00),
(2, 2, '2025-07-10', '2025-07-12', 1000.00),
(3, 3, '2025-07-15', '2025-07-18', 6000.00),
(4, 1, '2025-07-20', '2025-07-23', 5200.00);

SELECT v.model, r.start_date, r.end_date, c.name
FROM rentals r
JOIN vehicles v ON r.vehicle_id = v.vehicle_id
JOIN customers c ON r.customer_id = c.customer_id
WHERE r.start_date BETWEEN '2025-07-01' AND '2025-07-15';

SELECT vt.type_name, SUM(r.total_cost) AS total_income
FROM rentals r
JOIN vehicles v ON r.vehicle_id = v.vehicle_id
JOIN vehicle_types vt ON v.type_id = vt.type_id
GROUP BY vt.type_name;









