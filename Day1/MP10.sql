CREATE DATABASE hotel_db;
USE hotel_db;

CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT, 
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type VARCHAR(50) NOT NULL, 
    price_per_night DECIMAL(10, 2) NOT NULL CHECK (price_per_night > 0),
    status VARCHAR(20) NOT NULL DEFAULT 'Available' 
);

CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT, 
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20)
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT, 
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_room_price DECIMAL(10, 2) NOT NULL, 
    booking_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id) ON DELETE CASCADE,
    CHECK (check_out_date > check_in_date)
);

CREATE TABLE services (
    service_id INT PRIMARY KEY AUTO_INCREMENT, 
    service_name VARCHAR(100) NOT NULL UNIQUE,
    service_charge DECIMAL(10, 2) NOT NULL CHECK (service_charge >= 0)
);

CREATE TABLE guest_services_ordered (
    order_id INT PRIMARY KEY AUTO_INCREMENT, 
    guest_id INT NOT NULL,
    service_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    total_service_item_charge DECIMAL(10, 2) NOT NULL, 
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE
);

INSERT INTO rooms (room_number, room_type, price_per_night, status) VALUES
('101', 'Standard', 100.00, 'Available'),
('102', 'Standard', 100.00, 'Available'),
('201', 'Deluxe', 150.00, 'Available'),
('202', 'Deluxe', 150.00, 'Occupied'), 
('301', 'Suite', 250.00, 'Available'),
('302', 'Suite', 250.00, 'Maintenance');

INSERT INTO guests (first_name, last_name, email, phone_number) VALUES
('Alice', 'Wonder', 'alice@example.com', '555-1111'),
('Bob', 'Builder', 'bob@example.com', '555-2222'),
('Charlie', 'Chaplin', 'charlie@example.com', '555-3333'),
('Diana', 'Prince', 'diana@example.com', '555-4444'),
('Eve', 'Adams', 'eve@example.com', '555-5555');

INSERT INTO services (service_name, service_charge) VALUES
('Room Service', 25.00),
('Laundry Service', 15.00),
('Spa Access', 50.00),
('Minibar Refill', 10.00),
('Extra Towels', 5.00);

INSERT INTO bookings (guest_id, room_id, check_in_date, check_out_date, total_room_price, booking_date) VALUES
(1, 1, '2025-08-01', '2025-08-05', (SELECT price_per_night FROM rooms WHERE room_id = 1) * 4, '2025-07-25 10:00:00'), 
(2, 2, '2025-08-03', '2025-08-07', (SELECT price_per_night FROM rooms WHERE room_id = 2) * 4, '2025-07-26 11:00:00'), 
(3, 3, '2025-08-05', '2025-08-08', (SELECT price_per_night FROM rooms WHERE room_id = 3) * 3, '2025-07-27 12:00:00'), 
(4, 1, '2025-08-06', '2025-08-10', (SELECT price_per_night FROM rooms WHERE room_id = 1) * 4, '2025-07-28 13:00:00'), 
(5, 5, '2025-08-07', '2025-08-09', (SELECT price_per_night FROM rooms WHERE room_id = 5) * 2, '2025-07-29 14:00:00'), 
(1, 3, '2025-08-10', '2025-08-12', (SELECT price_per_night FROM rooms WHERE room_id = 3) * 2, '2025-07-30 15:00:00'), 
(2, 5, '2025-08-11', '2025-08-14', (SELECT price_per_night FROM rooms WHERE room_id = 5) * 3, '2025-07-30 16:00:00'), 
(3, 1, '2025-08-15', '2025-08-16', (SELECT price_per_night FROM rooms WHERE room_id = 1) * 1, '2025-07-31 09:00:00'), 
(4, 2, '2025-08-18', '2025-08-20', (SELECT price_per_night FROM rooms WHERE room_id = 2) * 2, '2025-07-31 10:00:00'), 
(5, 3, '2025-08-22', '2025-08-25', (SELECT price_per_night FROM rooms WHERE room_id = 3) * 3, '2025-07-31 11:00:00');

INSERT INTO guest_services_ordered (guest_id, service_id, quantity, total_service_item_charge, order_date) VALUES
(1, 1, 1, (SELECT service_charge FROM services WHERE service_id = 1) * 1, '2025-08-02 08:30:00'), 
(1, 3, 1, (SELECT service_charge FROM services WHERE service_id = 3) * 1, '2025-08-03 10:00:00'), 
(2, 2, 2, (SELECT service_charge FROM services WHERE service_id = 2) * 2, '2025-08-04 14:00:00'), 
(3, 1, 1, (SELECT service_charge FROM services WHERE service_id = 1) * 1, '2025-08-06 09:00:00'), 
(3, 4, 3, (SELECT service_charge FROM services WHERE service_id = 4) * 3, '2025-08-07 11:00:00'), 
(4, 3, 1, (SELECT service_charge FROM services WHERE service_id = 3) * 1, '2025-08-08 16:00:00'), 
(5, 2, 1, (SELECT service_charge FROM services WHERE service_id = 2) * 1, '2025-08-08 17:00:00'), 
(1, 5, 1, (SELECT service_charge FROM services WHERE service_id = 5) * 1, '2025-08-11 10:00:00'), 
(2, 4, 2, (SELECT service_charge FROM services WHERE service_id = 4) * 2, '2025-08-12 18:00:00'), 
(4, 1, 1, (SELECT service_charge FROM services WHERE service_id = 1) * 1, '2025-08-19 08:00:00');

SELECT
    b.booking_id,
    g.first_name AS guest_first_name,
    g.last_name AS guest_last_name,
    r.room_number,
    b.check_in_date,
    b.check_out_date,
    DATEDIFF(b.check_out_date, b.check_in_date) AS booking_duration_days, 
    b.total_room_price
FROM
    bookings b
JOIN
    guests g ON b.guest_id = g.guest_id
JOIN
    rooms r ON b.room_id = r.room_id
ORDER BY
    b.check_in_date;
    
SELECT
    g.guest_id,
    g.first_name,
    g.last_name,
    g.email,
    COALESCE(SUM(gso.total_service_item_charge), 0.00) AS total_service_charges
FROM
    guests g
LEFT JOIN 
    guest_services_ordered gso ON g.guest_id = gso.guest_id
GROUP BY
    g.guest_id, g.first_name, g.last_name, g.email
ORDER BY
    total_service_charges DESC, g.last_name, g.first_name;