SELECT name
FROM creature_template
WHERE name NOT IN (
    SELECT DISTINCT crt.name FROM creature_template AS crt 
        INNER JOIN creature AS cr ON crt.id=cr.gid
)
ORDER BY name;
