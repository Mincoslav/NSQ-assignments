// Books creation
CREATE (v1: Author{id:1, name:"Frank Herbert"}),
(v2: Genre{id:1, name:"Non-Romantic"}),
(v3: Character{id:1, name:"Aliens"}),
(v4: Category{id:1, name:"Space Opera"}),
(v5: Category{id:2, name:"Science Fiction"}),
(v6: Category{id:3, name:"Science Fiction & Fantasy"}),
(v7: Book{id:1, title:"Dune", price:15, quantity:1000, isbn:"978-1529347852"}),
(v3)-[:Appears]->(v7),
(v7)-[:Belongs]->(v2),
(v1)-[:Writes]->(v7),
(v4)-[:Includes]->(v7),
(v6)-[:Has]->(v5),
(v5)-[:Has]->(v4)


// Customer creation
CREATE (jim: Customer{id:1, address:"Banegårdsgade 2, 8700 Horsens", name:"Jim Jones"})