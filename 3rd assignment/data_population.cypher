// Books creation
CREATE (author: Author{name:"Frank Herbert"}),
(genre: Genre{name:"Non-Romantic"}),
(character: Character{name:"Aliens"}),
(category1: Category{name:"Space Opera"}),
(category2: Category{name:"Science Fiction"}),
(category3: Category{name:"Science Fiction & Fantasy"}),
(book: Book{name:"Dune", price:15, quantity:1000, isbn:"978-1529347852"}),
(character)-[:Appears]->(book),
(book)-[:Belongs]->(genre),
(author)-[:Writes]->(book),
(category1)-[:Includes]->(book),
(category3)-[:Has]->(category2),
(category2)-[:Has]->(category1)


// Standalone author
CREATE (author2: Author{name:"Frank Herbert Jr."}),

// Customer creation
CREATE (jim: Customer{address:"Banegårdsgade 2, 8700 Horsens", name:"Jim Jones"})