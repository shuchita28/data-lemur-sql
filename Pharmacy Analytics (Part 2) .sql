SELECT l. manufacturer, 
       SUM(CASE WHEN l.loss < 0 THEN 1 ELSE 0 END) AS drug_count,
       SUM(CASE WHEN l.loss < 0 THEN ABS(l.loss) ELSE 0 END) AS total_loss
FROM (SELECT manufacturer, drug, total_sales - cogs AS loss
      FROM pharmacy_sales) AS l
GROUP BY l.manufacturer
ORDER BY total_loss DESC
LIMIT 6;
