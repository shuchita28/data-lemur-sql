SELECT DATE_PART('month', submit_date), product_id, ROUND(AVG(stars), 2) 
FROM reviews
GROUP BY DATE_PART('month', submit_date), product_id
ORDER BY DATE_PART('month', submit_date), product_id;
