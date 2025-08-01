--  Count of Properties Listed Per Agent
SELECT 
  a.agent_id,
  a.name AS agent_name,
  COUNT(p.property_id) AS total_properties
FROM agents a
JOIN properties p ON a.agent_id = p.agent_id
GROUP BY a.agent_id, a.name;

--  Average Property Price Per Location
SELECT 
  p.location,
  AVG(p.price) AS avg_price
FROM properties p
GROUP BY p.location;

--  Agents with More Than 20 Inquiries
SELECT 
  a.agent_id,
  a.name AS agent_name,
  COUNT(i.inquiry_id) AS total_inquiries
FROM agents a
JOIN properties p ON a.agent_id = p.agent_id
JOIN inquiries i ON p.property_id = i.property_id
GROUP BY a.agent_id, a.name
HAVING COUNT(i.inquiry_id) > 20;

--  INNER JOIN - Properties ↔ Agents ↔ Inquiries
SELECT 
  p.property_id,
  p.title AS property_title,
  a.name AS agent_name,
  i.inquiry_id,
  i.client_id
FROM properties p
INNER JOIN agents a ON p.agent_id = a.agent_id
INNER JOIN inquiries i ON p.property_id = i.property_id;

--  LEFT JOIN - Properties ↔ Inquiries
SELECT 
  p.property_id,
  p.title AS property_title,
  i.inquiry_id,
  i.client_id
FROM properties p
LEFT JOIN inquiries i ON p.property_id = i.property_id;

--  SELF JOIN - Agents Working in the Same Area
SELECT 
  a1.agent_id AS agent1_id,
  a1.name AS agent1_name,
  a2.agent_id AS agent2_id,
  a2.name AS agent2_name,
  a1.area
FROM agents a1
JOIN agents a2 
  ON a1.area = a2.area 
  AND a1.agent_id < a2.agent_id;
