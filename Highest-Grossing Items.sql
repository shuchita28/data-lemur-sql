SELECT cc.category, cc.product, cc.total_spend
FROM ((SELECT c.*, ROW_NUMBER() OVER( PARTITION BY c.category) AS row_num 
      FROM (SELECT category, product, SUM(spend) AS total_spend 
            FROM product_spend
            WHERE DATE_PART('year', transaction_date) = 2022
            GROUP BY category, product
            ORDER BY total_spend DESC) AS c)
      ) AS cc
WHERE cc.row_num < 3;
