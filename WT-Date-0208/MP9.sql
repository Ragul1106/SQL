CREATE DATABASE music_streaming_service;
USE music_streaming_service;

-- 1. Create artists table
CREATE TABLE artists (
    artist_id INT PRIMARY KEY,
    artist_name VARCHAR(100)
);

-- 2. Create songs table
CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    song_name VARCHAR(100),
    artist_id INT,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

-- 3. Create users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    signup_date DATE
);

-- 4. Create play_history table
CREATE TABLE play_history (
    play_id INT PRIMARY KEY,
    user_id INT,
    song_id INT,
    play_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

-- Insert sample artists
INSERT INTO artists (artist_id, artist_name) VALUES
(1, 'Taylor Swift'),
(2, 'Ed Sheeran'),
(3, 'Adele'),
(4, 'Imagine Dragons');

-- Insert sample songs
INSERT INTO songs (song_id, song_name, artist_id) VALUES
(1, 'Love Story', 1),
(2, 'Shape of You', 2),
(3, 'Rolling in the Deep', 3),
(4, 'Believer', 4),
(5, 'Perfect', 2),
(6, 'Someone Like You', 3),
(7, 'Blank Space', 1),
(8, 'Love Me Like You Do', 3);

-- Insert sample users
INSERT INTO users (user_id, user_name, signup_date) VALUES
(1, 'Alice', '2025-01-10'),
(2, 'Bob', '2025-02-15'),
(3, 'Charlie', '2025-03-20'),
(4, 'Diana', '2025-04-01');

-- Insert sample play history
INSERT INTO play_history (play_id, user_id, song_id, play_date) VALUES
(1, 1, 1, '2025-05-01'),
(2, 1, 2, '2025-05-01'),
(3, 1, 2, '2025-05-02'),
(4, 1, 5, '2025-05-03'),
(5, 2, 2, '2025-05-01'),
(6, 2, 5, '2025-05-01'),
(7, 2, 5, '2025-05-02'),
(8, 2, 5, '2025-05-03'),
(9, 2, 5, '2025-05-04'),
(10, 2, 5, '2025-05-05'),
(11, 2, 5, '2025-05-06'),
(12, 2, 5, '2025-05-07'),
(13, 2, 5, '2025-05-08'),
(14, 2, 5, '2025-05-09'),
(15, 2, 5, '2025-05-10'),
(16, 3, 3, '2025-05-01'),
(17, 3, 6, '2025-05-02'),
(18, 3, 6, '2025-05-03'),
(19, 4, 4, '2025-05-01'),
(20, 4, 4, '2025-05-02');

--  1. JOIN to show who listened to which song
SELECT 
    u.user_name,
    s.song_name,
    a.artist_name,
    p.play_date
FROM play_history p
JOIN users u ON p.user_id = u.user_id
JOIN songs s ON p.song_id = s.song_id
JOIN artists a ON s.artist_id = a.artist_id;

--  2. GROUP BY + COUNT() to get top songs
SELECT 
    s.song_name,
    COUNT(*) AS play_count
FROM play_history p
JOIN songs s ON p.song_id = s.song_id
GROUP BY s.song_name
ORDER BY play_count DESC;

--  3. ORDER BY for most played artists
SELECT 
    a.artist_name,
    COUNT(*) AS total_plays
FROM play_history p
JOIN songs s ON p.song_id = s.song_id
JOIN artists a ON s.artist_id = a.artist_id
GROUP BY a.artist_name
ORDER BY total_plays DESC;

--  4. Subquery to get users who listened to the same artist more than 10 times
SELECT user_name
FROM users
WHERE user_id IN (
    SELECT user_id
    FROM play_history p
    JOIN songs s ON p.song_id = s.song_id
    GROUP BY user_id, s.artist_id
    HAVING COUNT(*) > 10
);

--  5. CASE to label users as Light / Moderate / Heavy listeners
SELECT 
    u.user_name,
    COUNT(p.play_id) AS total_plays,
    CASE 
        WHEN COUNT(p.play_id) >= 10 THEN 'Heavy'
        WHEN COUNT(p.play_id) >= 5 THEN 'Moderate'
        ELSE 'Light'
    END AS listener_category
FROM users u
LEFT JOIN play_history p ON u.user_id = p.user_id
GROUP BY u.user_name;

--  6. Filter by LIKE '%Love%' for romantic songs
SELECT 
    song_name
FROM songs
WHERE song_name LIKE '%Love%';
