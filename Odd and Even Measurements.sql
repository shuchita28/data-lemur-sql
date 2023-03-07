SELECT mc.measurement_day AS measurement_day,
       SUM(CASE WHEN mc.measurement_number%2 != 0 THEN mc.measurement_value ELSE 0 END) AS odd_sum,
       SUM(CASE WHEN mc.measurement_number%2 = 0 THEN mc.measurement_value ELSE 0 END) AS even_sum
FROM (SELECT measurement_value, 
       CAST(measurement_time AS date) AS measurement_day,
       ROW_NUMBER() OVER(PARTITION BY CAST(measurement_time AS DATE) ORDER BY measurement_time) AS measurement_number
      FROM measurements) AS mc
GROUP BY mc.measurement_day;
