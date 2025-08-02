CREATE DATABASE online_gadget_store;
USE online_gadget_store;

-- 1. Create categories table
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- 2. Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 3. Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    location VARCHAR(100),
    signup_date DATE
);

-- 4. Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample categories
INSERT INTO categories (category_id, category_name) VALUES
(1, 'Smartphones'),
(2, 'Laptops'),
(3, 'Accessories'),
(4, 'Tablets');

-- Insert sample products
INSERT INTO products (product_id, product_name, category_id, price) VALUES
(1, 'iPhone 14', 1, 79999),
(2, 'MacBook Air', 2, 99999),
(3, 'USB-C Cable', 3, 999),
(4, 'Samsung Galaxy Tab', 4, 45000),
(5, 'Bluetooth Earbuds', 3, 1999),
(6, 'Dell XPS 13', 2, 85000);

-- Insert sample customers
INSERT INTO customers (customer_id, customer_name, location, signup_date) VALUES
(1, 'Alice', 'Chennai', '2025-01-15'),
(2, 'Bob', 'Mumbai', '2025-03-10'),
(3, 'Charlie', 'Delhi', '2025-02-05'),
(4, 'Diana', 'Chennai', '2025-04-20'),
(5, 'Eve', 'Bangalore', '2025-05-01');

-- Insert sample orders
INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity) VALUES
(101, 1, 1, '2025-05-10', 1),
(102, 1, 3, '2025-05-11', 2),
(103, 2, 2, '2025-06-12', 1),
(104, 3, 4, '2025-06-15', 1),
(105, 3, 5, '2025-06-20', 1),
(106, 2, 1, '2025-06-25', 1),
(107, 4, 2, '2025-07-01', 1),
(108, 5, 6, '2025-07-02', 1);

--  1. Use DISTINCT to get unique customer locations
SELECT DISTINCT location
FROM customers;

--  2. Use BETWEEN to filter high-value orders (>= ₹50,000 total value)
SELECT 
    o.order_id,
    c.customer_name,
    p.product_name,
    (o.quantity * p.price) AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE (o.quantity * p.price) BETWEEN 50000 AND 200000;

--  3. Subquery in WHERE to find customers who never ordered accessories
SELECT customer_name
FROM customers
WHERE customer_id NOT IN (
    SELECT DISTINCT o.customer_id
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    WHERE p.category_id = (
        SELECT category_id FROM categories WHERE category_name = 'Accessories'
    )
);

--  4. Use MAX(), MIN() for order value analytics
SELECT 
    MAX(o.quantity * p.price) AS max_order_value,
    MIN(o.quantity * p.price) AS min_order_value
FROM orders o
JOIN products p ON o.product_id = p.product_id;

--  5. JOINs for full product category mapping
SELECT 
    p.product_name,
    c.category_name,
    p.price
FROM products p
JOIN categories c ON p.category_id = c.category_id;

--  6. Sort by most purchased products
SELECT 
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;

--  7. CASE to label customers as "VIP" if >2 orders, else "Regular"
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    CASE 
        WHEN COUNT(o.order_id) > 2 THEN 'VIP'
        ELSE 'Regular'
    END AS customer_status
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
