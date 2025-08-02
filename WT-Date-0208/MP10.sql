CREATE DATABASE Bank_Transactions;
USE Bank_Transactions;

-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(100)
);

-- Accounts table
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20), 
    balance DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Transactions table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    amount DECIMAL(10, 2),
    transaction_type VARCHAR(10), 
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- Insert into customers
INSERT INTO customers VALUES
(1, 'Alice', 'alice@example.com', 'Chennai'),
(2, 'Bob', 'bob@example.com', 'Mumbai'),
(3, 'Charlie', 'charlie@example.com', 'Delhi'),
(4, 'Daisy', 'daisy@example.com', 'Bangalore');

-- Insert into accounts
INSERT INTO accounts VALUES
(101, 1, 'savings', 50000),
(102, 2, 'current', 20000),
(103, 3, 'savings', 0),
(104, 4, 'current', 100000);

-- Insert into transactions
INSERT INTO transactions VALUES
(1, 101, 10000, 'deposit', '2025-07-01'),
(2, 101, 5000, 'withdrawal', '2025-07-03'),
(3, 102, 2000, 'deposit', '2025-07-02'),
(4, 104, 25000, 'deposit', '2025-07-04'),
(5, 104, 5000, 'withdrawal', '2025-07-05');

-- Accounts with no transactions
SELECT a.account_id, a.customer_id
FROM accounts a
LEFT JOIN transactions t ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

-- Account and customer info
SELECT c.name, a.account_id, a.account_type, a.balance
FROM customers c
INNER JOIN accounts a ON c.customer_id = a.customer_id;

-- Total deposits per customer
SELECT c.name, SUM(t.amount) AS total_deposits
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
WHERE t.transaction_type = 'deposit'
GROUP BY c.name;

-- Risk-level classification
SELECT a.account_id, a.balance,
    CASE
        WHEN a.balance >= 50000 THEN 'Low Risk'
        WHEN a.balance BETWEEN 10000 AND 49999 THEN 'Medium Risk'
        ELSE 'High Risk'
    END AS risk_level
FROM accounts a;

-- Subquery in FROM – Daily balance change
SELECT customer_id, AVG(daily_change) AS avg_daily_change
FROM (
    SELECT a.customer_id, t.transaction_date,
           SUM(CASE WHEN t.transaction_type = 'deposit' THEN t.amount
                    WHEN t.transaction_type = 'withdrawal' THEN -t.amount
                    ELSE 0 END) AS daily_change
    FROM transactions t
    JOIN accounts a ON t.account_id = a.account_id
    GROUP BY a.customer_id, t.transaction_date
) AS daily_summary
GROUP BY customer_id;

-- UNION ALL – Savings and current account statements
SELECT a.account_id, t.transaction_id, t.amount, t.transaction_type, t.transaction_date
FROM accounts a
JOIN transactions t ON a.account_id = t.account_id
WHERE a.account_type = 'savings'

UNION ALL

SELECT a.account_id, t.transaction_id, t.amount, t.transaction_type, t.transaction_date
FROM accounts a
JOIN transactions t ON a.account_id = t.account_id
WHERE a.account_type = 'current'
ORDER BY transaction_date;
 
 
 
 
 