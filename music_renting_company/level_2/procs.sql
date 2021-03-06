CREATE OR REPLACE FUNCTION rent_album(
    email VARCHAR(64), album VARCHAR(64), begin_date DATE)
RETURNS BOOLEAN AS
$$
DECLARE
    customer_id INT;
    album_id INT;
    matching_rent_id INT;
    stock_num INT;
    stock_id INT;
BEGIN
    customer_id := (SELECT * FROM COALESCE((SELECT id FROM customer                        
        WHERE mail=email), -1)); 
    IF (customer_id = -1) THEN
        RETURN false;
    END IF;
    album_id := (SELECT * FROM COALESCE((SELECT id FROM album AS a                       
        WHERE a.name=album), -1));
    IF (album_id = -1) THEN
        RETURN false;
    END IF;
    stock_id := (SELECT * FROM COALESCE((SELECT id FROM stock AS s 
                WHERE s.alb_id=album_id), -1));
    IF (stock_id = -1) THEN
        RETURN false;
    END IF;
    stock_num := (SELECT s.stock FROM stock AS s WHERE s.alb_id=album_id);
    IF (stock_num <= 0) THEN
        RETURN false;
    END IF;
    matching_rent_id := (SELECT * FROM COALESCE((
            SELECT id FROM rent 
            WHERE (rent.prs_id=customer_id AND rent.stock_id=album_id)), -1)); 
    IF (matching_rent_id <> -1) THEN
        RETURN false;
    END IF;
    UPDATE stock
        SET stock=stock-1
        WHERE alb_id=album_id;
    INSERT INTO rent VALUES(default, stock_id, customer_id, begin_date, null);
    RETURN true;
END; 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION return_album(
    email VARCHAR(64), album VARCHAR(64), given_end_date DATE)
RETURNS BOOLEAN AS
$$
DECLARE
    customer_id INT;
    album_id INT;
    get_stock_id INT;
    rent_id INT;
    start_date DATE;
BEGIN
    customer_id := (SELECT * FROM COALESCE((SELECT id FROM customer                        
        WHERE customer.mail=email), -1)); 
    IF (customer_id = -1) THEN
        RETURN false;
    END IF;
    album_id := (SELECT * FROM COALESCE((SELECT id FROM album AS a                       
        WHERE a.name=album), -1));
    IF (album_id = -1) THEN
        RETURN false;
    END IF;
    get_stock_id := (SELECT * FROM COALESCE((SELECT id FROM stock AS s 
                WHERE s.alb_id=album_id), -1));
    IF (get_stock_id = -1) THEN
        RETURN false;
    END IF;
    rent_id := (SELECT * FROM COALESCE((SELECT id FROM rent AS r                       
        WHERE (r.prs_id=customer_id AND r.stock_id=get_stock_id)), -1));
    IF (rent_id = -1) THEN
        RETURN false;
    END IF;
    start_date := (SELECT * FROM COALESCE((SELECT begin_date FROM rent AS r                    
        WHERE r.id=rent_id), null)); 
    IF ((start_date = null) OR (start_date > given_end_date) 
        OR (start_date = given_end_date)) THEN
        RETURN false;
    END IF;
    UPDATE rent
    SET end_date=given_end_date
        WHERE id=rent_id;
    UPDATE stock
        SET stock=stock+1
        WHERE stock.id=get_stock_id;
    RETURN true;
END
$$ LANGUAGE plpgsql;
