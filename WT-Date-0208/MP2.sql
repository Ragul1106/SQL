-- Movie Rental Store Management 

-- 1. Create database tables
CREATE DATABASE movie_rental;
USE movie_rental;

-- Create genres table
CREATE TABLE genres (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
);

-- Create movies table
CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre_id INT,
    release_year INT,
    rental_price DECIMAL(5, 2),
    purchase_price DECIMAL(6, 2),
    stock_quantity INT,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    join_date DATE
);

-- Create rentals table
CREATE TABLE rentals (
    rental_id INT PRIMARY KEY,
    customer_id INT,
    movie_id INT,
    rental_date DATE NOT NULL,
    return_date DATE,
    due_date DATE NOT NULL,
    payment_type ENUM('rental', 'purchase'),
    amount_paid DECIMAL(6, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

-- 2. Insert sample data
-- Insert genres
INSERT INTO genres VALUES
(1, 'Action'),
(2, 'Comedy'),
(3, 'Drama'),
(4, 'Sci-Fi'),
(5, 'Horror');

-- Insert movies
INSERT INTO movies VALUES
(101, 'The Dark Knight', 1, 2008, 3.99, 14.99, 10),
(102, 'Avengers: Endgame', 1, 2019, 4.99, 19.99, 8),
(103, 'Superbad', 2, 2007, 2.99, 9.99, 12),
(104, 'The Hangover', 2, 2009, 3.49, 12.99, 7),
(105, 'The Shawshank Redemption', 3, 1994, 2.49, 7.99, 15),
(106, 'Forrest Gump', 3, 1994, 2.99, 8.99, 9),
(107, 'Inception', 4, 2010, 3.99, 14.99, 11),
(108, 'Interstellar', 4, 2014, 4.49, 16.99, 6),
(109, 'The Conjuring', 5, 2013, 3.49, 12.99, 13),
(110, 'Hereditary', 5, 2018, 3.99, 14.99, 5),
(111, 'Dark Knight Rises', 1, 2012, 3.99, 14.99, 7),
(112, 'Step Brothers', 2, 2008, 2.99, 9.99, 9);

-- Insert customers
INSERT INTO customers VALUES
(1001, 'John', 'Smith', 'john.smith@email.com', '555-0101', '2022-01-15'),
(1002, 'Emily', 'Davis', 'emily.davis@email.com', '555-0102', '2022-03-22'),
(1003, 'Michael', 'Johnson', 'michael.j@email.com', '555-0103', '2021-11-05'),
(1004, 'Sarah', 'Wilson', 'sarah.wilson@email.com', '555-0104', '2023-02-10'),
(1005, 'David', 'Brown', 'david.b@email.com', '555-0105', '2021-07-30');

-- Insert rentals
INSERT INTO rentals VALUES
(5001, 1001, 101, '2023-01-10', '2023-01-17', '2023-01-17', 'rental', 3.99),
(5002, 1002, 102, '2023-01-15', '2023-01-22', '2023-01-22', 'rental', 4.99),
(5003, 1003, 103, '2023-02-05', '2023-02-12', '2023-02-12', 'rental', 2.99),
(5004, 1004, 101, '2023-02-20', '2023-02-27', '2023-02-27', 'rental', 3.99),
(5005, 1005, 105, '2023-03-01', '2023-03-08', '2023-03-08', 'rental', 2.49),
(5006, 1001, 106, '2023-03-15', '2023-03-22', '2023-03-22', 'rental', 2.99),
(5007, 1003, 107, '2023-04-02', NULL, '2023-04-09', 'rental', 3.99),
(5008, 1002, 104, '2023-04-10', '2023-04-20', '2023-04-17', 'rental', 3.49),
(5009, 1005, 108, '2023-05-05', '2023-05-15', '2023-05-12', 'rental', 4.49),
(5010, 1004, 109, '2023-05-20', NULL, '2023-05-27', 'rental', 3.49),
(5011, 1001, 102, '2023-06-01', '2023-06-08', '2023-06-08', 'purchase', 19.99),
(5012, 1003, 105, '2023-06-15', NULL, '2023-06-22', 'rental', 2.49),
(5013, 1002, 101, '2023-07-01', '2023-07-08', '2023-07-08', 'purchase', 14.99),
(5014, 1005, 103, '2023-07-10', '2023-07-20', '2023-07-17', 'rental', 2.99),
(5015, 1004, 107, '2023-08-05', NULL, '2023-08-12', 'rental', 3.99);

-- 3. Analysis Queries

-- 1. Use subqueries to find top 3 rented movies per genre
SELECT g.genre_name, m.title, rental_count
FROM (
    SELECT 
        m.genre_id,
        m.movie_id,
        COUNT(r.rental_id) AS rental_count,
        ROW_NUMBER() OVER (PARTITION BY m.genre_id ORDER BY COUNT(r.rental_id) DESC) AS rank_in_genre
    FROM movies m
    JOIN rentals r ON m.movie_id = r.movie_id
    WHERE r.payment_type = 'rental'
    GROUP BY m.genre_id, m.movie_id
) AS ranked_movies
JOIN movies m ON ranked_movies.movie_id = m.movie_id
JOIN genres g ON m.genre_id = g.genre_id
WHERE rank_in_genre <= 3
ORDER BY g.genre_name, rental_count DESC;

-- 2. Use LIKE to search movies by partial title
SELECT movie_id, title, release_year
FROM movies
WHERE title LIKE '%Dark%';

-- 3. Aggregate revenue per genre using GROUP BY, SUM()
SELECT 
    g.genre_name,
    COUNT(r.rental_id) AS total_rentals,
    SUM(r.amount_paid) AS total_revenue,
    ROUND(SUM(r.amount_paid) / COUNT(r.rental_id), 2) AS avg_revenue_per_rental
FROM genres g
JOIN movies m ON g.genre_id = m.genre_id
JOIN rentals r ON m.movie_id = r.movie_id
GROUP BY g.genre_name
ORDER BY total_revenue DESC;

-- 4. Filter null return dates (IS NULL) to find unreturned movies
SELECT 
    r.rental_id,
    m.title,
    c.first_name,
    c.last_name,
    r.rental_date,
    r.due_date,
    DATEDIFF(CURRENT_DATE, r.due_date) AS days_overdue
FROM rentals r
JOIN movies m ON r.movie_id = m.movie_id
JOIN customers c ON r.customer_id = c.customer_id
WHERE r.return_date IS NULL AND r.payment_type = 'rental'
ORDER BY days_overdue DESC;

-- 5. Use CASE to label late returns
SELECT 
    r.rental_id,
    m.title,
    c.first_name,
    c.last_name,
    r.rental_date,
    r.return_date,
    r.due_date,
    CASE
        WHEN r.return_date IS NULL THEN 'Not Returned'
        WHEN r.return_date > r.due_date THEN 'Late Return'
        ELSE 'On Time'
    END AS return_status,
    CASE
        WHEN r.return_date > r.due_date THEN DATEDIFF(r.return_date, r.due_date)
        WHEN r.return_date IS NULL THEN DATEDIFF(CURRENT_DATE, r.due_date)
        ELSE 0
    END AS days_late
FROM rentals r
JOIN movies m ON r.movie_id = m.movie_id
JOIN customers c ON r.customer_id = c.customer_id
WHERE r.payment_type = 'rental'
ORDER BY days_late DESC;

-- 6. Combine rental and purchase data using UNION ALL
SELECT 
    'Rental' AS transaction_type,
    m.title,
    r.amount_paid,
    r.rental_date AS transaction_date,
    c.first_name,
    c.last_name
FROM rentals r
JOIN movies m ON r.movie_id = m.movie_id
JOIN customers c ON r.customer_id = c.customer_id
WHERE r.payment_type = 'rental'

UNION ALL

SELECT 
    'Purchase' AS transaction_type,
    m.title,
    r.amount_paid,
    r.rental_date AS transaction_date,
    c.first_name,
    c.last_name
FROM rentals r
JOIN movies m ON r.movie_id = m.movie_id
JOIN customers c ON r.customer_id = c.customer_id
WHERE r.payment_type = 'purchase'
ORDER BY transaction_date DESC;

-- 7. Use JOIN to fetch full customer and rental info
SELECT 
    r.rental_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.phone,
    m.title,
    g.genre_name,
    r.rental_date,
    r.due_date,
    r.return_date,
    r.amount_paid,
    r.payment_type,
    CASE
        WHEN r.return_date IS NULL AND r.due_date < CURRENT_DATE THEN 'Overdue'
        WHEN r.return_date > r.due_date THEN 'Returned Late'
        WHEN r.return_date IS NULL THEN 'Currently Rented'
        ELSE 'Returned On Time'
    END AS rental_status
FROM rentals r
JOIN customers c ON r.customer_id = c.customer_id
JOIN movies m ON r.movie_id = m.movie_id
JOIN genres g ON m.genre_id = g.genre_id
ORDER BY r.rental_date DESC;