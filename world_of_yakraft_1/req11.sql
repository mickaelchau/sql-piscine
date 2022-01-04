SELECT 
    quest.title,
    crt.name
FROM quest  
INNER JOIN creature AS cr ON quest.creature_start=cr.id
INNER JOIN creature_template AS crt ON cr.gid=crt.id
ORDER BY quest.title, crt.name;
