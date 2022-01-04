SELECT id, CASE WHEN end_date < now() THEN 'Done' 
WHEN start_date > now() THEN 'Booked' ELSE 'Ongoing' END AS trip_status 
FROM booking ORDER BY trip_status, id;
