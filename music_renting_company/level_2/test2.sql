UPDATE stock
SET stock=stock+3
WHERE (stock.id=(SELECT stock.id FROM stock 
        INNER JOIN (SELECT id FROM album WHERE name='Traces') AS data 
        ON stock.alb_id=data.id));

UPDATE stock
SET stock=stock+5
WHERE (stock.id=(SELECT stock.id FROM stock 
        INNER JOIN (SELECT id FROM album 
            WHERE name='Joe Dassin (Les Champs-Élysées)') AS data 
        ON stock.alb_id=data.id));

UPDATE stock
SET stock=stock+4
WHERE (stock.id=(SELECT stock.id FROM stock 
        INNER JOIN (SELECT id FROM album WHERE name='France Gall') AS data 
        ON stock.alb_id=data.id));
