SELECT utt.*, 
       ROUND((utt.current_year_spend - utt.prev_year_spend) / utt.prev_year_spend * 100, 2) AS yoy_rate
FROM (SELECT ut.*,
             LAG(ut.current_year_spend, 1) OVER(PARTITION BY ut.product_id ORDER BY ut.year) AS prev_year_spend
      FROM (SELECT EXTRACT(YEAR FROM transaction_date) AS year, 
                   product_id,
                   spend AS current_year_spend
            FROM user_transactions) AS ut
      ) AS utt
;
