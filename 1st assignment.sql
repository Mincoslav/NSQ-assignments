-- Question 3
/*
 Table, row, key creation
 */
create table books
(
    pk       serial
        constraint books_pk
            primary key,
    title    varchar,
    price    real,
    quantity integer,
    isbn     varchar
);

alter table books
    owner to postgres;

create unique index books_pk_uindex
    on books (pk);

create table authors
(
    pk   serial
        constraint authors_pk
            primary key,
    name varchar
);

alter table authors
    owner to postgres;

create unique index authors_pk_uindex
    on authors (pk);

create table characters
(
    pk   serial
        constraint characters_pk
            primary key,
    name varchar
);

alter table characters
    owner to postgres;

create unique index characters_pk_uindex
    on characters (pk);

create table customers
(
    pk      serial
        constraint customers_pk
            primary key,
    name    varchar,
    address varchar
);

alter table customers
    owner to postgres;

create unique index customers_pk_uindex
    on customers (pk);

create table orders
(
    pk            serial
        constraint orders_pk
            primary key,
    "FK_Customer" integer
        constraint "FK_customer"
            references customers,
    "dateTime"    timestamp,
    total         real
);

alter table orders
    owner to postgres;

create unique index orders_pk_uindex
    on orders (pk);

create table "booksToAuthorsLookup"
(
    "FK_book"   integer
        constraint "FK_book"
            references books,
    "FK_author" integer
        constraint "FK_author"
            references authors
);

alter table "booksToAuthorsLookup"
    owner to postgres;

create table genres
(
    pk   serial
        constraint genres_pk
            primary key,
    name varchar
);

alter table genres
    owner to postgres;

create unique index genres_pk_uindex
    on genres (pk);

create table "booksToOrdersLookup"
(
    "FK_order" integer
        constraint "FK_order"
            references orders,
    "FK_book"  integer
        constraint "FK_book"
            references books,
    quantity   integer
);

alter table "booksToOrdersLookup"
    owner to postgres;

create table "booksToGenresLookup"
(
    "FK_genre" integer
        constraint "FK_genre"
            references genres,
    "FK_book"  integer
        constraint "FK_book"
            references books
);

alter table "booksToGenresLookup"
    owner to postgres;

create table "booksToCharactersLookup"
(
    "FK_book"      integer
        constraint "FK_book"
            references books,
    "FK_character" integer
        constraint "FK_character"
            references characters
);

alter table "booksToCharactersLookup"
    owner to postgres;

create table "categoryType"
(
    pk   serial
        constraint categorytype_pk
            primary key,
    name varchar
);

alter table "categoryType"
    owner to postgres;

create table categories
(
    pk                serial
        constraint categories_pk
            primary key,
    "FK_categoryType" integer
        constraint "FK_categoryType"
            references "categoryType"
);

alter table categories
    owner to postgres;

create unique index categories_pk_uindex
    on categories (pk);

create table "booksToCategoriesLookup"
(
    "FK_book"     integer
        constraint "FK_book"
            references books,
    "FK_category" integer
        constraint "FK_category"
            references categories
);

alter table "booksToCategoriesLookup"
    owner to postgres;

create unique index categorytype_pk_uindex
    on "categoryType" (pk);

create table "categoriesLookup"
(
    "FK_categoryParent" integer
        constraint "FK_categoryParent"
            references categories,
    "FK_categoryChild"  integer
        constraint "FK_categoryChild"
            references categories
);

alter table "categoriesLookup"
    owner to postgres;

create table "charactersToCategoriesLookup"
(
    "FK_character" integer
        constraint "FK_character"
            references characters,
    "FK_category"  integer
        constraint "FK_category"
            references categories
);

alter table "charactersToCategoriesLookup"
    owner to postgres;

create table "categoriesToGenresLookup"
(
    "FK_category" integer
        constraint "FK_category"
            references categories,
    "FK_genre"    integer
        constraint "FK_genre"
            references genres
);

alter table "categoriesToGenresLookup"
    owner to postgres;

/*
 Table, row, key creation end
 */

-- Question 4

-- Trigger when book has been sold, update its quantity in stock

    CREATE or REPLACE FUNCTION sellBook() RETURNS trigger AS $sell_book$
        BEGIN
        UPDATE books SET quantity = quantity - new.quantity WHERE pk = new."FK_book";
        RETURN new;
        END;
    $sell_book$ LANGUAGE plpgsql;

    CREATE TRIGGER bookQuantityAfterOrderLookup AFTER INSERT ON "booksToOrdersLookup" FOR EACH ROW
    EXECUTE PROCEDURE sellBook();

    -- 1. Sell a book to the customer
    insert into orders ("FK_Customer", "dateTime")
        values (3, now());

    insert into "booksToOrdersLookup" ("FK_order", "FK_book", quantity)
        values (8,3,1);

    -- 2. Change the address of the customer
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


    -- querying data #1 (all books for an author)
    SELECT
        public.authors.name, public.books.title, public.books.isbn
    FROM authors INNER JOIN "booksToAuthorsLookup" on authors.pk = "booksToAuthorsLookup"."FK_author"
    INNER JOIN books on books.pk = "booksToAuthorsLookup"."FK_book"
    WHERE 6 = "booksToAuthorsLookup"."FK_author";


    -- querying data #2 (total of an order)
    SELECT
        round(cast(SUM(public.books.price * public."booksToOrdersLookup".quantity) as numeric),2::integer)
    FROM public.orders INNER JOIN "booksToOrdersLookup" on orders.pk = "booksToOrdersLookup"."FK_order"
    INNER JOIN books on books.pk = "booksToOrdersLookup"."FK_book"
    WHERE "booksToOrdersLookup"."FK_order" = 1;


    -- querying data #3 (Total sales to a customer)
    SELECT
        round(cast(SUM(public.books.price * public."booksToOrdersLookup".quantity) as numeric),2::integer) as total_Sales, sum(public."booksToOrdersLookup".quantity) as no_Of_Books, count(DISTINCT public."booksToOrdersLookup"."FK_order") as no_Of_Orders
    FROM public.orders JOIN "booksToOrdersLookup" on orders.pk = "booksToOrdersLookup"."FK_order"
    JOIN books on books.pk = "booksToOrdersLookup"."FK_book"
    WHERE public.orders."FK_Customer" = 1;

 -- querying data #4 (Books categorized as neither Science Fiction nor Fantasy)
    select * from books inner join "booksToCategoriesLookup" bTCL on books.pk = bTCL."FK_book"
    inner join categories c on bTCL."FK_category" = c.pk
    where c.name != 'Fantasy' and c.name != 'Science Fiction';

    -- querying data #5 (Average page count by genre)
    select round(avg(public.books.pages)) as averagePageCount
    from books inner join "booksToGenresLookup" bTGL on books.pk = bTGL."FK_book"
    inner join  genres g on bTGL."FK_genre" = g.pk group by g.pk;

  -- querying data #6 (Categories with no sub-categories)
    select * from categories where "FK_categoryType" != 3;

 -- querying data #7 (ISBN number of books with more than one author)
    select public.books.isbn from books inner join "booksToAuthorsLookup" on books.pk = "booksToAuthorsLookup"."FK_book"
    inner join authors a on "booksToAuthorsLookup"."FK_author" = a.pk  join
    (select "FK_book", count("FK_book") as bookCount from "booksToAuthorsLookup" GROUP BY "FK_book") as authorsCount on authorsCount."FK_book" = "booksToAuthorsLookup"."FK_book" where authorsCount.bookCount > 1 group by public.books.isbn;

    -- querying data #8 (ISBN numbers of books that sold at least X copies (you decide the value for X) )
        -- let x denote 10 copies
    select isbn from books inner join
            (select bTOL."FK_book", sum(bTOL.quantity) as totalSold from "booksToOrdersLookup" bTOL group by "FK_book") as booksSold
    on pk = booksSold."FK_book" where booksSold.totalSold > 10;

    -- querying data #9 (Number of copies of each book sold – unsold books should show as 0 sold copies)
    select pk, title, coalesce(totalSold,0) as sold from
        (select pk, books.title, sum(bTOL.quantity)as totalSold from "booksToOrdersLookup" bTOL
            full outer join books on  bTOL."FK_book" = books.pk group by "FK_book", title, pk) as pttS;

    -- querying data #10 ( Best-selling books: The top 10 selling books ordered in descending order by number of sales. )
        -- as we have just 10 book, we will query top 5 selling books

    select pk, title, coalesce(totalSold,0) as sold from
        (select pk, books.title, sum(bTOL.quantity)as totalSold from "booksToOrdersLookup" bTOL
            full outer join books on  bTOL."FK_book" = books.pk group by "FK_book", title, pk) as pttS
    order by sold DESC limit 5;

    -- querying data #11 ( Best-selling genres: The top 3 selling genres ordered in descending order by number of sales. )

    select  name, totalSold as sold from
        (select "FK_genre", sum(bTOL.quantity)as totalSold from "booksToOrdersLookup" bTOL
            inner join "booksToGenresLookup" as bTOG on bTOG."FK_book" = bTOL."FK_book" group by "FK_genre") as bTbTtS
        inner join genres on genres.pk = bTbTtS."FK_genre" order by sold DESC limit  3;

    -- querying data #12 ( All science fiction books. )
    SELECT books.title, catLookup."FK_categoryChild" from categories
    inner join "categoriesLookup" as catLookup on categories.pk = catLookup."FK_categoryChild" or categories.pk = catLookup."FK_categoryParent"
    inner join "booksToCategoriesLookup" on "booksToCategoriesLookup"."FK_category" = catLookup."FK_categoryChild"
    inner join "books" on "books".pk = "booksToCategoriesLookup"."FK_book"
        where categories.name = 'Science Fiction'
