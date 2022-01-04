SELECT data.count FROM (SELECT count(*), assistant FROM transaction GROUP BY assistant) AS data WHERE data.assistant='julien.clement';
