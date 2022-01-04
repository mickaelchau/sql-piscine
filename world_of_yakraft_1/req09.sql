SELECT ct.name FROM creature  
INNER JOIN creature_template AS ct ON ct.id=creature.gid
WHERE creature.id=6;
