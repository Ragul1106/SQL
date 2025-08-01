-- Total Plays Per Song
SELECT 
  s.song_id,
  s.title,
  COUNT(p.play_id) AS total_plays
FROM songs s
INNER JOIN plays p ON s.song_id = p.song_id
GROUP BY s.song_id, s.title;

--  Average Play Duration Per Genre
SELECT 
  s.genre,
  AVG(p.duration) AS avg_play_duration
FROM songs s
JOIN plays p ON s.song_id = p.song_id
GROUP BY s.genre;

--  Artists with Songs Played More Than 1000 Times (HAVING)
SELECT 
  a.artist_id,
  a.name AS artist_name,
  COUNT(p.play_id) AS total_plays
FROM artists a
JOIN songs s ON a.artist_id = s.artist_id
JOIN plays p ON s.song_id = p.song_id
GROUP BY a.artist_id, a.name
HAVING total_plays > 1000;

--  INNER JOIN - Songs ↔ Plays
SELECT 
  s.song_id,
  s.title,
  p.play_id,
  p.listener_id,
  p.duration
FROM songs s
INNER JOIN plays p ON s.song_id = p.song_id;

-- RIGHT JOIN - Listeners ↔ Plays
SELECT 
  l.listener_id,
  l.name AS listener_name,
  p.play_id,
  p.song_id
FROM listeners l
RIGHT JOIN plays p ON l.listener_id = p.listener_id;

--  SELF JOIN - Listeners Who Play Similar Genres
SELECT 
  l1.listener_id AS listener1,
  l2.listener_id AS listener2,
  s1.genre
FROM plays p1
JOIN songs s1 ON p1.song_id = s1.song_id
JOIN listeners l1 ON p1.listener_id = l1.listener_id

JOIN plays p2 ON s1.genre = (SELECT genre FROM songs WHERE song_id = p2.song_id)
JOIN listeners l2 ON p2.listener_id = l2.listener_id

WHERE l1.listener_id <> l2.listener_id;
