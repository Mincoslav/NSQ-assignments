// Books creation
CREATE (v1: Author{name:"Frank Herbert"}),
(v2: Genre{name:"Non-Romantic"}),
(v3: Character{name:"Aliens"}),
(v4: Category{name:"Space Opera"}),
(v5: Category{name:"Science Fiction"}),
(v6: Category{name:"Science Fiction & Fantasy"}),
(v7: Book{title:"Dune", price:15, quantity:1000, isbn:"978-1529347852"}),
(v3)-[:Appears]->(v7),
(v7)-[:Belongs]->(v2),
(v1)-[:Writes]->(v7),
(v4)-[:Includes]->(v7),
(v6)-[:Has]->(v5),
(v5)-[:Has]->(v4)


// Standalone author
CREATE (v1: Author{name:"Frank Herbert Jr."}),

// Customer creation
CREATE (jim: Customer{address:"Banegårdsgade 2, 8700 Horsens", name:"Jim Jones"})