SELECT
    customer.surname,
    customer.name,
    destination.country || ', '  || destination.city as destination,
    hotel.name as hotel
    FROM customer 
    INNER JOIN destination ON destination.acronym=customer.top_destination
    INNER JOIN hotel ON hotel.id=destination.hotel_id
    ORDER BY customer.surname, customer.name, destination, hotel;
