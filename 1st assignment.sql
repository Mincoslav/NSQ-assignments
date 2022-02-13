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

    -- modifying data #1

    -- modifying data #2

    -- modifying data #3

    -- modifying data #4

    -- modifying data #5

    -- querying data #1 (all books for an author)


    -- querying data #2 (total of an order)
    SELECT
        round(cast(SUM(public.books.price * public."booksToOrdersLookup".quantity) as numeric),2::integer)
    FROM public.orders INNER JOIN "booksToOrdersLookup" on orders.pk = "booksToOrdersLookup"."FK_order"
    INNER JOIN books on books.pk = "booksToOrdersLookup"."FK_book"
    WHERE "booksToOrdersLookup"."FK_order" = 1