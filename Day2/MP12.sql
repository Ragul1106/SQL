-- Select buses that go from "Coimbatore" to "Madurai"
SELECT bus_no, departure, arrival
FROM routes
WHERE origin = 'Coimbatore' AND destination = 'Madurai';

-- Find routes with destinations ending in "pur"
SELECT *
FROM routes
WHERE destination LIKE '%pur';

-- Get routes that involve multiple cities (example: Coimbatore, Chennai, Madurai)
SELECT *
FROM routes
WHERE origin IN ('Coimbatore', 'Chennai', 'Madurai')
   OR destination IN ('Coimbatore', 'Chennai', 'Madurai');

-- Find routes with unknown (NULL) status
SELECT *
FROM routes
WHERE status IS NULL;

-- Sort all routes by earliest departure time
SELECT *
FROM routes
ORDER BY departure ASC;
