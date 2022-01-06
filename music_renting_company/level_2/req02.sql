CREATE OR REPLACE FUNCTION add_new_stock(nam VARCHAR(64), amount INT)
RETURNS VOID AS
$$
DECLARE 
    album_id INT;
BEGIN
    album_id := (SELECT album.id FROM album WHERE album.name=nam);
    INSERT INTO stock
    VALUES (default, album_id, amount);
END
$$ LANGUAGE plpgsql;
SELECT add_new_stock('Traces', 3);
SELECT add_new_stock('Joe Dassin (Les Champs-Élysées)', 5);
SELECT add_new_stock('France Gall', 4);
