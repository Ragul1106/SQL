--  1. Count leads per sales rep
SELECT 
  sr.rep_id,
  sr.name AS rep_name,
  COUNT(l.lead_id) AS total_leads
FROM sales_reps sr
JOIN leads l ON sr.rep_id = l.rep_id
GROUP BY sr.rep_id, sr.name;

--  2. Average conversion time (days between lead_created and converted_date)
SELECT 
  AVG(DATEDIFF(l.converted_date, l.lead_created)) AS avg_conversion_time_days
FROM leads l
WHERE l.converted_date IS NOT NULL;

--  3. Reps who closed more than 5 deals
SELECT 
  sr.rep_id,
  sr.name AS rep_name,
  COUNT(l.lead_id) AS deals_closed
FROM sales_reps sr
JOIN leads l ON sr.rep_id = l.rep_id
WHERE l.status = 'Closed'
GROUP BY sr.rep_id, sr.name
HAVING COUNT(l.lead_id) > 5;

--  4. INNER JOIN reps and leads
SELECT 
  sr.rep_id,
  sr.name AS rep_name,
  l.lead_id,
  l.client_name,
  l.status
FROM sales_reps sr
INNER JOIN leads l ON sr.rep_id = l.rep_id;

--  5. RIGHT JOIN: reps and clients 
SELECT 
  sr.rep_id,
  sr.name AS rep_name,
  c.client_id,
  c.name AS client_name
FROM sales_reps sr
RIGHT JOIN clients c ON sr.rep_id = c.rep_id;

--  6. SELF JOIN to compare reps from the same region
SELECT 
  sr1.name AS rep_1,
  sr2.name AS rep_2,
  sr1.region
FROM sales_reps sr1
JOIN sales_reps sr2 
  ON sr1.region = sr2.region 
  AND sr1.rep_id < sr2.rep_id;
