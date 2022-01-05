CREATE OR REPLACE FUNCTION rent_album(
    email VARCHAR(64), album VARCHAR(64), begin_date DATE)
RETURNS BOOLEAN AS
$$
DECLARE
    customer_id INT;
    album_id INT;
    matching_rent_id INT;
    stock INT;
BEGIN
    customer_id := (SELECT * FROM COALESCE((SELECT id FROM customer                        
        WHERE mail=email), -1)); 
    album_id := (SELECT * FROM COALESCE((SELECT id FROM album AS a                       
        WHERE a.name=album), -1));
    stock := (SELECT s.stock FROM stock AS s);
    matching_rent_id := (SELECT * FROM COALESCE((
            SELECT id FROM rent 
            WHERE (pers_id=customer_id AND stock_id=album_id)), -1)); 
    IF (customer_id = -1) THEN
        RETURN false;
    ELSIF (album_id = -1) THEN
        RETURN false;
    ELSIF (matching_rent_id <> -1) THEN
        RETURN false;
    ELSIF (stock <= 0) THEN
        RETURN false;
    END IF;
    UPDATE stock AS s
        SET s.stock=s.stock-1
        WHERE s.id=album_id;
    INSERT INTO rent VALUES(default, customer_id, begin_date, now());
    RETURN true;
END; 
$$ LANGUAGE plpgsql;
