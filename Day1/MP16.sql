CREATE DATABASE medical_store_db;
USE medical_store_db;

CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    contact_info VARCHAR(255)
);

CREATE TABLE medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    batch_no VARCHAR(50),
    expiry_date DATE,
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE stock (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT,
    quantity INT,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT,
    quantity_sold INT,
    sale_date DATE,
    price_per_unit DECIMAL(10,2),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

INSERT INTO suppliers (name, contact_info) VALUES
('HealthCorp', 'healthcorp@example.com'),
('MediLife', 'medilife@example.com'),
('PharmaPlus', 'pharmaplus@example.com');

INSERT INTO medicines (name, batch_no, expiry_date, supplier_id) VALUES
('Paracetamol', 'P001', '2026-05-10', 1),
('Amoxicillin', 'A001', '2025-12-01', 2),
('Ibuprofen', 'I001', '2026-01-20', 3),
('Cough Syrup', 'C001', '2025-11-15', 1);

INSERT INTO stock (medicine_id, quantity) VALUES
(1, 20),
(2, 5),
(3, 50),
(4, 3);

INSERT INTO sales (medicine_id, quantity_sold, sale_date, price_per_unit) VALUES
(1, 10, '2025-07-10', 5.00),
(2, 3, '2025-07-12', 8.00),
(1, 5, '2025-07-15', 5.00),
(4, 1, '2025-07-18', 6.50);

SELECT m.name AS medicine, s.quantity
FROM stock s
JOIN medicines m ON s.medicine_id = m.medicine_id
WHERE s.quantity < 10;

SELECT m.name AS medicine, sup.name AS supplier, SUM(s.quantity_sold * s.price_per_unit) AS total_sales
FROM sales s
JOIN medicines m ON s.medicine_id = m.medicine_id
JOIN suppliers sup ON m.supplier_id = sup.supplier_id
GROUP BY m.name, sup.name;









