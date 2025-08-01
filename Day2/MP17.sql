-- Filter loans where amount is between 50,000 and 2,00,000
SELECT *
FROM loans
WHERE amount BETWEEN 50000 AND 200000;

-- Filter loans with type Home or Education
SELECT *
FROM loans
WHERE loan_type IN ('Home', 'Education');

-- Find loans with NULL approval_date
SELECT *
FROM loans
WHERE approval_date IS NULL;

-- Show only applicant_name, amount, and status
SELECT applicant_name, amount, status
FROM loans;

-- Sort loans by amount in descending order
SELECT *
FROM loans
ORDER BY amount DESC;
