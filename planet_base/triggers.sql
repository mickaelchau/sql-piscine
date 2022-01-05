DROP TABLE IF EXISTS evolutionpop CASCADE;
DROP TRIGGER IF EXISTS view_earth_population_evolution ON planet;

CREATE TABLE evolution_pop (
  id   SERIAL      PRIMARY KEY,
  date timestamp NOT NULL,
  old_population BIGINT NOT NULL,
  new_population BIGINT NOT NULL, 
  CHECK (old_population >= 0 AND new_population > 0)
);

CREATE OR REPLACE FUNCTION add_population() RETURNS trigger AS
$$
BEGIN
    INSERT INTO evolution_pop 
    VALUES (default, now(), OLD.population, NEW.population);
    return NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER view_earth_population_evolution AFTER UPDATE 
OF population ON planet
FOR EACH ROW
WHEN (NEW.name='Earth')
EXECUTE PROCEDURE add_population();

CREATE OR REPLACE VIEW view_earth_population_evolution AS
SELECT id, TO_TIMESTAMP(date::text, 'YYYY-MM-DD HH24:MI:SS') AS date, 
old_population AS "old population", 
new_population AS "new population" FROM evolution_pop;
