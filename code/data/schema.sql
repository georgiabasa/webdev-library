CREATE TABLE IF NOT EXISTS AUTHOR (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  firstName VARCHAR(100),
  lastName VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS BOOK (
  ISBN INTEGER PRIMARY KEY,
  title VARCHAR(100),
  publisher VARCHAR(100),
  date_published VARCHAR(100),
  edition INTEGER,
  num_pages INTEGER,
  summary TEXT,
  image_id VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS CATEGORY (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS KEYWORD (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  word VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS WRITES (
  id_author INTEGER,
  ISBN_book INTEGER,
  PRIMARY KEY (id_author, ISBN_book),
  FOREIGN KEY (id_author) REFERENCES AUTHOR(id),
  FOREIGN KEY (ISBN_book) REFERENCES BOOK(ISBN)
);

CREATE TABLE IF NOT EXISTS BELONGS_TO (
  ISBN_book INTEGER,
  id_category INTEGER,
  PRIMARY KEY (ISBN_book, id_category),
  FOREIGN KEY (ISBN_book) REFERENCES BOOK(ISBN),
  FOREIGN KEY (id_category) REFERENCES CATEGORY(id)
);

CREATE TABLE IF NOT EXISTS INCLUDES (
  ISBN_book INTEGER,
  id_keyword INTEGER,
  PRIMARY KEY (ISBN_book, id_keyword),
  FOREIGN KEY (ISBN_book) REFERENCES BOOK(ISBN),
  FOREIGN KEY (id_keyword) REFERENCES KEYWORD(id)
);

CREATE TABLE IF NOT EXISTS USER (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username VARCHAR(100),
  password VARCHAR(100),
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(100),
  phoneNumber VARCHAR(100),
  blacklisted INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS REVIEW (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  rate INTEGER,
  ISBN_book INTEGER,
  comment TEXT,
  FOREIGN KEY (ISBN_book) REFERENCES BOOK(ISBN)
);

CREATE TABLE IF NOT EXISTS MAKES (
  id_review INTEGER,
  id_user INTEGER,
  date VARCHAR(100),
  PRIMARY KEY (id_review, id_user),
  FOREIGN KEY (id_review) REFERENCES REVIEW(id),
  FOREIGN KEY (id_user) REFERENCES USER(id)
);

CREATE TABLE IF NOT EXISTS LIBRARY (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  city VARCHAR(100),
  address VARCHAR(100),
  postcode VARCHAR(100),
  phone VARCHAR(100),
  id_copy INTEGER,
  FOREIGN KEY (id_copy) REFERENCES COPY(id)
);

CREATE TABLE IF NOT EXISTS APPLIES_FOR (
  id_user INTEGER,
  ISBN_book INTEGER,
  date VARCHAR(100),
  PRIMARY KEY (id_user, ISBN_book),
  FOREIGN KEY (id_user) REFERENCES USER(id),
  FOREIGN KEY (ISBN_book) REFERENCES BOOK(ISBN)
);

CREATE TABLE IF NOT EXISTS BORROWS (
  id_user INTEGER,
  id_copy INTEGER,
  date_borrowing VARCHAR(100),
  date_must_return VARCHAR(100),
  PRIMARY KEY (id_user, id_copy, date_borrowing),
  FOREIGN KEY (id_user) REFERENCES USER(id),
  FOREIGN KEY (id_copy) REFERENCES COPY(id)
);

CREATE TABLE IF NOT EXISTS RETURNS (
  id_user INTEGER,
  id_copy INTEGER,
  date_borrowed VARCHAR(100),
  date_returning VARCHAR(100),
  PRIMARY KEY (id_user, id_copy, date_borrowed),
  FOREIGN KEY (id_user) REFERENCES USER(id),
  FOREIGN KEY (id_copy) REFERENCES COPY(id),
  FOREIGN KEY (date_borrowed) REFERENCES BORROWS(date_borrowing)
);

CREATE TABLE IF NOT EXISTS COPY (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ISBN_book INTEGER,
  location VARCHAR(100),
  FOREIGN KEY (ISBN_book) REFERENCES BOOK(ISBN)
);