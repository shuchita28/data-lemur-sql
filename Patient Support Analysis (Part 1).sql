SELECT COUNT(DISTINCT(ph.policy_holder_id)) AS member_count
FROM (SELECT policy_holder_id, COUNT(DISTINCT(case_id)) 
      FROM callers
      GROUP BY policy_holder_id
      HAVING COUNT(DISTINCT(case_id)) >= 3) AS ph
