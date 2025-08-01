--  Task: Hotel Room Booking System

--  1. Total amount paid per guest
SELECT 
  g.guest_id,
  g.guest_name,
  SUM(p.amount) AS total_paid
FROM guests g
JOIN payments p ON g.guest_id = p.guest_id
GROUP BY g.guest_id, g.guest_name;

--  2. Rooms booked more than 5 times
SELECT 
  room_id,
  COUNT(*) AS booking_count
FROM bookings
GROUP BY room_id
HAVING COUNT(*) > 5;

--  3. Group bookings by room type and calculate average stay duration
SELECT 
  r.room_type,
  AVG(DATEDIFF(b.checkout_date, b.checkin_date)) AS avg_stay_duration
FROM bookings b
JOIN rooms r ON b.room_id = r.room_id
GROUP BY r.room_type;

--  4. INNER JOIN: guests ↔ bookings ↔ rooms
SELECT 
  g.guest_name,
  r.room_number,
  r.room_type,
  b.checkin_date,
  b.checkout_date
FROM guests g
INNER JOIN bookings b ON g.guest_id = b.guest_id
INNER JOIN rooms r ON b.room_id = r.room_id;

--  5. FULL OUTER JOIN: rooms and bookings
-- Rooms with or without bookings 
SELECT 
  r.room_id,
  b.booking_id,
  r.room_number
FROM rooms r
LEFT JOIN bookings b ON r.room_id = b.room_id

UNION

-- Bookings with or without matching room 
SELECT 
  r.room_id,
  b.booking_id,
  r.room_number
FROM rooms r
RIGHT JOIN bookings b ON r.room_id = b.room_id;

--  6. SELF JOIN: guests who booked the same room multiple times
SELECT 
  g1.guest_name AS guest,
  b1.room_id,
  COUNT(*) AS times_booked
FROM bookings b1
JOIN guests g1 ON b1.guest_id = g1.guest_id
GROUP BY g1.guest_id, b1.room_id
HAVING COUNT(*) > 1;
