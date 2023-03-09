SELECT ol.card_name, ol.issued_amount
FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY issue_year ORDER BY issue_month) AS order_of_launch 
      FROM monthly_cards_issued) AS ol
WHERE ol.order_of_launch = 1;
