CREATE TABLE IF NOT EXISTS "USER" (
	"id" integer,
	"username" varchar,
	"password" varchar,
	"first_name" varchar,
	"last_name" varchar,
	"email" varchar,
	"phone_number" varchar,
	"blacklisted" boolean,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "BOOK" (
	"ISBN" integer,
	"title" string,
	"publisher" string,
	"date_published" date,
	"edition" integer,
	"number_of_pages" integer,
	"summary" text,
	PRIMARY KEY ("ISBN")
);

CREATE TABLE IF NOT EXISTS "COPY" (
	"id" integer,
	"ISBN_book" integer,
	PRIMARY KEY ("id", "ISBN_book"),
	FOREIGN KEY ("ISBN_book") REFERENCES "BOOK" ("ISBN")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "CATEGORY" (
	"id" integer,
	"name" varchar,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "AUTHOR" (
	"id" integer,
	"first_name" varchar,
	"last_name" varchar,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "KEYWORD" (
	"id" integer,
	"word" string,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "REVIEW" (
	"id" integer,
	"rate" integer,
	"comment" text,
	"ISBN_book" integer,
	PRIMARY KEY ("id"),
	FOREIGN KEY ("ISBN_book") REFERENCES "BOOK" ("ISBN")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "APPLIES FOR" (
	"id_user" integer,
	"ISBN_book" integer,
	"date" date,
	PRIMARY KEY ("id_user", "ISBN_book"),
	FOREIGN KEY ("id_user") REFERENCES "USER" ("id")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT,
	FOREIGN KEY ("ISBN_book") REFERENCES "BOOK" ("ISBN")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "BORROWS" (
	"id_user" integer,
	"ISBN_book" integer,
	"id_copy" integer,
	"date_borrowing" date,
	"date_must_return" date,
	PRIMARY KEY ("id_user", "ISBN_book", "id_copy", "date_borrowing"),
	FOREIGN KEY ("id_user") REFERENCES "USER" ("id")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT,
	FOREIGN KEY ("ISBN_book") REFERENCES "COPY" ("ISBN_book")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT,
	FOREIGN KEY ("id_copy") REFERENCES "COPY" ("id")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "RETURNS" (
	"id_user" integer,
	"ISBN_book" integer,
	"id_copy" integer,
	"date_borrowed" date,
	"date_returning" date,
	PRIMARY KEY ("id_user", "ISBN_book", "id_copy", "date_borrowed"),
	FOREIGN KEY ("id_user") REFERENCES "USER" ("id")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT,
	FOREIGN KEY ("ISBN_book") REFERENCES "BORROWS" ("ISBN_book")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT,
	FOREIGN KEY ("id_copy") REFERENCES "BORROWS" ("id_copy")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT,
	FOREIGN KEY ("date_borrowed") REFERENCES "BORROWS" ("date_borrowing")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "MAKES" (
	"id_review" integer,
	"id_user" integer,
	"date" date,
	PRIMARY KEY ("id_review", "id_user"),
	FOREIGN KEY ("id_review") REFERENCES "REVIEW" ("id")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT,
	FOREIGN KEY ("id_user") REFERENCES "USER" ("id")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "BELONGS TO" (
	"ISBN_book" integer,
	"id_category" integer,
	PRIMARY KEY ("ISBN_book", "id_category"),
	FOREIGN KEY ("ISBN_book") REFERENCES "BOOK" ("ISBN")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT,
	FOREIGN KEY ("id_category") REFERENCES "CATEGORY" ("id")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "WRITES" (
	"id_author" integer,
	"ISBN_book" integer,
	PRIMARY KEY ("id_author", "ISBN_book"),
	FOREIGN KEY ("id_author") REFERENCES "AUTHOR" ("id")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT,
	FOREIGN KEY ("ISBN_book") REFERENCES "BOOK" ("ISBN")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "INCLUDES" (
	"ISBN_book" integer,
	"id_keyword" integer,
	PRIMARY KEY ("ISBN_book", "id_keyword"),
	FOREIGN KEY ("ISBN_book") REFERENCES "BOOK" ("ISBN")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT,
	FOREIGN KEY ("id_keyword") REFERENCES "KEYWORD" ("id")
            ON UPDATE RESTRICT
            ON DELETE RESTRICT
);

