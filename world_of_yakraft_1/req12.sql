SELECT DISTINCT 
    crt1.name
FROM quest  
INNER JOIN creature AS cr1 ON quest.creature_start=cr1.id 
INNER JOIN creature AS cr2 ON quest.creature_end=cr2.id
INNER JOIN creature_template AS crt1 ON cr1.gid=crt1.id
INNER JOIN creature_template AS crt2 ON cr2.gid=crt2.id
WHERE crt1.name=crt2.name
ORDER BY crt1.name;
