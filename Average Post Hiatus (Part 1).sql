SELECT p1.user_id, p1.days_between
FROM (SELECT p.user_id, MAX(p.post_date::DATE) - MIN(p.post_date::DATE) AS days_between
      FROM (SELECT *
            FROM posts 
            WHERE DATE_PART('year', post_date) = 2021) AS p
            GROUP BY p.user_id) AS p1
WHERE p1.days_between > 0
