// Books creation
CREATE (author: Author{name:"Frank Herbert"}),
(genre: Genre{name:"Non-Romantic"}),
(character: Character{name:"Aliens"}),
(category1: Category{name:"Space Opera"}),
(category2: Category{name:"Science Fiction"}),
(category3: Category{name:"Science Fiction & Fantasy"}),
(book: Book{name:"Dune", price:15, quantity:1000, isbn:"978-1529347852"}),
(character)-[:APPEARS]->(book),
(book)-[:BELONGS]->(genre),
(author)-[:WRITES]->(book),
(category1)-[:INCLUDES]->(book),
(category3)-[:HAS]->(category2),
(category2)-[:HAS]->(category1)

MATCH (author:Author {name: "Frank Herbert"})
MATCH (category2:Category {name: "Science Fiction"})
MATCH (category3:Category {name: "Science Fiction & Fantasy"})
MATCH (character:Character {name: "Aliens"})
CREATE (category1:Category {name:"Galactic Empire"}),
(genre: Genre{name:"Novel"}),
(book: Book{name:"Dune Messiah", price:7, quantity:1000, isbn:"978-1473655324"}),
(book)-[:BELONGS]->(genre),
(author)-[:WRITES]->(book),
(category1)-[:INCLUDES]->(book),
(category2)-[:HAS]->(category1),
(character)-[:APPEARS]->(book)

// Customer creation
CREATE (jim: Customer{address:"Banegårdsgade 2, 8700 Horsens", name:"Jim Jones"})