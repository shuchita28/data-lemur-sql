SELECT cc.customer_id 
FROM (SELECT c.customer_id, COUNT(DISTINCT p.product_category) AS category_count
      FROM customer_contracts c LEFT JOIN products p ON c.product_id = p.product_id
      GROUP BY c.customer_id) AS cc
WHERE cc.category_count = 3;
