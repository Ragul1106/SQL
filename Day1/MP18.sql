CREATE DATABASE bank_db;
USE bank_db;

CREATE TABLE branches (
  branch_id INT PRIMARY KEY AUTO_INCREMENT,
  branch_name VARCHAR(100) NOT NULL,
  location VARCHAR(100) NOT NULL
);

CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE accounts (
  account_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  branch_id INT,
  account_type VARCHAR(50) NOT NULL,
  balance DECIMAL(10, 2) DEFAULT 0.00,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE transactions (
  transaction_id INT PRIMARY KEY AUTO_INCREMENT,
  account_id INT,
  amount DECIMAL(10, 2) NOT NULL,
  type ENUM('credit', 'debit') NOT NULL,
  transaction_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

INSERT INTO branches (branch_name, location)
VALUES
  ('Main Branch', 'Chennai'),
  ('City Branch', 'Madurai'),
  ('West Branch', 'Coimbatore');
  
  INSERT INTO customers (name, email)
VALUES
  ('Arun Kumar', 'arun@example.com'),
  ('Divya S', 'divya@example.com'),
  ('Ravi Raj', 'ravi@example.com');
  
  INSERT INTO accounts (customer_id, branch_id, account_type, balance)
VALUES
  (1, 1, 'savings', 5000.00),
  (2, 2, 'current', 12000.00),
  (3, 3, 'savings', 3000.00);
  
  INSERT INTO transactions (account_id, amount, type)
VALUES
  (1, 2000.00, 'credit'),
  (1, 500.00, 'debit'),
  (2, 3000.00, 'credit'),
  (3, 1000.00, 'debit'),
  (2, 2000.00, 'debit'),
  (3, 2000.00, 'credit');
  
  SELECT 
  t.transaction_id,
  c.name AS customer_name,
  a.account_type,
  t.amount,
  t.type,
  t.transaction_time
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
ORDER BY t.transaction_time DESC;

SELECT 
  a.account_id,
  c.name AS customer_name,
  a.account_type,
  SUM(CASE WHEN t.type = 'credit' THEN t.amount ELSE 0 END) AS total_credits,
  SUM(CASE WHEN t.type = 'debit' THEN t.amount ELSE 0 END) AS total_debits,
  a.balance + 
    SUM(CASE WHEN t.type = 'credit' THEN t.amount ELSE 0 END) - 
    SUM(CASE WHEN t.type = 'debit' THEN t.amount ELSE 0 END) AS current_balance
FROM accounts a
JOIN customers c ON a.customer_id = c.customer_id
LEFT JOIN transactions t ON a.account_id = t.account_id
GROUP BY a.account_id;









