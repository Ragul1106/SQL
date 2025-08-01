-- Get available movies in Action or Thriller genre
SELECT title, genre, rating
FROM movies
WHERE available = TRUE AND genre IN ('Action', 'Thriller');

-- Find movies with "Star" in their title
SELECT *
FROM movies
WHERE title LIKE '%Star%';

-- Find movies that don't have a rating
SELECT *
FROM movies
WHERE rating IS NULL;

-- List all unique genres from the movies table
SELECT DISTINCT genre
FROM movies;

-- Order movies from highest to lowest rating, then by lowest price
SELECT *
FROM movies
ORDER BY rating DESC, price ASC;
