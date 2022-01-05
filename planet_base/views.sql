CREATE OR REPLACE VIEW view_nearest_planet_to_sun AS 
SELECT planet.name AS planet FROM planet 
INNER JOIN planetary_system ON planetary_system.id=id_system 
WHERE lower(planetary_system.star)='sun' ORDER BY period LIMIT 3;

CREATE OR REPLACE VIEW view_nb_satellite_per_planet AS
SELECT planet.name, COALESCE(data.count, 0) as "number_of_satellites" 
FROM planet LEFT OUTER JOIN (SELECT planet.name,count(*) FROM satellite 
    INNER JOIN planet ON id_planet=planet.id 
    WHERE satellite.radius>500
    GROUP BY planet.name) AS data 
ON planet.name=data.name ORDER BY "number_of_satellites", planet.name;

CREATE OR REPLACE VIEW view_average_period AS
SELECT data.star, round((sum(period)::float/count(*))::numeric,2)
FROM (SELECT star, planet.name, period
    FROM planetary_system AS ps 
    INNER JOIN planet ON ps.id=planet.id_system) AS data 
GROUP BY data.star;

CREATE OR REPLACE VIEW view_biggest_entities AS
(SELECT 'satellite' AS type, ps.name AS system, satellite.name, satellite.radius FROM satellite INNER JOIN planet ON id_planet=planet.id INNER JOIN planetary_system AS ps ON planet.id_system=ps.id) UNION (SELECT 'planet', ps.name, planet.name,radius FROM planet INNER JOIN planetary_system AS ps ON ps.id=planet.id_system) ORDER BY radius DESC, name LIMIT 10;
