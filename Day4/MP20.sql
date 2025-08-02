-- 1. Bill Summary Per Guest (Subquery in SELECT)
SELECT 
    g.guest_id,
    g.name,
    (
        SELECT SUM(p.amount)
        FROM payments p
        WHERE p.guest_id = g.guest_id
    ) AS total_bill
FROM guests g;


-- 2. Label Room Types Using CASE
SELECT 
    room_id,
    room_number,
    CASE room_type
        WHEN 'E' THEN 'Economy'
        WHEN 'D' THEN 'Deluxe'
        WHEN 'S' THEN 'Suite'
        ELSE 'Other'
    END AS room_category
FROM rooms;


-- 3. Combine Completed and Upcoming Bookings (UNION)
SELECT booking_id, guest_id, room_id, check_in_date, check_out_date, 'Completed' AS status
FROM bookings
WHERE check_out_date < CURRENT_DATE

UNION

SELECT booking_id, guest_id, room_id, check_in_date, check_out_date, 'Upcoming' AS status
FROM bookings
WHERE check_in_date >= CURRENT_DATE;


-- 4. Most Frequent Guest Per Room Type (Correlated Subquery)
SELECT g.guest_id, g.name, r.room_type
FROM guests g
JOIN bookings b ON g.guest_id = b.guest_id
JOIN rooms r ON b.room_id = r.room_id
WHERE g.guest_id = (
    SELECT guest_id
    FROM bookings b2
    JOIN rooms r2 ON b2.room_id = r2.room_id
    WHERE r2.room_type = r.room_type
    GROUP BY guest_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


-- 5. Revenue Per Room Type (JOIN + GROUP BY)
SELECT 
    r.room_type,
    COUNT(p.payment_id) AS total_payments,
    SUM(p.amount) AS total_revenue
FROM payments p
JOIN bookings b ON p.booking_id = b.booking_id
JOIN rooms r ON b.room_id = r.room_id
GROUP BY r.room_type;


-- 6. Check-In / Check-Out Analytics (Date Filtering)
SELECT 
    booking_id,
    guest_id,
    room_id,
    check_in_date,
    check_out_date
FROM bookings
WHERE 
    (check_in_date BETWEEN CURDATE() - INTERVAL 7 DAY AND CURDATE())
    OR 
    (check_out_date BETWEEN CURDATE() AND CURDATE() + INTERVAL 7 DAY);

