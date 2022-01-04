SELECT 
    data.surname,
    data.name,
    data.email

FROM (SELECT 
    employee.name,
    employee.surname,
    employee.email,
    agency.ratings
    FROM employee INNER JOIN agency ON employee.agency_code=agency.code) AS data
WHERE data.ratings>6.0;
