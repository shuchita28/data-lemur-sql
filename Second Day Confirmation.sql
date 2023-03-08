SELECT et.user_id
FROM (SELECT e.email_id, e.user_id, t.signup_action, t.action_date,
       RANK() OVER(PARTITION BY e.user_id ORDER BY t.action_date) AS day_num
      FROM emails e JOIN texts t ON e.email_id = t.email_id
      ) AS et
WHERE et.signup_action = 'Confirmed' AND et.day_num = 2;
