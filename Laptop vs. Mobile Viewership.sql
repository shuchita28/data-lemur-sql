--SELECT COUNT(user_id) as mobile_views 
--FROM viewership
--WHERE device_type in ('tablet', 'phone');

--SELECT COUNT(user_id) as laptop_views
--FROM viewership
--WHERE device_type  = 'laptop'

--SELECT l.*, m.*
--FROM (SELECT COUNT(user_id) as mobile_views 
--      FROM viewership
--      WHERE device_type in ('tablet', 'phone')) as m, 
--      (SELECT COUNT(user_id) as laptop_views
--      FROM viewership
--      WHERE device_type  = 'laptop') as l
--;

--SELECT 
--  SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) as laptop_views,
--  SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views
--FROM viewership;

SELECT l.*, m.*
FROM (SELECT COUNT(user_id) as mobile_views 
      FROM viewership
      WHERE device_type in ('tablet', 'phone')) as m, 
      (SELECT COUNT(user_id) as laptop_views
      FROM viewership
      WHERE device_type  = 'laptop') as l
;
