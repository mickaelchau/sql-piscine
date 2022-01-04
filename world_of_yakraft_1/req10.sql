SELECT creature.id FROM creature  
INNER JOIN creature_template AS ct ON ct.id=creature.gid
WHERE ct.level>10 ORDER BY creature.id;
