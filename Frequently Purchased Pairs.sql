SELECT COUNT(DISTINCT CONCAT(p1.product_id, p2.product_id)) AS unique_pairs
FROM (SELECT t.transaction_id, t.product_id, p.product_name
      FROM transactions t 
           INNER JOIN products p ON t.product_id = p.product_id) AS p1
      INNER JOIN (SELECT t.transaction_id, t.product_id, p.product_name
      FROM transactions t 
           INNER JOIN products p ON t.product_id = p.product_id) AS p2
           ON p1.transaction_id = p2.transaction_id
           AND p1.product_id > p2.product_id;
