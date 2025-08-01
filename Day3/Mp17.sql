--  Count of Tickets Per Technician
SELECT 
  t.technician_id,
  t.name AS technician_name,
  COUNT(k.ticket_id) AS total_tickets
FROM technicians t
JOIN tickets k ON t.technician_id = k.technician_id
GROUP BY t.technician_id, t.name;

--  Average Resolution Time (in hours)
SELECT 
  AVG(TIMESTAMPDIFF(HOUR, k.created_at, k.resolved_at)) AS avg_resolution_hours
FROM tickets k
WHERE k.resolved_at IS NOT NULL;

--  Technicians Handling More Than 10 Tickets
SELECT 
  t.technician_id,
  t.name AS technician_name,
  COUNT(k.ticket_id) AS total_tickets
FROM technicians t
JOIN tickets k ON t.technician_id = k.technician_id
GROUP BY t.technician_id, t.name
HAVING COUNT(k.ticket_id) > 10;

-- INNER JOIN - Tickets ↔ Technicians
SELECT 
  k.ticket_id,
  k.issue_type,
  k.created_at,
  t.name AS technician_name
FROM tickets k
INNER JOIN technicians t ON k.technician_id = t.technician_id;

--  LEFT JOIN - Clients ↔ Tickets
SELECT 
  c.client_id,
  c.name AS client_name,
  k.ticket_id,
  k.issue_type
FROM clients c
LEFT JOIN tickets k ON c.client_id = k.client_id;

--  SELF JOIN - Tickets With Same Issue Types
SELECT 
  k1.ticket_id AS ticket1_id,
  k2.ticket_id AS ticket2_id,
  k1.issue_type
FROM tickets k1
JOIN tickets k2 
  ON k1.issue_type = k2.issue_type 
  AND k1.ticket_id < k2.ticket_id;
