SELECT e.app_id, ROUND(100.0 * e.click_count/e.impression_count, 2)
FROM (SELECT app_id,SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) AS click_count,
              SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END) AS impression_count
      FROM events
      WHERE DATE_PART('year', timestamp) = 2022
      GROUP BY app_id) AS e;
