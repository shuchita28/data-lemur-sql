WITH s1 AS(
  SELECT searches 
  FROM search_frequency
  GROUP BY searches,GENERATE_SERIES(1,num_users) 
  )
  
SELECT 
  PERCENTILE_CONT(0.5) 
    WITHIN GROUP (
      ORDER BY searches) AS median
FROM s1;
