-- Books Borrowed More Than Average (Subquery)
SELECT b.book_id, b.title, COUNT(l.loan_id) AS borrow_count
FROM books b
JOIN loans l ON b.book_id = l.book_id
GROUP BY b.book_id, b.title
HAVING COUNT(l.loan_id) > (
    SELECT AVG(borrowed)
    FROM (
        SELECT COUNT(*) AS borrowed
        FROM loans
        GROUP BY book_id
    ) AS avg_loans
);

-- Classify Members Based on Total Borrowings (CASE)
SELECT m.member_id, m.name,
       COUNT(l.loan_id) AS total_loans,
       CASE
           WHEN COUNT(l.loan_id) >= 20 THEN 'Platinum'
           WHEN COUNT(l.loan_id) >= 10 THEN 'Gold'
           WHEN COUNT(l.loan_id) >= 5 THEN 'Silver'
           ELSE 'Bronze'
       END AS member_tier
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
GROUP BY m.member_id, m.name;

-- Most Borrowed Genres (JOIN + GROUP BY)
SELECT b.genre, COUNT(l.loan_id) AS total_borrowed
FROM books b
JOIN loans l ON b.book_id = l.book_id
GROUP BY b.genre
ORDER BY total_borrowed DESC;

-- Active and Inactive Borrowers (UNION)
-- Active (borrowed books)
SELECT DISTINCT m.member_id, m.name, 'Active' AS status
FROM members m
JOIN loans l ON m.member_id = l.member_id

UNION

-- Inactive (never borrowed)
SELECT m.member_id, m.name, 'Inactive' AS status
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
WHERE l.loan_id IS NULL;

-- Members Who Borrowed Both Fiction and Non-Fiction (INTERSECT)
-- Fiction borrowers
SELECT DISTINCT l.member_id
FROM loans l
JOIN books b ON l.book_id = b.book_id
WHERE b.genre = 'Fiction'

INTERSECT

-- Non-Fiction borrowers
SELECT DISTINCT l.member_id
FROM loans l
JOIN books b ON l.book_id = b.book_id
WHERE b.genre = 'Non-Fiction';

-- Loans in the Past 90 Days (Date Filter)
SELECT l.loan_id, m.name AS member_name, b.title, l.loan_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id
WHERE l.loan_date >= CURRENT_DATE - INTERVAL 90 DAY;
    
   