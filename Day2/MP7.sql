-- Get feedback for "Smartphone" where rating is 4 or higher
SELECT customer_name, rating, comment
FROM feedback
WHERE rating >= 4 AND product = 'Smartphone';

-- Find feedback where the comment contains the word "slow"
SELECT *
FROM feedback
WHERE comment LIKE '%slow%';

-- Get feedback submitted in the last 30 days
SELECT *
FROM feedback
WHERE submitted_date BETWEEN CURRENT_DATE - INTERVAL 30 DAY AND CURRENT_DATE;

-- Show feedback with no comment provided
SELECT *
FROM feedback
WHERE comment IS NULL;

-- List all unique products that have received feedback
SELECT DISTINCT product
FROM feedback;

-- Order feedback by highest rating first, then most recent date
SELECT *
FROM feedback
ORDER BY rating DESC, submitted_date DESC;
