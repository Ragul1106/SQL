CREATE DATABASE grocery_store_db;
USE grocery_store_db;
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL UNIQUE,
    contact_email VARCHAR(100)
);
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
    stock INT NOT NULL DEFAULT 0,
    discontinued BOOLEAN DEFAULT FALSE,
    category_id INT NOT NULL,
    supplier_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    UNIQUE (product_name)
);

INSERT INTO categories (category_name) VALUES
('Fruits'), ('Vegetables'), ('Dairy'), ('Bakery'), ('Beverages');

INSERT INTO suppliers (supplier_name, contact_email) VALUES
('FreshFarms', 'fresh@farm.com'),
('GreenGrowers', 'green@grow.com'),
('MilkyWay', 'milk@dairy.com'),
('BakeHouse', 'bake@bread.com'),
('CoolDrinks Inc', 'info@cooldrinks.com');

INSERT INTO products (product_name, price, stock, category_id, supplier_id) VALUES
-- Fruits
('Apple', 60.00, 100, 1, 1),
('Banana', 40.00, 150, 1, 1),
('Orange', 50.00, 120, 1, 1),
('Grapes', 90.00, 80, 1, 1),

-- Vegetables
('Carrot', 30.00, 200, 2, 2),
('Broccoli', 45.00, 90, 2, 2),
('Potato', 25.00, 300, 2, 2),
('Onion', 35.00, 250, 2, 2),

-- Dairy
('Milk', 50.00, 180, 3, 3),
('Cheese', 150.00, 50, 3, 3),
('Yogurt', 60.00, 70, 3, 3),
('Butter', 200.00, 30, 3, 3),

-- Bakery
('Bread', 40.00, 100, 4, 4),
('Bun', 15.00, 200, 4, 4),
('Croissant', 60.00, 60, 4, 4),
('Donut', 30.00, 120, 4, 4),

-- Beverages
('Orange Juice', 80.00, 90, 5, 5),
('Lemon Soda', 35.00, 110, 5, 5),
('Iced Tea', 45.00, 70, 5, 5),
('Cola', 40.00, 150, 5, 5);

UPDATE products
SET stock = stock + 50
WHERE product_name = 'Milk';

DELETE FROM products
WHERE discontinued = TRUE;

SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM products p
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name;



