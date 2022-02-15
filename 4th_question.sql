

-- Question 4

-- Modifying data



-- Trigger when book has been sold, update its quantity in stock

CREATE or REPLACE FUNCTION sellBook() RETURNS trigger AS $sell_book$
    BEGIN
	UPDATE books SET quantity = quantity - new.quantity WHERE pk = new."FK_book";
	RETURN new;
    END;
$sell_book$ LANGUAGE plpgsql;

CREATE TRIGGER bookQuantityAfterOrderLookup AFTER INSERT ON "booksToOrdersLookup" FOR EACH ROW
EXECUTE PROCEDURE sellBook();

-- Sell a book to the customer
insert into orders ("FK_Customer", "dateTime")
    values (3, now());

insert into "booksToOrdersLookup" ("FK_order", "FK_book", quantity)
    values (8,3,1);

-- Change the address of the customer
UPDATE customers SET address = 'New address street 66'
    WHERE customers.pk = 1;

-- 3. Add an existing author to a book
INSERT INTO "booksToAuthorsLookup" ("FK_book", "FK_author") VALUES (1, 5);

-- 4. Retire the "Space Opera" category and assign all books from that category to the parent category. Do not assume you know an id of the parent category

UPDATE "booksToCategoriesLookup" set "FK_category" =
    (SELECT "FK_categoryParent" from "categoriesLookup" where "categoriesLookup"."FK_categoryChild" =
                                                              (SELECT pk from categories where categories.name = 'Space Opera'))
WHERE "booksToCategoriesLookup"."FK_category" =
      (SELECT pk from categories where categories.name = 'Space Opera');

DELETE FROM "categoriesLookup" WHERE "FK_categoryChild"= (SELECT pk from categories where categories.name = 'Space Opera');
DELETE FROM categories WHERE name = 'Space Opera';

-- 5. Sell 3 copies of one book and 2 of another in a single order
insert into orders ("FK_Customer", "dateTime")
    values (6, now());

insert into "booksToOrdersLookup" ("FK_order", "FK_book", quantity)
    values (9,3,3),(9,2,2);



