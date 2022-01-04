SELECT regexp_replace(country, '[^a-zA-Z]', '', 'g') as country,
regexp_replace(city, '[^a-zA-Z]', '', 'g') as city 
FROM destination ORDER BY country,city;
