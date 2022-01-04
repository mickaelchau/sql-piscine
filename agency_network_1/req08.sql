SELECT customer_surname AS best_customers, count(*) AS "number of travels" 
FROM booking GROUP BY best_customers ORDER BY "number of travels" DESC,
customer_surname DESC LIMIT 3;
