
// Query #1 - Sell a book to a customer
MATCH (customer:Customer {name:'Jim Jones'})
MATCH (book:Book{name:'Dune'})
SET book.quantity = book.quantity-1
CREATE (order:Order {datetime:datetime(), total: book.price}),
(order)-[contains:CONTAINS {quantity: 1}]->(book),
(customer)-[makes:MAKES]->(order)

// Query #2 - Change the address of a customer.
MATCH (customer:Customer {name: 'Jim Jones'})
SET customer.address = "Chr M Østergaards Vej 5, 8700 Horsens"
RETURN customer

// Query #3 - Add an existing author to a book.
// Standalone author
CREATE (author2: Author{name:"Frank Herbert Jr."})
MATCH (book:Book)
MATCH (author:Author)
WHERE book.name = "Dune" AND  author.name = "Frank Herbert Jr."
CREATE (author)-[relationship:WRITES]->(book)
RETURN relationship

// Query #4 - Retire the "Space Opera" category and assign all books from that category to the parent category. 
// Don't assume you know the id of the parent category.
MATCH (parent:Category)-[parentRel:HAS]->(category:Category{name:"Space Opera"})-[relationship:INCLUDES]->(book:Book)
CREATE (parent)-[:INCLUDES]-> (book)
DETACH DELETE relationship

// Query #5 - Sell 3 copies of one book and 2 of another in a single order
MATCH (customer {name: 'Jim Jones'})
MATCH (book {name:"Dune"})
MATCH (book2 {name:"Dune Messiah"})
SET book.quantity = book.quantity-3,
book2.quantity = book2.quantity-2
CREATE (order:Order {datetime:datetime(), total: ((book.price*3)+(book2.price*2))}),
(order)-[:CONTAINS {quantity: 3}]->(book),
(order)-[:CONTAINS {quantity: 2}]->(book2),
(customer)-[makes:MAKES]->(order)