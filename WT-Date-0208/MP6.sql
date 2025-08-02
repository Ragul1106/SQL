CREATE DATABASE restaurant_order_management;
USE restaurant_order_management;

-- Create menu_items table
CREATE TABLE menu_items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    price DECIMAL(6,2)
);

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    signup_date DATE
);

-- Create staff table
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(100),
    role VARCHAR(50)
);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    staff_id INT,
    item_id INT,
    order_type VARCHAR(10),  -- 'Dine-in' or 'Delivery'
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

-- Insert sample menu items
INSERT INTO menu_items (item_id, item_name, price) VALUES
(1, 'Margherita Pizza', 250.00),
(2, 'Pepperoni Pizza', 300.00),
(3, 'Veg Burger', 150.00),
(4, 'Fries', 80.00),
(5, 'Coke', 50.00);

-- Insert sample customers
INSERT INTO customers (customer_id, customer_name, signup_date) VALUES
(1, 'Alice', '2025-07-01'),
(2, 'Bob', '2025-06-10'),
(3, 'Charlie', '2025-07-15'),
(4, 'Diana', '2025-07-30');

-- Insert sample staff
INSERT INTO staff (staff_id, staff_name, role) VALUES
(1, 'Waiter John', 'Waiter'),
(2, 'Waiter Mike', 'Waiter'),
(3, 'Delivery Sam', 'Delivery');

-- Insert sample orders
INSERT INTO orders (order_id, customer_id, staff_id, item_id, order_type, order_date, quantity) VALUES
(101, 1, 1, 1, 'Dine-in', '2025-07-15', 2),
(102, 2, 1, 2, 'Dine-in', '2025-07-15', 1),
(103, 1, 3, 3, 'Delivery', '2025-07-16', 1),
(104, 3, 2, 2, 'Dine-in', '2025-07-16', 1),
(105, 1, 3, 5, 'Delivery', '2025-07-18', 2),
(106, 2, 1, 4, 'Dine-in', '2025-07-18', 1),
(107, 1, 3, 1, 'Delivery', '2025-07-20', 1),
(108, 1, 1, 2, 'Dine-in', '2025-07-22', 1),
(109, 1, 1, 1, 'Dine-in', '2025-07-25', 1);

--  1. INNER JOIN to list full orders with customer and waiter info
SELECT 
    o.order_id,
    c.customer_name,
    s.staff_name AS served_by,
    s.role,
    m.item_name,
    o.order_type,
    o.order_date,
    o.quantity,
    (o.quantity * m.price) AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN staff s ON o.staff_id = s.staff_id
JOIN menu_items m ON o.item_id = m.item_id;

--  2. Use LIKE to find all items that are Pizza
SELECT * 
FROM menu_items
WHERE item_name LIKE '%Pizza%';

--  3. GROUP BY to get total orders handled by each staff
SELECT 
    s.staff_name,
    COUNT(o.order_id) AS total_orders
FROM staff s
JOIN orders o ON s.staff_id = o.staff_id
GROUP BY s.staff_name;

--  4. ORDER BY total amount and customer name
SELECT 
    c.customer_name,
    (o.quantity * m.price) AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN menu_items m ON o.item_id = m.item_id
ORDER BY total_amount DESC, c.customer_name ASC;

--  5. CASE WHEN for categorizing customers (New/Returning)
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    CASE 
        WHEN COUNT(o.order_id) > 1 THEN 'Returning'
        ELSE 'New'
    END AS customer_type
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

--  6. Subquery to find customers who ordered more than 5 times
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 5
);

--  7. Combine dine-in and delivery data using UNION
SELECT 
    o.order_id,
    c.customer_name,
    'Dine-in' AS order_type,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_type = 'Dine-in'

UNION

SELECT 
    o.order_id,
    c.customer_name,
    'Delivery' AS order_type,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_type = 'Delivery'
ORDER BY order_date;
