SELECT ROUND(j.international_calls::decimal / j.total_calls::decimal * 100.0, 1)
FROM (SELECT  
  SUM(CASE WHEN caller.country_id != receiver.country_id THEN 1 ELSE 0 END) AS international_calls,
  COUNT(caller.caller_id) AS total_calls
      FROM phone_calls AS calls
      LEFT JOIN phone_info AS caller
        ON calls.caller_id = caller.caller_id
      LEFT JOIN phone_info AS receiver
        ON calls.receiver_id = receiver.caller_id) AS j
