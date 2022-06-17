// Query #1 All books by an author
MATCH (author:Author)-[:WRITES]-(books)
WHERE author.name = 'Frank Herbert' RETURN author, books

// Query #2 Total price of an order
MATCH (order: Order)
RETURN order.total

// Query #3 Total sales (in £) to a customer
MATCH (customer:Customer {name:"Jim Jones"})-[:MAKES]-(orders:Order)
RETURN sum(orders.total)


// Query #4 Books that are categorized as neither fiction nor non-fiction
MATCH (book:Book)<-[:INCLUDES]-(category:Category)
WHERE category.name <> 'Science Fiction'
return book

// Query #5 Average page count by genre
MATCH (genre:Genre)<-[:BELONGS]-(b:Book)
RETURN genre.name, avg(b.pageCount)

// Query #6 Categories that have no sub-categories
MATCH (category:Category) WHERE NOT (category) - [:HAS] -> (:Category)
RETURN category

// Query #7 ISBN numbers of books with more than one author
MATCH (book:Book) <- [:WRITES]- (author:Author) 
with book, count(author) as total WHERE total > 1 
RETURN book.isbn

// Query #8 ISBN numbers of books that sold at least X copies (you decide the value for X)
MATCH (o:Order)-[c:CONTAINS]->(b:Book)
WITH b, sum(c.quantity) as soldCount
WHERE soldCount > 2
RETURN b.isbn

// Query #9 Number of copies of each book sold – unsold books should show as 0 sold copies
MATCH (b:Book)
OPTIONAL MATCH (o:Order)-[c:CONTAINS]->(b:Book)
RETURN sum(c.quantity), b.name

// Query #10 Best-selling books: The top 10 selling books ordered in descending order by number of sales
MATCH (b:Book)
OPTIONAL MATCH (o:Order)-[c:CONTAINS]->(b:Book)
RETURN sum(c.quantity) as sold, b.name ORDER BY sold DESC LIMIT 10

// Query #11 Best-selling genres: The top 3 selling genres ordered in descending order by number of sales
MATCH (b:Book)
MATCH (o:Order)-[c:CONTAINS]->(b:Book)-[:BELONGS]->(genre:Genre)
RETURN sum(c.quantity) as sold, genre.name ORDER BY sold DESC LIMIT 3

// Query #12 All science fiction books. Note: Books in science fiction subcategories like cyberpunk also count as science fiction. Don’t use your knowledge of the concrete category structure.
MATCH (book:Book)<-[:INCLUDES]-(category:Category)<-[:HAS *]-(parent:Category{name:"Science Fiction"})
RETURN book

// Query #13 Characters used in science fiction books. Note from (12) applies here as well.
MATCH (character:Character)-[:APPEARS]->(book:Book)<-[:INCLUDES]-(category:Category)<-[:HAS *]-(parent:Category{name:"Science Fiction"})
RETURN DISTINCT character.name

// Query #14 Number of books in each category including books in subcategories.
MATCH (book:Book)<-[:INCLUDES]-(category:Category)<-[:HAS *]-(parent:Category)
RETURN parent.name, count(book)