// Query #1



// Query #2 - Change the address of a customer.
MATCH (customer {name: 'Jim Jones'})
SET customer.address = "Chr M Østergaards Vej 4, 8700 Horsens"
RETURN customer


// Query #3 - Add an existing author to a book.
MATCH 
	(book:Book),
	(author:Author)
WHERE book.title = "Dune" AND author.name = "Frank Herbert Jr."
CREATE (author)-[relationship:Writes]->(book)
RETURN relationship

