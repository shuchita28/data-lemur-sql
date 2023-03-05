SELECT s.sender_id, COUNT(s.sender_id) 
FROM (SELECT * 
      FROM messages
      WHERE DATE_PART('year', sent_date) = 2022 AND DATE_PART('month', sent_date) = 8) AS s
GROUP BY s.sender_id
ORDER BY COUNT(s.sender_id) DESC
LIMIT 2;
