--  1. Top-selling authors (GROUP BY, SUM of total sales)
SELECT 
  a.author_id,
  a.name AS author_name,
  SUM(s.quantity) AS total_books_sold
FROM authors a
JOIN books b ON a.author_id = b.author_id
JOIN sales s ON b.book_id = s.book_id
GROUP BY a.author_id, a.name
ORDER BY total_books_sold DESC;

--  2. Books with rating > 4.5 and sold more than 100 times
SELECT 
  b.book_id,
  b.title,
  b.rating,
  SUM(s.quantity) AS total_sold
FROM books b
JOIN sales s ON b.book_id = s.book_id
GROUP BY b.book_id, b.title, b.rating
HAVING b.rating > 4.5 AND SUM(s.quantity) > 100;

--  3. Customers with more than 5 purchases
SELECT 
  c.customer_id,
  c.name AS customer_name,
  COUNT(s.sale_id) AS total_purchases
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(s.sale_id) > 5;

--  4. INNER JOIN books ↔ sales ↔ customers
SELECT 
  b.title AS book_title,
  c.name AS customer_name,
  s.sale_date,
  s.quantity
FROM books b
INNER JOIN sales s ON b.book_id = s.book_id
INNER JOIN customers c ON s.customer_id = c.customer_id;

--  5. FULL OUTER JOIN authors and books (show all authors and all books even if not linked)
-- Simulated FULL OUTER JOIN: authors ↔ books
SELECT 
  a.author_id,
  a.name AS author_name,
  b.book_id,
  b.title AS book_title
FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id

UNION

SELECT 
  a.author_id,
  a.name AS author_name,
  b.book_id,
  b.title AS book_title
FROM authors a
RIGHT JOIN books b ON a.author_id = b.author_id;


--  6. SELF JOIN on books with the same genre
SELECT 
  b1.title AS book1,
  b2.title AS book2,
  b1.genre
FROM books b1
JOIN books b2 
  ON b1.genre = b2.genre 
  AND b1.book_id < b2.book_id;
