-- Filter transactions with amount between ₹100 and ₹1000
SELECT user_id, amount, txn_type
FROM transactions
WHERE amount BETWEEN 100 AND 1000;

-- Find transactions where txn_type contains the word "recharge"
SELECT *
FROM transactions
WHERE txn_type LIKE '%recharge%';

-- Identify transactions with NULL status
SELECT *
FROM transactions
WHERE status IS NULL;

-- Sort transactions by latest date first
SELECT *
FROM transactions
ORDER BY txn_date DESC;
