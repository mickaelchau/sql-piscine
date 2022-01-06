DROP VIEW IF EXISTS view_customers;view_customers

CREATE OR REPLACE FUNCTION get_customers(client_id INT)
RETURNS INT AS
$$
BEGIN
    IF ((SELECT prs_id from rent WHERE ((rent.end_date IS null) 
        AND (prs_id=client_id))) IS NOT null) THEN
        RETURN 1;
    END IF;
    RETURN 0;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION print_customers()
RETURNS INT AS
$$
DECLARE 
    id INT;
    current_rents INT; 
BEGIN
    current_rents := get_customers(id);
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW view_customers AS 
SELECT mail as email, name, count(*) AS total_rents, 
get_customers(rent.prs_id) AS "current_rents"
FROM rent INNER JOIN customer ON rent.prs_id=customer.id 
GROUP by email, name, customer.id, rent.prs_id;

CREATE OR REPLACE VIEW view_stocks AS 
SELECT name AS album,stock FROM stock INNER JOIN album ON alb_id=album.id;
