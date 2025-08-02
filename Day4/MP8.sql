-- Average Transaction Value per User (Subquery in SELECT)
SELECT u.user_id, u.name,
       (SELECT AVG(t.amount)
        FROM accounts a
        JOIN transactions t ON a.account_id = t.account_id
        WHERE a.user_id = u.user_id) AS avg_transaction_value
FROM users u;

-- Transaction Totals by City (JOIN + GROUP BY) 
SELECT u.city, SUM(t.amount) AS total_transaction_amount
FROM users u
JOIN accounts a ON u.user_id = a.user_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY u.city;

-- Transaction Type Categories (CASE)
SELECT transaction_id, account_id, amount, transaction_type,
    CASE
        WHEN transaction_type = 'credit' THEN 'Credit'
        WHEN transaction_type = 'debit' THEN 'Debit'
        WHEN transaction_type = 'refund' THEN 'Refund'
        ELSE 'Unknown'
    END AS type_category
FROM transactions;

-- Merge Two Wallet Systems (UNION)
-- Transactions from WalletX
SELECT a.user_id, t.amount, t.transaction_type, 'WalletX' AS source
FROM accounts a
JOIN transactions t ON a.account_id = t.account_id
WHERE a.wallet_system = 'WalletX'

UNION

-- Transactions from WalletY
SELECT a.user_id, t.amount, t.transaction_type, 'WalletY' AS source
FROM accounts a
JOIN transactions t ON a.account_id = t.account_id
WHERE a.wallet_system = 'WalletY';

-- Users Active on Both Wallet Systems (INTERSECT)
-- Users in WalletX
SELECT DISTINCT user_id
FROM accounts
WHERE wallet_system = 'WalletX'
INTERSECT
-- Users in WalletY
SELECT DISTINCT user_id
FROM accounts
WHERE wallet_system = 'WalletY';

-- Transactions Made This Week or Month (Date Filtering)
-- This week (from Monday)
SELECT * FROM transactions
WHERE YEARWEEK(transaction_date, 1) = YEARWEEK(CURDATE(), 1);

-- This month
SELECT * FROM transactions
WHERE MONTH(transaction_date) = MONTH(CURDATE())
  AND YEAR(transaction_date) = YEAR(CURDATE());
   