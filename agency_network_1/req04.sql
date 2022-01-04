SELECT count(*),my_db.country 
FROM (SELECT country FROM destination GROUP BY city,country) as my_db 
GROUP BY my_db.country ORDER BY count DESC, country;

