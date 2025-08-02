-- Outstanding Loan Balance (Subquery in SELECT)
SELECT l.loan_id, c.name AS customer_name, l.loan_amount,
       (l.loan_amount - (
           SELECT COALESCE(SUM(p.amount), 0)
           FROM payments p
           WHERE p.loan_id = l.loan_id
       )) AS outstanding_balance
FROM loans l
JOIN customers c ON l.customer_id = c.customer_id;

-- Total Repayments per Loan Type (JOIN + GROUP BY) 
SELECT lt.type_name, SUM(p.amount) AS total_repaid
FROM payments p
JOIN loans l ON p.loan_id = l.loan_id
JOIN loan_types lt ON l.loan_type_id = lt.loan_type_id
GROUP BY lt.type_name;

-- Categorize Loans (CASE: "Closed", "On Track", "Delayed")
SELECT l.loan_id, c.name, l.loan_amount, l.due_date,
       CASE
           WHEN l.status = 'closed' THEN 'Closed'
           WHEN CURDATE() <= l.due_date THEN 'On Track'
           ELSE 'Delayed'
       END AS loan_status
FROM loans l
JOIN customers c ON l.customer_id = c.customer_id;

-- Combine Active and Closed Loans (UNION ALL)
-- Active loans
SELECT loan_id, customer_id, loan_amount, 'active' AS loan_status
FROM loans
WHERE status = 'active'

UNION ALL

-- Closed loans
SELECT loan_id, customer_id, loan_amount, 'closed' AS loan_status
FROM loans
WHERE status = 'closed';

-- Customers Whose Payments Are Above Their Own Average (Correlated Subquery)
SELECT c.customer_id, c.name, p.loan_id, p.amount
FROM payments p
JOIN loans l ON p.loan_id = l.loan_id
JOIN customers c ON l.customer_id = c.customer_id
WHERE p.amount > (
    SELECT AVG(p2.amount)
    FROM payments p2
    JOIN loans l2 ON p2.loan_id = l2.loan_id
    WHERE l2.customer_id = c.customer_id
);

-- Calculate Payment Delay (DATEDIFF)
SELECT p.payment_id, l.loan_id, p.payment_date, l.due_date,
       DATEDIFF(p.payment_date, l.due_date) AS delay_days
FROM payments p
JOIN loans l ON p.loan_id = l.loan_id
WHERE p.payment_date > l.due_date;
    
 