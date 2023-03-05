SELECT t.user_id, 
       t.tweet_date, 
       ROUND(AVG(t.total_tweet) OVER(PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg
FROM (SELECT  COUNT(tweet_id) AS total_tweet, user_id, tweet_date
      FROM tweets
      GROUP by user_id, tweet_date
      ORDER BY user_id, tweet_date) AS t;
