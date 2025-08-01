--  Total Bookings Per Airline
SELECT 
  a.airline_id,
  a.name AS airline_name,
  COUNT(b.booking_id) AS total_bookings
FROM airlines a
JOIN flights f ON a.airline_id = f.airline_id
JOIN bookings b ON f.flight_id = b.flight_id
GROUP BY a.airline_id, a.name;

--  Most Frequent Flyers (COUNT)
SELECT 
  p.passenger_id,
  p.name AS passenger_name,
  COUNT(b.booking_id) AS flights_taken
FROM passengers p
JOIN bookings b ON p.passenger_id = b.passenger_id
GROUP BY p.passenger_id, p.name
ORDER BY flights_taken DESC;

--  Flights with Average Occupancy > 80% (HAVING)
SELECT 
  f.flight_id,
  f.route,
  COUNT(b.booking_id) * 100.0 / f.capacity AS occupancy_percentage
FROM flights f
JOIN bookings b ON f.flight_id = b.flight_id
GROUP BY f.flight_id, f.route, f.capacity
HAVING COUNT(b.booking_id) * 100.0 / f.capacity > 80;


--  INNER JOIN - Bookings ↔ Flights ↔ Passengers
SELECT 
  b.booking_id,
  f.flight_id,
  f.route,
  p.passenger_id,
  p.name AS passenger_name
FROM bookings b
INNER JOIN flights f ON b.flight_id = f.flight_id
INNER JOIN passengers p ON b.passenger_id = p.passenger_id;

--  RIGHT JOIN - Airlines ↔ Flights
SELECT 
  a.airline_id,
  a.name AS airline_name,
  f.flight_id,
  f.route
FROM flights f
RIGHT JOIN airlines a ON a.airline_id = f.airline_id;

--  SELF JOIN - Passengers Who Flew Same Routes
SELECT 
  p1.passenger_id AS passenger1_id,
  p1.name AS passenger1_name,
  p2.passenger_id AS passenger2_id,
  p2.name AS passenger2_name,
  f1.route
FROM bookings b1
JOIN passengers p1 ON b1.passenger_id = p1.passenger_id
JOIN flights f1 ON b1.flight_id = f1.flight_id

JOIN bookings b2 ON f1.route = (SELECT f2.route FROM flights f2 WHERE f2.flight_id = b2.flight_id)
JOIN passengers p2 ON b2.passenger_id = p2.passenger_id

WHERE p1.passenger_id <> p2.passenger_id;
