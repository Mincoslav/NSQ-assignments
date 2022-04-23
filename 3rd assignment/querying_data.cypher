// Query #1 All books by an author
MATCH (author:Author)-[:Writes]-(books)
WHERE author.name = 'Frank Herbert' RETURN author, books

// Query #2 Total price of an order
MATCH (order: Order)
RETURN order.total

// Query #3 Total sales (in £) to a customer

// Query #4 Books that are categorized as neither fiction nor non-fiction

// Query #5 Average page count by genre

// Query #6 Categories that have no sub-categories

// Query #7 ISBN numbers of books with more than one author

// Query #8 ISBN numbers of books that sold at least X copies (you decide the value for X)

// Query #9 Number of copies of each book sold – unsold books should show as 0 sold copies

// Query #10 Best-selling books: The top 10 selling books ordered in descending order by number of sales

// Query #11 Best-selling genres: The top 3 selling genres ordered in descending order by number of sales

// Query #12 All science fiction books. Note: Books in science fiction subcategories like cyberpunk also count as science fiction. Don’t use your knowledge of the concrete category structure.

// Query #13 Characters used in science fiction books. Note from (12) applies here as well.

// Query #14 Number of books in each category including books in subcategories.