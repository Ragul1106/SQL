CREATE DATABASE cinema_db;
use cinema_db;

CREATE TABLE screens (
    screen_id INT PRIMARY KEY AUTO_INCREMENT, 
    screen_name VARCHAR(100) NOT NULL UNIQUE,
    seat INT 
);

INSERT INTO screens (screen_name, seat) VALUES
('Screen 1', 150),
('Screen 2', 100),
('Screen 3', 90);


CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(255) NOT NULL UNIQUE,
    genre VARCHAR(100),
    duration_minutes INT NOT NULL CHECK (duration_minutes > 0),
    release_date DATE
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT, 
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE showtimes (
    showtime_id INT PRIMARY KEY AUTO_INCREMENT, 
    movie_id INT NOT NULL,
    screen_id INT NOT NULL,
    show_datetime DATETIME NOT NULL, 
    price_per_ticket DECIMAL(5, 2) NOT NULL DEFAULT 10.00,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (screen_id) REFERENCES screens(screen_id) ON DELETE CASCADE,
    UNIQUE (screen_id, show_datetime) 
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT, -- Use SERIAL for PostgreSQL
    customer_id INT NOT NULL,
    showtime_id INT NOT NULL,
    number_of_tickets INT NOT NULL CHECK (number_of_tickets > 0),
    booking_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- When the booking was made
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (showtime_id) REFERENCES showtimes(showtime_id) ON DELETE CASCADE
);

 

INSERT INTO movies (title, genre, duration_minutes, release_date) VALUES
('The Galactic Odyssey', 'Sci-Fi', 145, '2024-07-15'),
('Love in Paris', 'Romance', 110, '2024-06-01'),
('Detective Chronicles', 'Mystery', 120, '2024-07-20'),
('Animated Adventures', 'Animation', 95, '2024-05-10'),
('Historical Epic', 'Drama', 180, '2024-07-25');

INSERT INTO customers (first_name, last_name, email) VALUES
('Alice', 'Smith', 'alice.s@example.com'),
('Bob', 'Johnson', 'bob.j@example.com'),
('Charlie', 'Brown', 'charlie.b@example.com'),
('Diana', 'Prince', 'diana.p@example.com'),
('Ethan', 'Hunt', 'ethan.h@example.com'),
('Fiona', 'Apple', 'fiona.a@example.com'),
('George', 'Clooney', 'george.c@example.com'),
('Hannah', 'Montana', 'hannah.m@example.com');

INSERT INTO showtimes (movie_id, screen_id, show_datetime, price_per_ticket) VALUES
(1, 1, '2025-08-01 10:00:00', 12.50), 
(1, 1, '2025-08-01 14:00:00', 12.50), 
(1, 2, '2025-08-01 18:00:00', 15.00), 
(2, 1, '2025-08-01 17:00:00', 10.00), 
(3, 3, '2025-08-01 19:30:00', 13.00), 
(4, 2, '2025-08-01 11:00:00', 10.00), 
(5, 3, '2025-08-01 21:00:00', 13.00), 
(1, 1, '2025-08-02 10:00:00', 12.50), 
(3, 3, '2025-08-02 19:30:00', 13.00); 

INSERT INTO bookings (customer_id, showtime_id, number_of_tickets, booking_date, total_price) VALUES
(1, 1, 2, '2025-07-30 10:00:00', 2 * 12.50), 
(2, 1, 3, '2025-07-30 11:00:00', 3 * 12.50), 
(3, 2, 1, '2025-07-30 12:00:00', 1 * 12.50), 
(4, 3, 4, '2025-07-30 13:00:00', 4 * 15.00), 
(5, 4, 2, '2025-07-30 14:00:00', 2 * 10.00), 
(6, 5, 3, '2025-07-30 15:00:00', 3 * 13.00), 
(7, 6, 1, '2025-07-30 16:00:00', 1 * 10.00), 
(8, 7, 2, '2025-07-30 17:00:00', 2 * 13.00), 
(1, 2, 2, '2025-07-31 09:00:00', 2 * 12.50), 
(2, 3, 1, '2025-07-31 10:00:00', 1 * 15.00), 
(3, 1, 2, '2025-07-31 11:00:00', 2 * 12.50), 
(4, 5, 2, '2025-07-31 12:00:00', 2 * 13.00), 
(5, 4, 1, '2025-07-31 13:00:00', 1 * 10.00),
(6, 1, 3, '2025-07-31 14:00:00', 3 * 12.50),
(7, 8, 1, '2025-07-31 15:00:00', 1 * 12.50);

SELECT
    m.title AS movie_title,
    s.screen_name,
    st.show_datetime,
    st.price_per_ticket,
    SUM(b.number_of_tickets) AS total_booked_seats,
    (s.seat - SUM(b.number_of_tickets)) AS remaining_seats,
    s.seat AS screen_capacity
FROM
    showtimes st
JOIN
    movies m ON st.movie_id = m.movie_id
JOIN
    screens s ON st.screen_id = s.screen_id
LEFT JOIN 
    bookings b ON st.showtime_id = b.showtime_id
GROUP BY
    st.showtime_id, m.title, s.screen_name, st.show_datetime, st.price_per_ticket, s.seat
ORDER BY
    st.show_datetime, s.screen_name;
    
SELECT
    m.title AS movie_title,
    m.genre,
    SUM(b.number_of_tickets) AS total_tickets_sold
FROM
    movies m
JOIN
    showtimes st ON m.movie_id = st.movie_id
JOIN
    bookings b ON st.showtime_id = b.showtime_id
GROUP BY
    m.movie_id, m.title, m.genre
ORDER BY
    total_tickets_sold DESC
LIMIT 3;