SELECT part
FROM (SELECT part
FROM parts_assembly
WHERE finish_date ISNULL) as p
GROUP BY part;
