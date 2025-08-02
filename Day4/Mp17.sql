-- 1. Average Ride Duration per Driver (Subquery)
SELECT driver_id, AVG(duration_minutes) AS avg_ride_duration
FROM (
    SELECT driver_id, TIMESTAMPDIFF(MINUTE, start_time, end_time) AS duration_minutes
    FROM rides
    WHERE status = 'completed'
) AS ride_durations
GROUP BY driver_id;


-- 2. Rider with Most Rides per City (Correlated Subquery)
SELECT r.city, r.rider_id, r.total_rides
FROM (
    SELECT city, rider_id, COUNT(*) AS total_rides
    FROM rides
    GROUP BY city, rider_id
) AS r
WHERE r.total_rides = (
    SELECT MAX(r2.total_rides)
    FROM (
        SELECT city, rider_id, COUNT(*) AS total_rides
        FROM rides
        GROUP BY city, rider_id
    ) AS r2
    WHERE r2.city = r.city
);


-- 3. Classify Ride Types (CASE)
SELECT ride_id, rider_id, driver_id, 
       CASE
           WHEN ride_type = 'SH' THEN 'Shared'
           WHEN ride_type = 'PR' THEN 'Premium'
           WHEN ride_type = 'EC' THEN 'Economy'
           ELSE 'Other'
       END AS ride_category
FROM rides;


-- 4. Completed and Cancelled Rides (UNION)
SELECT ride_id, rider_id, driver_id, 'Completed' AS ride_status
FROM rides
WHERE status = 'completed'

UNION

SELECT ride_id, rider_id, driver_id, 'Cancelled' AS ride_status
FROM rides
WHERE status = 'cancelled';


-- 5. City-wise Earnings (JOIN + GROUP BY)
SELECT d.city, SUM(p.amount) AS total_earnings
FROM rides r
JOIN payments p ON r.ride_id = p.ride_id
JOIN drivers d ON r.driver_id = d.driver_id
WHERE r.status = 'completed'
GROUP BY d.city;


-- 6. Peak Hour Rides (Date Range Filter using TIME())
-- Assuming peak hours: 7AM–10AM and 5PM–8PM
SELECT ride_id, rider_id, driver_id, start_time
FROM rides
WHERE TIME(start_time) BETWEEN '07:00:00' AND '10:00:00'
   OR TIME(start_time) BETWEEN '17:00:00' AND '20:00:00';
