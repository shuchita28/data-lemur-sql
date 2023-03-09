SELECT ROUND(SUM(i.no_of_items)::decimal / SUM(i.order_occurrences)::decimal, 1) AS mean
FROM (SELECT item_count, order_occurrences, item_count*order_occurrences AS no_of_items 
      FROM items_per_order) AS i;
