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
