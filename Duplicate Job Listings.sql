SELECT COUNT(p.co_w_duplicate_jobs) 
FROM (SELECT ROW_NUMBER() OVER (PARTITION BY company_id, title, description) AS co_w_duplicate_jobs 
      FROM job_listings) AS p
WHERE p.co_w_duplicate_jobs > 1
;
