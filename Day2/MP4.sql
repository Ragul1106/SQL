-- Select all fiction books that cost less than 500
SELECT title, author, price
FROM books
WHERE genre = 'Fiction' AND price < 500;

-- List all unique genres available in the bookstore
SELECT DISTINCT genre
FROM books;

-- Retrieve books with titles starting with 'The'
SELECT *
FROM books
WHERE title LIKE 'The%';

-- Get books published from 2010 to 2023
SELECT *
FROM books
WHERE published_year BETWEEN 2010 AND 2023;

-- Find books where stock information is missing (NULL)
SELECT *
FROM books
WHERE stock IS NULL;

-- Display books ordered by newest first and then title alphabetically
SELECT *
FROM books
ORDER BY published_year DESC, title ASC;
