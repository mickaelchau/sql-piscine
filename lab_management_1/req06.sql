SELECT login FROM assistant WHERE login NOT IN (SELECT DISTINCT assistant FROM transaction);
