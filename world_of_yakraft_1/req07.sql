UPDATE character
SET level=15
WHERE name='Tilon';

UPDATE character
SET level=level+1
WHERE name='Kuro';

UPDATE character
SET max_health=(SELECT CASE WHEN blessed=0 THEN level*10
     ELSE (level+1)*10
END AS formula);

