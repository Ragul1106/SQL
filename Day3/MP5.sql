--  Task: Bank Transaction Tracker

--  1. Total deposits and withdrawals per account (SUM)
SELECT 
  account_id,
  SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE 0 END) AS total_deposits,
  SUM(CASE WHEN transaction_type = 'withdrawal' THEN amount ELSE 0 END) AS total_withdrawals
FROM transactions
GROUP BY account_id;

--  2. Highest and lowest transaction amounts (MAX, MIN)
SELECT 
  account_id,
  MAX(amount) AS highest_transaction,
  MIN(amount) AS lowest_transaction
FROM transactions
GROUP BY account_id;

--  3. Filter accounts with total withdrawals > ₹10,000 (HAVING)
SELECT 
  account_id,
  SUM(CASE WHEN transaction_type = 'withdrawal' THEN amount ELSE 0 END) AS total_withdrawals
FROM transactions
GROUP BY account_id
HAVING total_withdrawals > 10000;

--  4. INNER JOIN customers and accounts
SELECT 
  c.customer_id,
  c.customer_name,
  a.account_id,
  a.account_type
FROM customers c
INNER JOIN accounts a ON c.customer_id = a.customer_id;

--  5. LEFT JOIN to show accounts with no transactions
SELECT 
  a.account_id,
  a.account_type,
  t.transaction_id
FROM accounts a
LEFT JOIN transactions t ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

--  6. SELF JOIN to find customers from same city
SELECT 
  c1.customer_name AS customer_1,
  c2.customer_name AS customer_2,
  c1.city
FROM customers c1
JOIN customers c2 ON c1.city = c2.city AND c1.customer_id < c2.customer_id;
