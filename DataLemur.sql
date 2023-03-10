--DataLemur Problem 1
------------start------------
--SELECT candidate_id 
--FROM candidates
--GROUP BY candidate_id
--HAVING COUNT(candidate_id) = 3; 

--SELECT candidate_id
--FROM candidates
--WHERE skill = 'Python' AND skill = 'Tableau' AND skill = 'PostgreSQL';

SELECT candidate_id
FROM candidates
WHERE skill in ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(candidate_id) = 3;
------------end--------------

--DataLemur Problem 2
------------start------------
SELECT pages.page_id 
FROM pages LEFT JOIN page_likes 
ON pages.page_id = page_likes.page_id
WHERE page_likes.page_id ISNULL;
------------end--------------

--DataLemur Problem 3
------------start------------
SELECT part
FROM (SELECT part
FROM parts_assembly
WHERE finish_date ISNULL) as p
GROUP BY part;
------------end--------------

--DataLemur Problem 4
------------start------------
--SELECT COUNT(user_id) as mobile_views 
--FROM viewership
--WHERE device_type in ('tablet', 'phone');

--SELECT COUNT(user_id) as laptop_views
--FROM viewership
--WHERE device_type  = 'laptop'

SELECT l.*, m.*
FROM (SELECT COUNT(user_id) as mobile_views 
      FROM viewership
      WHERE device_type in ('tablet', 'phone')) as m, 
      (SELECT COUNT(user_id) as laptop_views
      FROM viewership
      WHERE device_type  = 'laptop') as l
;

SELECT 
  SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) as laptop_views,
  SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views
FROM viewership;
------------end--------------

--DataLemur Problem 6
------------start------------
SELECT COUNT(p.co_w_duplicate_jobs) 
FROM (SELECT ROW_NUMBER() OVER (PARTITION BY company_id, title, description) AS co_w_duplicate_jobs 
      FROM job_listings) AS p
WHERE p.co_w_duplicate_jobs > 1
;

SELECT COUNT(DISTINCT company_id) AS co_w_duplicate_jobs
FROM (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY 
    company_id, 
    title, 
    description) AS jobs_grouped
WHERE job_count > 1;
------------end--------------

--DataLemur Problem 8
------------start------------
SELECT p1.user_id, p1.days_between
FROM (SELECT p.user_id, MAX(p.post_date::DATE) - MIN(p.post_date::DATE) AS days_between
      FROM (SELECT *
            FROM posts 
            WHERE DATE_PART('year', post_date) = 2021) AS p
            GROUP BY p.user_id) AS p1
WHERE p1.days_between > 0
------------end--------------

--DataLemur Problem 9
------------start------------
SELECT s.sender_id, COUNT(s.sender_id) 
FROM (SELECT * 
      FROM messages
      WHERE DATE_PART('year', sent_date) = 2022 AND DATE_PART('month', sent_date) = 8) AS s
GROUP BY s.sender_id
ORDER BY COUNT(s.sender_id) DESC
LIMIT 2;

SELECT 
  sender_id,
  COUNT(message_id) AS count_messages
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = '8'
  AND EXTRACT(YEAR FROM sent_date) = '2022'
GROUP BY sender_id;
------------end--------------

--DataLemur Problem 10
------------start------------
SELECT t.user_id, t.spend, t.transaction_date
FROM (SELECT *, DENSE_RANK() OVER(PARTITION BY user_id ORDER BY transaction_date) AS rank_num
      FROM transactions) AS t
WHERE t.rank_num = 3;
------------end--------------

--DataLemur Problem 11
------------start------------
SELECT cc.category, cc.product, cc.total_spend
FROM ((SELECT c.*, ROW_NUMBER() OVER( PARTITION BY c.category) AS row_num 
      FROM (SELECT category, product, SUM(spend) AS total_spend 
            FROM product_spend
            WHERE DATE_PART('year', transaction_date) = 2022
            GROUP BY category, product
            ORDER BY total_spend DESC) AS c)
      ) AS cc
WHERE cc.row_num < 3;

WITH product_category_spend AS (
SELECT 
  category, 
  product, 
  SUM(spend) AS total_spend 
FROM product_spend 
WHERE transaction_date >= '2022-01-01' 
  AND transaction_date <= '2022-12-31' 
GROUP BY category, product
),
top_spend AS (
SELECT *, 
  RANK() OVER (
    PARTITION BY category 
    ORDER BY total_spend DESC) AS ranking 
FROM product_category_spend)

SELECT category, product, total_spend 
FROM top_spend 
WHERE ranking <= 2 
ORDER BY category, ranking;

------------end------------

--DataLemur Problem 13
------------start----------
--SELECT a.artist_name, DENSE_RANK() OVER( ORDER BY (SUM(gsr.no_top_rank) AS total_songs)) AS artist_rank
--FROM (SELECT gs.song_id, gs.artist_id, COUNT(gs.rank) AS no_top_rank
--      FROM (SELECT s.artist_id, COUNT(s.song_id) 
--            FROM songs s JOIN global_song_rank g ON s.song_id = g.song_id
--            WHERE g.rank <= 10
--            GROUP BY s.artist_id) AS gs
--      ORDER BY no_top_rank DESC) AS gsr JOIN artists a ON gsr.artist_id = a.artist_id
--GROUP BY a.artist_name
--ORDER BY total_songs DESC


SELECT artist_name, artist_rank
FROM (SELECT gs.artist_id, DENSE_RANK() OVER( ORDER BY(gs.count) DESC) AS artist_rank
      FROM (SELECT s.artist_id, COUNT(s.song_id) AS count
            FROM songs s JOIN global_song_rank g ON s.song_id = g.song_id
            WHERE g.rank <= 10
            GROUP BY s.artist_id) AS gs) AS gsr JOIN artists a ON gsr.artist_id = a.artist_id
WHERE artist_rank <= 5
ORDER BY artist_rank, artist_name
------------end------------
