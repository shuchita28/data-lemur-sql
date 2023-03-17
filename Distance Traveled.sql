SELECT CASE WHEN ur.distance_traveled ISNULL THEN 0 ELSE ur.distance_traveled END AS distance_traveled, 
        ur.name AS name
FROM (select SUM(r.distance) AS distance_traveled, u.name
        from users u LEFT JOIN rides r ON u.id = r.passenger_user_id
        GROUP BY u.name
        ORDER BY distance_traveled DESC) AS ur
ORDER BY distance_traveled DESC;
