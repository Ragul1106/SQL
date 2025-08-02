-- Average Claim per Insurance Type (Subquery)
SELECT insurance_type,
       AVG(total_claim) AS avg_claim
FROM (
    SELECT insurance_type, SUM(amount) AS total_claim
    FROM claims
    GROUP BY insurance_type, client_id
) AS claim_totals
GROUP BY insurance_type;

-- Show Claim Status (CASE)
SELECT claim_id, client_id, amount,
       CASE
           WHEN status = 'A' THEN 'Approved'
           WHEN status = 'P' THEN 'Pending'
           WHEN status = 'R' THEN 'Rejected'
           ELSE 'Unknown'
       END AS claim_status
FROM claims;

-- Old vs New Policy Claims (UNION ALL)
-- Old policies (issued before 2024)
SELECT claim_id, client_id, 'Old' AS policy_type
FROM claims
WHERE policy_issue_date < '2024-01-01'

UNION ALL

-- New policies (2024 or later)
SELECT claim_id, client_id, 'New' AS policy_type
FROM claims
WHERE policy_issue_date >= '2024-01-01';

-- Highest Claim per Client (Correlated Subquery)
SELECT c.client_id, c.claim_id, c.amount
FROM claims c
WHERE c.amount = (
    SELECT MAX(c2.amount)
    FROM claims c2
    WHERE c2.client_id = c.client_id
);

-- Average Claims per Agent (JOIN + GROUP BY)
SELECT a.agent_id, a.name,
       COUNT(c.claim_id) AS total_claims,
       AVG(c.amount) AS avg_claim_amount
FROM agents a
JOIN claims c ON a.agent_id = c.agent_id
GROUP BY a.agent_id, a.name;

-- Claims Filed This Quarter (Date Filtering)
SELECT claim_id, client_id, filed_date
FROM claims
WHERE QUARTER(filed_date) = QUARTER(CURDATE())
  AND YEAR(filed_date) = YEAR(CURDATE());
     