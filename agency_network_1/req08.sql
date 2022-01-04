SELECT customer_surname AS "best customers", count(*) AS "number of travels" 
FROM booking GROUP BY "best customers" ORDER BY "number of travels" DESC,
customer_surname DESC LIMIT 3;
