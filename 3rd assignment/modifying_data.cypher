// Query #1



// Query #2
MATCH (customer {name: 'Jim Jones'})
SET customer.address = "Chr M Østergaards Vej 4, 8700 Horsens"
RETURN customer