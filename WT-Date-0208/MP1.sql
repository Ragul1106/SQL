-- Online Bookstore Inventory & Sales Analysis

-- 1. Create database tables
CREATE DATABASE bookstore;
USE bookstore;

-- Create authors table
CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    email VARCHAR(100)
);

-- Create books table
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    genre VARCHAR(50),
    price DECIMAL(10, 2),
    publication_date DATE,
    stock_quantity INT,
    is_ebook BOOLEAN,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    join_date DATE,
    loyalty_points INT
);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    order_date DATE,
    quantity INT,
    total_price DECIMAL(10, 2),
    payment_method VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- 2. Insert sample data
-- Insert authors
INSERT INTO authors VALUES
(1, 'J.K. Rowling', 'UK', 'jkrowling@email.com'),
(2, 'George R.R. Martin', 'USA', 'grrm@email.com'),
(3, 'Stephen King', 'USA', 'sking@email.com'),
(4, 'Agatha Christie', 'UK', 'achristie@email.com'),
(5, 'Yuval Noah Harari', 'Israel', 'ynharari@email.com');

-- Insert books
INSERT INTO books VALUES
(101, 'Harry Potter and the Philosopher''s Stone', 1, 'Fantasy', 12.99, '1997-06-26', 50, FALSE),
(102, 'A Game of Thrones', 2, 'Fantasy', 14.99, '1996-08-01', 35, FALSE),
(103, 'The Shining', 3, 'Horror', 9.99, '1977-01-28', 40, TRUE),
(104, 'Murder on the Orient Express', 4, 'Mystery', 8.99, '1934-01-01', 25, FALSE),
(105, 'Sapiens', 5, 'Non-Fiction', 15.99, '2011-02-10', 60, TRUE),
(106, 'Harry Potter and the Chamber of Secrets', 1, 'Fantasy', 12.99, '1998-07-02', 45, FALSE),
(107, 'The Stand', 3, 'Horror', 11.99, '1978-09-01', 30, TRUE),
(108, 'And Then There Were None', 4, 'Mystery', 7.99, '1939-11-06', 20, FALSE),
(109, 'Homo Deus', 5, 'Non-Fiction', 16.99, '2015-09-01', 55, TRUE),
(110, 'Unsold Book', 1, 'Fantasy', 10.99, '2020-01-01', 15, FALSE);

-- Insert customers
INSERT INTO customers VALUES
(1001, 'John Smith', 'john.smith@email.com', '2022-01-15', 150),
(1002, 'Emily Davis', 'emily.davis@email.com', '2022-03-22', 75),
(1003, 'Michael Johnson', 'michael.j@email.com', '2021-11-05', 300),
(1004, 'Sarah Wilson', 'sarah.wilson@email.com', '2023-02-10', 50),
(1005, 'David Brown', 'david.b@email.com', '2021-07-30', 200);

-- Insert orders
INSERT INTO orders VALUES
(5001, 1001, 101, '2023-01-10', 1, 12.99, 'Credit Card'),
(5002, 1002, 102, '2023-01-15', 1, 14.99, 'PayPal'),
(5003, 1003, 103, '2023-02-05', 2, 19.98, 'Credit Card'),
(5004, 1004, 101, '2023-02-20', 1, 12.99, 'Debit Card'),
(5005, 1005, 105, '2023-03-01', 1, 15.99, 'Credit Card'),
(5006, 1001, 106, '2023-03-15', 1, 12.99, 'PayPal'),
(5007, 1003, 107, '2023-04-02', 1, 11.99, 'Credit Card'),
(5008, 1002, 104, '2023-04-10', 1, 8.99, 'Debit Card'),
(5009, 1005, 108, '2023-05-05', 1, 7.99, 'Credit Card'),
(5010, 1004, 109, '2023-05-20', 1, 16.99, 'PayPal'),
(5011, 1001, 102, '2023-06-01', 2, 29.98, 'Credit Card'),
(5012, 1003, 105, '2023-06-15', 1, 15.99, 'Debit Card'),
(5013, 1002, 101, '2023-07-01', 1, 12.99, 'Credit Card'),
(5014, 1005, 103, '2023-07-10', 1, 9.99, 'PayPal'),
(5015, 1004, 107, '2023-08-05', 1, 11.99, 'Credit Card');

-- 3. Analysis Queries

-- 1. Retrieve books with SELECT, filter by genre using WHERE
SELECT book_id, title, author_id, price
FROM books
WHERE genre = 'Fantasy';

-- 2. Use JOINs to combine books with authors and sales
SELECT b.title, a.author_name, b.genre, o.order_date, o.quantity, o.total_price
FROM books b
JOIN authors a ON b.author_id = a.author_id
JOIN orders o ON b.book_id = o.book_id;

-- 3. Show total and average sales per author (GROUP BY, AVG())
SELECT 
    a.author_name,
    SUM(o.total_price) AS total_sales,
    AVG(o.total_price) AS average_sale_amount,
    COUNT(o.order_id) AS number_of_sales
FROM authors a
JOIN books b ON a.author_id = b.author_id
JOIN orders o ON b.book_id = o.book_id
GROUP BY a.author_name
ORDER BY total_sales DESC;

-- 4. Filter duplicate books using DISTINCT
SELECT DISTINCT title, author_id
FROM books;

-- 5. Use BETWEEN to filter orders by date
SELECT o.order_id, b.title, c.customer_name, o.order_date, o.total_price
FROM orders o
JOIN books b ON o.book_id = b.book_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_date BETWEEN '2023-01-01' AND '2023-06-30';

-- 6. Use a subquery in WHERE to find books never sold
SELECT b.title, a.author_name
FROM books b
JOIN authors a ON b.author_id = a.author_id
WHERE b.book_id NOT IN (
    SELECT DISTINCT book_id 
    FROM orders
);

-- 7. Use CASE WHEN to classify sales performance (low/medium/high)
SELECT 
    b.title,
    a.author_name,
    SUM(o.total_price) AS total_revenue,
    CASE
        WHEN SUM(o.total_price) < 20 THEN 'Low'
        WHEN SUM(o.total_price) BETWEEN 20 AND 50 THEN 'Medium'
        ELSE 'High'
    END AS sales_performance
FROM books b
JOIN authors a ON b.author_id = a.author_id
JOIN orders o ON b.book_id = o.book_id
GROUP BY b.title, a.author_name;

-- 8. Sort books by revenue and author name
SELECT 
    b.title,
    a.author_name,
    SUM(o.total_price) AS total_revenue
FROM books b
JOIN authors a ON b.author_id = a.author_id
JOIN orders o ON b.book_id = o.book_id
GROUP BY b.title, a.author_name
ORDER BY total_revenue DESC, a.author_name ASC;

-- 9. Use UNION to merge physical and eBook sales
SELECT 
    b.title,
    'Physical' AS book_type,
    SUM(o.quantity) AS total_quantity,
    SUM(o.total_price) AS total_sales
FROM books b
JOIN orders o ON b.book_id = o.book_id
WHERE b.is_ebook = FALSE
GROUP BY b.title

UNION

SELECT 
    b.title,
    'eBook' AS book_type,
    SUM(o.quantity) AS total_quantity,
    SUM(o.total_price) AS total_sales
FROM books b
JOIN orders o ON b.book_id = o.book_id
WHERE b.is_ebook = TRUE
GROUP BY b.title
ORDER BY total_sales DESC;