CREATE OR REPLACE FUNCTION space_travel(origin INT, destination INT, quantity BIGINT)
RETURNS boolean AS
$$
BEGIN
    IF (((SELECT population FROM planet WHERE planet.id=origin) < quantity)
        OR quantity < 0 OR 
        (SELECT id_system FROM planet WHERE planet.id=origin) <> 
        (SELECT id_system FROM planet WHERE planet.id=destination) ) THEN 
        RETURN false;
    END IF;
    UPDATE planet
    SET population=population-quantity 
    WHERE id=origin;
    UPDATE planet
    SET population=population+quantity 
    WHERE id=destination;
    RETURN true;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION list_satellite_inf_750(syst INT)
RETURNS TABLE(satellite VARCHAR(32), planet VARCHAR(32), radius INT) AS
$$
BEGIN
    RETURN QUERY(SELECT satellite.name, planet.name, satellite.radius FROM satellite 
        INNER JOIN planet ON satellite.id_planet=planet.id 
        WHERE (planet.id_system=syst AND satellite.radius<=750)
        ORDER BY planet.name, satellite.radius DESC, satellite.name);
END;
$$ LANGUAGE plpgsql;

