--SELECT candidate_id 
--FROM candidates
--GROUP BY candidate_id
--HAVING COUNT(candidate_id) = 3; 

--SELECT candidate_id
--FROM candidates
--WHERE skill = 'Python' AND skill = 'Tableau' AND skill = 'PostgreSQL';

SELECT candidate_id
FROM candidates
WHERE skill in ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(candidate_id) = 3;
