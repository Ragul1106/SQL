-- Movies With Bookings Above Average (Subquery in WHERE)
SELECT m.movie_id, m.title, COUNT(b.booking_id) AS total_bookings
FROM movies m
JOIN bookings b ON m.movie_id = b.movie_id
GROUP BY m.movie_id, m.title
HAVING COUNT(b.booking_id) > (
    SELECT AVG(movie_booking_count)
    FROM (
        SELECT COUNT(*) AS movie_booking_count
        FROM bookings
        GROUP BY movie_id
    ) AS avg_bookings
);

-- JOIN Bookings ↔ Movies ↔ Customers
SELECT b.booking_id, c.name AS customer_name, m.title AS movie_title, b.booking_time, b.tickets
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN movies m ON b.movie_id = m.movie_id;

-- CASE: Classify Booking Times
SELECT booking_id, booking_time,
    CASE
        WHEN HOUR(booking_time) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN HOUR(booking_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_slot
FROM bookings;

-- INTERSECT: Customers Who Watched Both "Avengers" and "Batman"
-- Customers who watched Avengers
SELECT customer_id FROM bookings
WHERE movie_id = (SELECT movie_id FROM movies WHERE title = 'Avengers')
INTERSECT
-- Customers who watched Batman
SELECT customer_id FROM bookings
WHERE movie_id = (SELECT movie_id FROM movies WHERE title = 'Batman');

-- UNION ALL: Combine Weekend and Weekday Sales
-- Weekday sales (Mon–Fri)
SELECT booking_id, tickets, 'Weekday' AS type
FROM bookings
WHERE DAYOFWEEK(booking_time) BETWEEN 2 AND 6

UNION ALL

-- Weekend sales (Sat–Sun)
SELECT booking_id, tickets, 'Weekend' AS type
FROM bookings
WHERE DAYOFWEEK(booking_time) IN (1, 7);

-- Correlated Subquery: Top Customer in Each Theatre
SELECT c.customer_id, c.name, t.theatre_id, t.name AS theatre_name, COUNT(b.booking_id) AS total_bookings
FROM customers c
JOIN bookings b ON c.customer_id = b.customer_id
JOIN theatres t ON b.theatre_id = t.theatre_id
GROUP BY c.customer_id, c.name, t.theatre_id, t.name
HAVING COUNT(b.booking_id) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM bookings b2
        WHERE b2.theatre_id = t.theatre_id
        GROUP BY b2.customer_id
    ) AS sub
);
      