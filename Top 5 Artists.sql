--SELECT a.artist_name, DENSE_RANK() OVER( ORDER BY (SUM(gsr.no_top_rank) AS total_songs)) AS artist_rank
--FROM (SELECT gs.song_id, gs.artist_id, COUNT(gs.rank) AS no_top_rank
--      FROM (SELECT s.artist_id, COUNT(s.song_id) 
--            FROM songs s JOIN global_song_rank g ON s.song_id = g.song_id
--            WHERE g.rank <= 10
--            GROUP BY s.artist_id) AS gs
--      ORDER BY no_top_rank DESC) AS gsr JOIN artists a ON gsr.artist_id = a.artist_id
--GROUP BY a.artist_name
--ORDER BY total_songs DESC


SELECT artist_name, artist_rank
FROM (SELECT gs.artist_id, DENSE_RANK() OVER( ORDER BY(gs.count) DESC) AS artist_rank
      FROM (SELECT s.artist_id, COUNT(s.song_id) AS count
            FROM songs s JOIN global_song_rank g ON s.song_id = g.song_id
            WHERE g.rank <= 10
            GROUP BY s.artist_id) AS gs) AS gsr JOIN artists a ON gsr.artist_id = a.artist_id
WHERE artist_rank <= 5
ORDER BY artist_rank, artist_name
