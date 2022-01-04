SELECT customer_surname AS best_customers, count(*) AS number_of_travels 
FROM booking GROUP BY best_customers ORDER BY number_of_travels DESC,
customer_surname DESC LIMIT 3;
