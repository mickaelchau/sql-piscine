SELECT quest.title, character.name FROM character_quests 
INNER JOIN quest ON quest_id=quest.id
INNER JOIN character ON character_id=character.id
WHERE complete=0
ORDER BY quest.title, character.name;

