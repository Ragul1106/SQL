-- Count books issued per member
SELECT 
  m.member_id,
  m.name AS member_name,
  COUNT(c.checkout_id) AS total_books_issued
FROM members m
JOIN checkouts c ON m.member_id = c.member_id
GROUP BY m.member_id, m.name;

--  Members with fines over ₹500
SELECT 
  m.member_id,
  m.name AS member_name,
  SUM(f.amount) AS total_fine
FROM members m
JOIN fines f ON m.member_id = f.member_id
GROUP BY m.member_id, m.name
HAVING SUM(f.amount) > 500;

--  Books with > 5 checkouts
SELECT 
  b.book_id,
  b.title,
  COUNT(c.checkout_id) AS checkout_count
FROM books b
JOIN checkouts c ON b.book_id = c.book_id
GROUP BY b.book_id, b.title
HAVING COUNT(c.checkout_id) > 5;

--  INNER JOIN: checkouts ↔ members ↔ books
SELECT 
  c.checkout_id,
  m.name AS member_name,
  b.title AS book_title,
  c.checkout_date,
  c.return_date
FROM checkouts c
INNER JOIN members m ON c.member_id = m.member_id
INNER JOIN books b ON c.book_id = b.book_id;

--  LEFT JOIN: books ↔ checkouts (to show books never issued too)
SELECT 
  b.book_id,
  b.title,
  c.checkout_id,
  c.checkout_date
FROM books b
LEFT JOIN checkouts c ON b.book_id = c.book_id;

-- SELF JOIN: members who borrowed the same books
SELECT 
  m1.member_id AS member1_id,
  m1.name AS member1_name,
  m2.member_id AS member2_id,
  m2.name AS member2_name,
  c1.book_id
FROM checkouts c1
JOIN checkouts c2 ON c1.book_id = c2.book_id AND c1.member_id < c2.member_id
JOIN members m1 ON c1.member_id = m1.member_id
JOIN members m2 ON c2.member_id = m2.member_id;
