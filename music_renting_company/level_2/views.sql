DROP VIEW IF EXISTS view_customers;

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
SELECT customer.mail as email, customer.name, COALESCE(total_rents,0) as total_rents, 
COALESCE(current_rents,0) as current_rents FROM customer 
LEFT OUTER JOIN (
    SELECT mail as email, name, count(*) AS total_rents, 
    get_customers(rent.prs_id) AS "current_rents" FROM customer 
    INNER JOIN rent ON rent.prs_id=customer.id 
    GROUP by email, name, customer.id, rent.prs_id) AS data 
ON customer.mail=data.email ORDER BY customer.mail; 

CREATE OR REPLACE VIEW view_stocks AS 
SELECT name AS album,stock FROM stock INNER JOIN album ON alb_id=album.id 
ORDER BY name;

CREATE OR REPLACE VIEW view_rents AS 
SELECT customer.mail AS email, album.name AS album, 
begin_date AS begin, end_date as end FROM rent 
    INNER JOIN customer ON rent.prs_id=customer.id
    INNER JOIN stock ON rent.stock_id=stock.id
    INNER JOIN album ON stock.alb_id=album.id;
