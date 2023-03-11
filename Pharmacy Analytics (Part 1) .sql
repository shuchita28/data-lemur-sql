SELECT drugs, (total_sales - cogs) AS profit
FROM pharmacy_sales
ORDER BY profit DESC
LIMIT 3;
