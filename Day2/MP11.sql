-- Show albums in the genre 'Jazz' or 'Classical' released after 2015
SELECT title, artist, price
FROM albums
WHERE genre IN ('Jazz', 'Classical') AND release_year > 2015;

-- List all unique artists
SELECT DISTINCT artist
FROM albums;

-- Find albums with titles containing the word "Love"
SELECT *
FROM albums
WHERE title LIKE '%Love%';

-- Identify albums with no price specified
SELECT *
FROM albums
WHERE price IS NULL;

-- Sort albums by newest release year first, then by title alphabetically
SELECT *
FROM albums
ORDER BY release_year DESC, title ASC;
