CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    address TEXT,
    registration_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    shipment_date DATE,
    delivery_status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO customers (name, email, phone_number, address, registration_date) VALUES
('Ragul', 'ragul@example.com', '9876000001', 'Bangalore, India', '2024-01-10'),
('Heera', 'heera@example.com', '9876000002', 'Mumbai, India', '2024-01-15'),
('Ravi ', 'ravi@example.com', '9876000003', 'Chennai, India', '2024-02-05'),
('Priya ', 'priya@example.com', '9876000004', 'Hyderabad, India', '2024-02-20'),
('Kiran ', 'kiran@example.com', '9876000005', 'Ahmedabad, India', '2024-03-01');
INSERT INTO customers (name, email, phone_number, address, registration_date) VALUES
('Rajan', 'rajan@example.com', '9876011111', 'Chennai, Tamil Nadu', '2024-01-05'),
('Ranjith Kumar', 'ranjith@example.com', '9876011112', 'Madurai, Tamil Nadu', '2024-01-10'),
('Libi Joseph', 'libi@example.com', '9876011113', 'Coimbatore, Tamil Nadu', '2024-01-12'),
('Arul Prakash', 'arul@example.com', '9876011114', 'Trichy, Tamil Nadu', '2024-01-15'),
('Divya Shree', 'divya@example.com', '9876011115', 'Salem, Tamil Nadu', '2024-01-20'),
('Vetri Vasanth', 'vetri@example.com', '9876011116', 'Erode, Tamil Nadu', '2024-01-22'),
('Mithra Vani', 'mithra@example.com', '9876011117', 'Thanjavur, Tamil Nadu', '2024-01-25'),
('Santhosh R', 'santhosh@example.com', '9876011118', 'Vellore, Tamil Nadu', '2024-01-28'),
('Meera Nair', 'meera@example.com', '9876011119', 'Nagercoil, Tamil Nadu', '2024-02-01'),
('Dinesh K', 'dinesh@example.com', '9876011120', 'Tirunelveli, Tamil Nadu', '2024-02-03');


INSERT INTO products (name, category, price, stock_quantity) VALUES
('Gaming Laptop', 'Electronics', 95000.00, 40),
('Bluetooth Speaker', 'Electronics', 3000.00, 150),
('Office Chair', 'Furniture', 7000.00, 30),
('Water Bottle', 'Accessories', 500.00, 500),
('Smartwatch', 'Electronics', 5000.00, 100);
INSERT INTO products (name, category, price, stock_quantity) VALUES
('Wireless Mouse', 'Accessories', 750.00, 200),
('Smartphone X', 'Electronics', 18000.00, 50),
('Laptop Pro 15"', 'Electronics', 65000.00, 30),
('Office Desk', 'Furniture', 5000.00, 20),
('LED Monitor 24"', 'Electronics', 9000.00, 40);


INSERT INTO orders (customer_id, order_date, total_amount, order_status) VALUES
(1, '2024-04-01', 98000.00, 'Confirmed'),
(2, '2024-04-03', 10000.00, 'Shipped'),
(3, '2024-04-05', 10500.00, 'Delivered'),
(4, '2024-04-10', 500.00, 'Pending'),
(5, '2024-04-12', 95000.00, 'Delivered');

INSERT INTO orders (customer_id, order_date, total_amount, order_status) VALUES
(16, '2024-04-01', 98000.00, 'Confirmed'),
(17, '2024-04-03', 10000.00, 'Shipped'),
(18, '2024-04-05', 10500.00, 'Delivered'),
(19, '2024-04-10', 500.00, 'Pending'),
(20, '2024-04-12', 95000.00, 'Delivered');



INSERT INTO order_details (order_id, product_id, quantity, subtotal_price) VALUES
(1, 1, 1, 95000.00),
(1, 4, 2, 1000.00),
(2, 2, 2, 6000.00),
(2, 5, 1, 5000.00),
(3, 3, 1, 7000.00),
(3, 4, 1, 500.00),
(3, 5, 1, 5000.00),
(4, 4, 1, 500.00),
(5, 1, 1, 95000.00);
INSERT INTO order_details (order_id, product_id, quantity, subtotal_price) VALUES
(1, 3, 1, 65000.00),
(1, 1, 1, 750.00),
(2, 2, 1, 18000.00),
(3, 2, 1, 18000.00),
(4, 4, 1, 5000.00);


INSERT INTO payments (order_id, payment_method, payment_status, payment_date) VALUES
(1, 'Credit Card', 'Paid', '2024-04-01'),
(2, 'UPI', 'Paid', '2024-04-03'),
(3, 'Net Banking', 'Paid', '2024-04-05'),
(4, 'COD', 'Pending', NULL),
(5, 'Credit Card', 'Paid', '2024-04-12');
INSERT INTO payments (order_id, payment_method, payment_status, payment_date) VALUES
(1, 'Credit Card', 'Paid', '2024-03-01'),
(2, 'UPI', 'Paid', '2024-03-05'),
(3, 'Cash on Delivery', 'Paid', '2024-03-11'),
(4, 'UPI', 'Pending', NULL),
(5, 'Net Banking', 'Paid', '2024-03-21');

INSERT INTO shipments (order_id, shipment_date, delivery_status) VALUES
(1, '2024-04-02', 'Processing'),
(2, '2024-04-04', 'In Transit'),
(3, '2024-04-06', 'Delivered'),
(4, NULL, 'Pending'),
(5, '2024-04-13', 'Delivered');
INSERT INTO shipments (order_id, shipment_date, delivery_status) VALUES
(1, '2024-03-02', 'Shipped'),
(2, '2024-03-06', 'In Transit'),
(3, '2024-03-12', 'Delivered'),
(4, NULL, 'Pending'),
(5, '2024-03-22', 'Delivered');


SELECT c.name, o.order_id, o.order_date, o.total_amount, o.order_status
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.order_date DESC;

SELECT p.name, SUM(od.quantity) AS total_sold
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC;

SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(total_amount) AS monthly_sales,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS sales_rank
FROM orders
GROUP BY year, month
ORDER BY year DESC, month DESC;

SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_orders DESC;

SELECT p.name, SUM(od.subtotal_price) AS total_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.name
ORDER BY total_revenue DESC;

SELECT o.order_id, c.name, s.delivery_status
FROM shipments s
JOIN orders o ON s.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE s.delivery_status = 'Pending';
