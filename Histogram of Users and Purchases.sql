SELECT t.transaction_date, t.user_id, t.purchase_count 
FROM (SELECT transaction_date, 
             user_id, 
             COUNT(product_id) AS purchase_count,  
             ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) 
      FROM user_transactions
      GROUP BY transaction_date, user_id) AS t
WHERE t.row_number = 1
ORDER BY t.transaction_date;
