// Books creation
CREATE (author: Author{name:"Frank Herbert"}),
(genre: Genre{name:"Non-Romantic"}),
(character: Character{name:"Aliens"}),
(category1: Category{name:"Space Opera"}),
(category2: Category{name:"Science Fiction"}),
(category3: Category{name:"Science Fiction & Fantasy"}),
(book: Book{name:"Dune", price:15, quantity:1000, pageCount: 300, isbn:"978-1529347852"}),
(character)-[:APPEARS]->(book),
(book)-[:BELONGS]->(genre),
(author)-[:WRITES]->(book),
(category1)-[:INCLUDES]->(book),
(category3)-[:HAS]->(category2),
(category2)-[:HAS]->(category1)

// Category creation
CREATE (category4: Category{name:"Biography"}),
    (category5: Category{name:"Historical"}),
    (category6: Category{name:"Royalty"}),
    (category7: Category{name:"Britain"}),
    (category8: Category{name:"1701 - 1900"}),
    (category9: Category{name:"Film, Television & Music"}),
    (category10: Category{name:"Theatre Performers"}),
    (category11: Category{name:"Music"}),
    (category12: Category{name:"Actors & Entertainers"}),
    (category13: Category{name:"True Crime"}),
    (category14: Category{name:"Medical, Legal & Social Sciences"}),
    (category15: Category{name:"Sport"}),
    (category16: Category{name:"Football"}),
    (category17: Category{name:"Basketball"}),
    (category18: Category{name:"Hockey"}),
    (category19: Category{name:"Food & Drink"}),
    (category20: Category{name:"National & International"}),
    (category21: Category{name:"Vegetarian & Vegan"}),
    (category22: Category{name:"Baking"}),
    (category23: Category{name:"Fiction"}),
    (category24: Category{name:"Historical Fiction"}),
    (category25: Category{name:"Fantasy"}),
    (category26: Category{name:"Epic"}),
    (category27: Category{name:"Sword & Sorcery"}),
    (category28: Category{name:"Myths & Legends"}),
    (category29: Category{name:"Science Fiction"}),
    (category30: Category{name:"Alternative History"}),
    (category31: Category{name:"Space Opera"}),
    (category4)-[:HAS]->(category5),
    (category5)-[:HAS]->(category6),
    (category5)-[:HAS]->(category7),
    (category5)-[:HAS]->(category8),
    (category4)-[:HAS]->(category9),
    (category9)-[:HAS]->(category10),
    (category9)-[:HAS]->(category11),
    (category9)-[:HAS]->(category12),
    (category4)-[:HAS]->(category13),
    (category4)-[:HAS]->(category14),
    (category4)-[:HAS]->(category15),
    (category15)-[:HAS]->(category16),
    (category15)-[:HAS]->(category17),
    (category15)-[:HAS]->(category18),
    (category19)-[:HAS]->(category20),
    (category19)-[:HAS]->(category21),
    (category19)-[:HAS]->(category22),
    (category23)-[:HAS]->(category24),
    (category23)-[:HAS]->(category25),
    (category25)-[:HAS]->(category26),
    (category25)-[:HAS]->(category27),
    (category25)-[:HAS]->(category28),
    (category23)-[:HAS]->(category29),
    (category29)-[:HAS]->(category30),
    (category29)-[:HAS]->(category31)

// Books
CREATE (book: Book{name:"Hello", price:37.99, quantity:1300, pageCount: 100, isbn:"888-3-16-128430-0"}), (category1:Category {name:"Galactic Empire"}) // Space opera
(author1: Author{name:"Sam"}),
(author2: Author{name:"Pater"}),
(author1)-[:WRITES]->(book),
(author2)-[:WRITES]->(book),
(genre: Genre{name:"Romantic"}),
(book)-[:BELONGS]->(genre),
(character: Character{name:"Angels"}),
(character1: Character{name:"Pirates"}),
(character)-[:APPEARS]->(book),
(character1)-[:APPEARS]->(book),
(category1)-[:INCLUDES]->(book)

MATCH (findCharacter: Character{name:"Aliens"} ), (category1:Category {name:"Galactic Empire"})
CREATE (book1: Book{name:"There", price:56.99, quantity:2145, pageCount: 350, isbn:"978-3-16-148410-0"}), // Galactix
(author2: Author{name:"Simon"}),
(author3: Author{name:"John"}),
(author2)-[:WRITES]->(book1),
(author3)-[:WRITES]->(book1),
(genre1: Genre{name:"Humour"}),
(book1)-[:BELONGS]->(genre1),
(findCharacter)-[:APPEARS]->(book1)
(category1)-[:INCLUDES]->(book1)

MATCH (author: Author{name:"Sam"} ), (genre: Genre{name:"Non-Romantic"} ), (category1:Category {name:"Royalty"})
CREATE (book2: Book{name:"Let it go", price:75.99, quantity:3009, pageCount: 178, isbn:"908-3-16-128430-0"}),
(author)-[:WRITES]->(book2),
(book2)-[:BELONGS]->(genre),
(character1: Character{name:"Clones"}),
(character1)-[:APPEARS]->(book2)
(category1)-[:INCLUDES]->(book2)

MATCH (genre: Genre{name:"Humour"} ), (findCharacter: Character{name:"Pirates"} ), (category1:Category {name:"Baking"})
CREATE (book3: Book{name:"Iron card", price:100.99, quantity:857, pageCount: 369, isbn:"765-3-16-122430-0"}),
(author: Author{name:"Dawid"}),
(author)-[:WRITES]->(book3),
(book3)-[:BELONGS]->(genre),
(findCharacter)-[:APPEARS]->(book3),
(category1)-[:INCLUDES]->(book3)

MATCH (genre: Genre{name:"Humour"} ), (category1:Category {name:"Epic"})
CREATE (book4: Book{name:"New me", price:205.99, quantity:300, pageCount: 100, isbn:"009-3-16-128430-0"}),
(author: Author{name:"Peter"}),
(author)-[:WRITES]->(book4),
(book4)-[:BELONGS]->(genre),
(character1: Character{name:"Clones"}),
(character1)-[:APPEARS]->(book4),
(category1)-[:INCLUDES]->(book4)

MATCH (author: Author{name:"Dawid"} ), (findCharacter: Character{name:"Angels"} ), (category1:Category {name:"Science Fiction"})
CREATE (book5: Book{name:"Dark Sun", price:101.99, quantity:98, pageCount: 170, isbn:"873-3-16-128430-0"}),
(author)-[:WRITES]->(book5),
(genre1: Genre{name:"Mistery"}),
(book5)-[:BELONGS]->(genre),
(findCharacter)-[:APPEARS]->(book5),
(category1)-[:INCLUDES]->(book5)

MATCH (author:Author {name: "Simon"}), (author1:Author {name: "Peter"}), (category1:Category {name:"Football"})
CREATE (book6: Book{name:"River", price:365.99, quantity:500, pageCount: 266, isbn:"978-3-16-128430-0"}),
(author)-[:WRITES]->(book6),
(author1)-[:WRITES]->(book6),
(genre: Genre{name:"Horror"}),
(book6)-[:BELONGS]->(genre),
(character1: Character{name:"Devils"}),
(character1)-[:APPEARS]->(book6),
(category1)-[:INCLUDES]->(book6)

MATCH (author:Author {name: "John"}), (findCharacter: Character{name:"Clones"} ), (category1:Category {name:"Historical Fiction"})
CREATE (book7: Book{name:"It", price:133.99, quantity:133.99, pageCount: 575, isbn:"123-3-16-128430-0"}),
(author1: Author{name:"Max"}),
(author)-[:WRITES]->(book7),
(author1)-[:WRITES]->(book7),
(genre: Genre{name:"Thriller"}),
(book7)-[:BELONGS]->(genre),
(findCharacter)-[:APPEARS]->(book7),
(category1)-[:INCLUDES]->(book7)

MATCH (author:Author {name: "Peter"}), (genre: Genre{name:"Humour"} ), (category1:Category {name:"Myths & Legends"})
CREATE (book8: Book{name:"Old story", price:103.22, quantity:23, pageCount: 189, isbn:"009-3-16-128259-0"}),
(author)-[:WRITES]->(book8),
(book8)-[:BELONGS]->(genre),
(character1: Character{name:"Corporations"}),
(character1)-[:APPEARS]->(book8),
(category1)-[:INCLUDES]->(book8)

MATCH (author:Author {name: "Frank Herbert"})
MATCH (category2:Category {name: "Science Fiction"})
MATCH (category3:Category {name: "Science Fiction & Fantasy"})
MATCH (character:Character {name: "Aliens"})
CREATE (category1:Category {name:"Galactic Empire"}),
(genre: Genre{name:"Novel"}),
(book: Book{name:"Dune Messiah", price:7, quantity:1000, pageCount: 350, isbn:"978-1473655324"}),
(book)-[:BELONGS]->(genre),
(author)-[:WRITES]->(book),
(category1)-[:INCLUDES]->(book),
(category2)-[:HAS]->(category1),
(character)-[:APPEARS]->(book)

// Customer creation
CREATE (jim: Customer{address:"Banegårdsgade 2, 8700 Horsens", name:"Jim Jones"})