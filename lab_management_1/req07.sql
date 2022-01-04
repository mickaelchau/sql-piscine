SELECT assistant, sum(price) as price FROM transaction INNER JOIN can ON can=can.name GROUP BY assistant ORDER BY price DESC LIMIT 3;
