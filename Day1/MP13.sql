CREATE DATABASE food_delivery;
USE food_delivery;

CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE menus (
    menu_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(100),
    price DECIMAL(10, 2),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(150)
);

CREATE TABLE delivery_agents (
    agent_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    menu_id INT,
    agent_id INT,
    order_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (menu_id) REFERENCES menus(menu_id),
    FOREIGN KEY (agent_id) REFERENCES delivery_agents(agent_id)
);

INSERT INTO restaurants (name, location) VALUES
('Spicy Bite', 'Chennai'),
('Pizza Planet', 'Mumbai'),
('Sushi House', 'Delhi'),
('Burger Hub', 'Bangalore'),
('Tandoori Treats', 'Hyderabad');

INSERT INTO menus (restaurant_id, item_name, price) VALUES
(1, 'Paneer Tikka', 180.00),
(1, 'Masala Dosa', 90.00),
(2, 'Veg Pizza', 200.00),
(2, 'Cheese Burst Pizza', 250.00),
(3, 'Salmon Sushi', 300.00),
(3, 'Veg Sushi', 220.00),
(4, 'Chicken Burger', 150.00),
(4, 'Veggie Burger', 120.00),
(5, 'Butter Chicken', 250.00),
(5, 'Naan Combo', 100.00);

INSERT INTO customers (name, address) VALUES
('Alice', 'Street 1, Chennai'),
('Bob', 'Road 2, Mumbai'),
('Charlie', 'Sector 3, Delhi'),
('David', 'Block 4, Bangalore'),
('Eva', 'Lane 5, Hyderabad');

INSERT INTO delivery_agents (name, phone) VALUES
('Agent Raj', '9876543210'),
('Agent Ravi', '9988776655'),
('Agent Priya', '9871234567');

INSERT INTO orders (customer_id, menu_id, agent_id, status) VALUES
(1, 1, 1, 'Delivered'),
(1, 2, 2, 'Pending'),
(2, 3, 1, 'Delivered'),
(2, 4, 3, 'Pending'),
(3, 5, 2, 'Delivered'),
(3, 6, 2, 'Pending'),
(4, 7, 3, 'Delivered'),
(4, 8, 1, 'Cancelled'),
(5, 9, 3, 'Delivered'),
(5, 10, 1, 'Pending'),
(1, 1, 1, 'Delivered'),
(2, 3, 2, 'Delivered'),
(3, 6, 2, 'Pending'),
(4, 7, 1, 'Delivered'),
(5, 9, 3, 'Pending');

SELECT 
    o.order_id,
    c.name AS customer_name,
    m.item_name,
    r.name AS restaurant_name,
    d.name AS agent_name,
    o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN menus m ON o.menu_id = m.menu_id
JOIN restaurants r ON m.restaurant_id = r.restaurant_id
JOIN delivery_agents d ON o.agent_id = d.agent_id
WHERE o.status = 'Pending';

SELECT 
    r.name AS restaurant_name,
    SUM(m.price) AS total_revenue
FROM orders o
JOIN menus m ON o.menu_id = m.menu_id
JOIN restaurants r ON m.restaurant_id = r.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.name;












