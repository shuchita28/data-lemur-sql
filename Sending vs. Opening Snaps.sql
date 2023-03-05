--SELECT 
--  CASE 
--    WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END
--FROM activities a JOIN age_breakdown b ON a.user_id = b.user_id
--WHERE a.activity_type IN ('send', 'open');


SELECT s.age_bucket, 
       ROUND((s.send_time)/(s.send_time + s.open_time) * 100.0 ,2) AS send_perc,
       ROUND((s.open_time)/(s.send_time + s.open_time) * 100.0 ,2) AS open_perc
FROM (SELECT b.age_bucket,
             SUM(CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END) AS send_time,
             SUM(CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END) AS open_time
      FROM activities a JOIN age_breakdown b ON a.user_id = b.user_id
      WHERE a.activity_type IN ('open', 'send')
      GROUP BY b.age_bucket
      ) AS s;
