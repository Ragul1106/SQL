-- Feedback Rating per Event (Subquery in SELECT)
SELECT e.event_id, e.name,
       (SELECT AVG(f.rating)
        FROM feedback f
        WHERE f.event_id = e.event_id) AS avg_feedback_rating
FROM events e;

-- Event Turnout Classification (CASE with turnout %)
SELECT e.event_id, e.name, e.capacity,
       COUNT(r.attendee_id) AS attendees_count,
       (COUNT(r.attendee_id) * 100.0 / e.capacity) AS turnout_percentage,
       CASE
           WHEN (COUNT(r.attendee_id) * 100.0 / e.capacity) >= 80 THEN 'High Turnout'
           WHEN (COUNT(r.attendee_id) * 100.0 / e.capacity) >= 50 THEN 'Moderate Turnout'
           ELSE 'Low Turnout'
       END AS turnout_level
FROM events e
LEFT JOIN registrations r ON e.event_id = r.event_id
GROUP BY e.event_id, e.name, e.capacity;

-- Online and Offline Events (UNION ALL)
-- Online Events
SELECT event_id, name, 'Online' AS mode
FROM events
WHERE mode = 'online'

UNION ALL

-- Offline Events
SELECT event_id, name, 'Offline' AS mode
FROM events
WHERE mode = 'offline';

-- Top Participant per Event (Correlated Subquery)
SELECT r.event_id, r.attendee_id, a.name, r.attended_sessions
FROM registrations r
JOIN attendees a ON r.attendee_id = a.attendee_id
WHERE r.attended_sessions = (
    SELECT MAX(r2.attended_sessions)
    FROM registrations r2
    WHERE r2.event_id = r.event_id
);

-- Event-wise Engagement (JOIN + GROUP BY)
SELECT e.event_id, e.name, COUNT(r.attendee_id) AS total_attendees,
       AVG(f.rating) AS avg_rating
FROM events e
LEFT JOIN registrations r ON e.event_id = r.event_id
LEFT JOIN feedback f ON e.event_id = f.event_id
GROUP BY e.event_id, e.name;

-- Upcoming Events (Date Filtering)
SELECT event_id, name, event_date
FROM events
WHERE event_date >= CURRENT_DATE
ORDER BY event_date ASC;
      