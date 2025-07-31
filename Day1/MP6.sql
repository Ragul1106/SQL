CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE brands (
    brand_id INT PRIMARY KEY AUTO_INCREMENT, -- Use SERIAL for PostgreSQL
    brand_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT, -- Use SERIAL for PostgreSQL
    category_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT, -- Use SERIAL for PostgreSQL
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    brand_id INT,
    category_id INT,
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT, -- Use SERIAL for PostgreSQL
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE user_favorites (
    user_id INT,
    product_id INT,
    PRIMARY KEY (user_id, product_id), -- Composite primary key
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

INSERT INTO brands (brand_name) VALUES
('Brand A'),
('Brand B'),
('Brand C'),
('Brand D');

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Apparel'),
('Home Goods'),
('Books');

INSERT INTO products (product_name, description, price, stock_quantity, brand_id, category_id) VALUES
('Laptop Pro', 'Powerful laptop for professionals', 1200.00, 50, 1, 1),
('Smartphone X', 'Latest smartphone with amazing camera', 800.00, 120, 1, 1),
('Wireless Headphones', 'Noise-cancelling headphones', 150.00, 200, 2, 1),
('T-Shirt Casual', 'Comfortable cotton t-shirt', 25.00, 500, 3, 2),
('Jeans Slim Fit', 'Stylish slim fit jeans', 60.00, 300, 3, 2),
('Coffee Maker Deluxe', 'Automated coffee maker', 90.00, 80, 4, 3),
('Cookbook: Italian Delights', 'Recipes from Italy', 30.00, 150, 4, 4),
('Smart Watch Z', 'Fitness tracker and smartwatch', 250.00, 90, 2, 1),
('Desk Lamp Modern', 'Sleek and adjustable desk lamp', 45.00, 180, 4, 3),
('Running Shoes Elite', 'High performance running shoes', 110.00, 220, 3, 2);

INSERT INTO users (username, email, password_hash) VALUES
('user1', 'user1@example.com', 'hash123'),
('user2', 'user2@example.com', 'hash456'),
('user3', 'user3@example.com', 'hash789'),
('user4', 'user4@example.com', 'hashabc');

INSERT INTO user_favorites (user_id, product_id) VALUES
(1, 1), 
(1, 3), 
(2, 1), 
(2, 4), 
(3, 1), 
(3, 2), 
(4, 7), 
(4, 5), 
(1, 2); 

SELECT
    p.product_name,
    p.description,
    p.price,
    p.stock_quantity,
    b.brand_name,
    c.category_name
FROM
    products p
JOIN
    brands b ON p.brand_id = b.brand_id
JOIN
    categories c ON p.category_id = c.category_id
WHERE
    c.category_name = 'Electronics';
    
SELECT
    p.product_name,
    p.description,
    p.price,
    p.stock_quantity,
    c.category_name,
    b.brand_name
FROM
    products p
JOIN
    brands b ON p.brand_id = b.brand_id
JOIN
    categories c ON p.category_id = c.category_id
WHERE
    b.brand_name = 'Brand A';

SELECT
    p.product_name,
    p.description,
    p.price,
    COUNT(uf.product_id) AS favorite_count
FROM
    products p
JOIN
    user_favorites uf ON p.product_id = uf.product_id
GROUP BY
    p.product_id, p.product_name, p.description, p.price
ORDER BY
    favorite_count DESC
LIMIT 5;