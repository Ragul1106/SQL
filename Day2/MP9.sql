-- Example: Guests who checked in between 2024-01-01 and 2024-12-31
SELECT name, room_type, check_in
FROM guests
WHERE check_in BETWEEN '2024-01-01' AND '2024-12-31';

-- Guests who haven't completed payment
SELECT *
FROM guests
WHERE payment_status IS NULL;

-- Guests whose names start with "K"
SELECT *
FROM guests
WHERE name LIKE 'K%';

-- List of unique room types
SELECT DISTINCT room_type
FROM guests;

-- Guests sorted by latest check-out, then alphabetically by name
SELECT *
FROM guests
ORDER BY check_out DESC, name ASC;

