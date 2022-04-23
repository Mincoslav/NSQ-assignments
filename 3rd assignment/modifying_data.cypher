// Query #1 - Sell a book to a customer



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


// Query #4 - Retire the "Space Opera" category and assign all books from that category to the parent category. 
// Don't assume you know the id of the parent category.



// Query #5 - Sell 3 copies of one book and 2 of another in a single order
