SELECT quest.title FROM character_quests 
INNER JOIN quest ON quest_id=quest.id
WHERE character_id=(
    SELECT id FROM character
    WHERE character.name='Kuro'
)
ORDER BY quest.title;

