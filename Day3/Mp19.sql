--  Total Loans Issued Per Officer
SELECT 
  o.officer_id,
  o.name AS officer_name,
  COUNT(l.loan_id) AS total_loans_issued
FROM officers o
JOIN loans l ON o.officer_id = l.officer_id
GROUP BY o.officer_id, o.name;

--  Clients with Repayment > ₹1,00,000
SELECT 
  c.client_id,
  c.name AS client_name,
  SUM(r.amount_paid) AS total_repaid
FROM clients c
JOIN repayments r ON c.client_id = r.client_id
GROUP BY c.client_id, c.name
HAVING SUM(r.amount_paid) > 100000;

-- 💰 Loan Approval Analysis: Officers Approving More Than 10 Loans
SELECT 
  o.officer_id,
  o.name AS officer_name,
  COUNT(l.loan_id) AS total_loans
FROM officers o
JOIN loans l ON o.officer_id = l.officer_id
GROUP BY o.officer_id, o.name
HAVING COUNT(l.loan_id) > 10;

--  INNER JOIN - Clients ↔ Loans ↔ Officers
SELECT 
  c.client_id,
  c.name AS client_name,
  l.loan_id,
  l.amount AS loan_amount,
  o.name AS officer_name
FROM clients c
INNER JOIN loans l ON c.client_id = l.client_id
INNER JOIN officers o ON l.officer_id = o.officer_id;

--  FULL OUTER JOIN - Loans ↔ Repayments
-- ✅ FULL OUTER JOIN simulation using LEFT + RIGHT JOIN + UNION

SELECT 
  l.loan_id,
  l.amount AS loan_amount,
  r.repayment_id,
  r.amount_paid
FROM loans l
LEFT JOIN repayments r ON l.loan_id = r.loan_id

UNION

SELECT 
  l.loan_id,
  l.amount AS loan_amount,
  r.repayment_id,
  r.amount_paid
FROM loans l
RIGHT JOIN repayments r ON l.loan_id = r.loan_id;


--  SELF JOIN - Clients from Same City
SELECT 
  c1.client_id AS client1_id,
  c1.name AS client1_name,
  c2.client_id AS client2_id,
  c2.name AS client2_name,
  c1.city
FROM clients c1
JOIN clients c2 
  ON c1.city = c2.city 
  AND c1.client_id < c2.client_id;
