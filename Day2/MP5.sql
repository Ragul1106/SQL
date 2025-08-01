-- Get flights with destination Chennai or Mumbai
SELECT flight_number, origin, destination
FROM flights
WHERE destination IN ('Chennai', 'Mumbai');

-- Retrieve flights whose flight number ends with 'AI'
SELECT *
FROM flights
WHERE flight_number LIKE '%AI';

-- Get flights departing between 2025-07-30 00:00:00 and 2025-07-30 23:59:59
SELECT *
FROM flights
WHERE departure_time BETWEEN '2025-07-30 00:00:00' AND '2025-07-30 23:59:59';

-- Find flights with no status information (NULL)
SELECT *
FROM flights
WHERE status IS NULL;

-- Display distinct destinations from the flights table
SELECT DISTINCT destination
FROM flights;

-- Show all flights sorted by earliest departure first
SELECT *
FROM flights
ORDER BY departure_time ASC;
