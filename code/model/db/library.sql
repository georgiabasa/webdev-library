BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "AUTHOR" (
	"id"	INTEGER,
	"firstName"	VARCHAR(100),
	"lastName"	VARCHAR(100),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "BOOK" (
	"ISBN"	INTEGER,
	"title"	VARCHAR(100),
	"publisher"	VARCHAR(100),
	"date_published"	VARCHAR(100),
	"edition"	INTEGER,
	"num_pages"	INTEGER,
	"summary"	TEXT,
	"image_id"	VARCHAR(10),
	PRIMARY KEY("ISBN")
);
CREATE TABLE IF NOT EXISTS "CATEGORY" (
	"id"	INTEGER,
	"name"	VARCHAR(100),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "KEYWORD" (
	"id"	INTEGER,
	"word"	VARCHAR(100),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "WRITES" (
	"id_author"	INTEGER,
	"ISBN_book"	INTEGER,
	FOREIGN KEY("ISBN_book") REFERENCES "BOOK"("ISBN"),
	FOREIGN KEY("id_author") REFERENCES "AUTHOR"("id"),
	PRIMARY KEY("id_author","ISBN_book")
);
CREATE TABLE IF NOT EXISTS "BELONGS_TO" (
	"ISBN_book"	INTEGER,
	"id_category"	INTEGER,
	FOREIGN KEY("id_category") REFERENCES "CATEGORY"("id"),
	FOREIGN KEY("ISBN_book") REFERENCES "BOOK"("ISBN"),
	PRIMARY KEY("ISBN_book","id_category")
);
CREATE TABLE IF NOT EXISTS "INCLUDES" (
	"ISBN_book"	INTEGER,
	"id_keyword"	INTEGER,
	FOREIGN KEY("ISBN_book") REFERENCES "BOOK"("ISBN"),
	FOREIGN KEY("id_keyword") REFERENCES "KEYWORD"("id"),
	PRIMARY KEY("ISBN_book","id_keyword")
);
CREATE TABLE IF NOT EXISTS "REVIEW" (
	"id"	INTEGER,
	"rate"	INTEGER,
	"ISBN_book"	INTEGER,
	"comment"	TEXT,
	FOREIGN KEY("ISBN_book") REFERENCES "BOOK"("ISBN"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "MAKES" (
	"id_review"	INTEGER,
	"id_user"	INTEGER,
	"date"	VARCHAR(100),
	FOREIGN KEY("id_review") REFERENCES "REVIEW"("id"),
	FOREIGN KEY("id_user") REFERENCES "USER"("id"),
	PRIMARY KEY("id_review","id_user")
);
CREATE TABLE IF NOT EXISTS "LIBRARY" (
	"id"	INTEGER,
	"city"	VARCHAR(100),
	"address"	VARCHAR(100),
	"postcode"	VARCHAR(100),
	"phone"	VARCHAR(100),
	"id_copy"	INTEGER,
	FOREIGN KEY("id_copy") REFERENCES "COPY"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "APPLIES_FOR" (
	"id_user"	INTEGER,
	"ISBN_book"	INTEGER,
	"date"	VARCHAR(100),
	FOREIGN KEY("ISBN_book") REFERENCES "BOOK"("ISBN"),
	FOREIGN KEY("id_user") REFERENCES "USER"("id"),
	PRIMARY KEY("id_user","ISBN_book")
);
CREATE TABLE IF NOT EXISTS "BORROWS" (
	"id_user"	INTEGER,
	"id_copy"	INTEGER,
	"date_borrowing"	VARCHAR(100),
	"date_must_return"	VARCHAR(100),
	FOREIGN KEY("id_copy") REFERENCES "COPY"("id"),
	FOREIGN KEY("id_user") REFERENCES "USER"("id"),
	PRIMARY KEY("id_user","id_copy","date_borrowing")
);
CREATE TABLE IF NOT EXISTS "RETURNS" (
	"id_user"	INTEGER,
	"id_copy"	INTEGER,
	"date_borrowed"	VARCHAR(100),
	"date_returning"	VARCHAR(100),
	FOREIGN KEY("id_user") REFERENCES "USER"("id"),
	FOREIGN KEY("id_copy") REFERENCES "COPY"("id"),
	FOREIGN KEY("date_borrowed") REFERENCES "BORROWS"("date_borrowing"),
	PRIMARY KEY("id_user","id_copy","date_borrowed")
);
CREATE TABLE IF NOT EXISTS "COPY" (
	"id"	INTEGER,
	"ISBN_book"	INTEGER,
	FOREIGN KEY("ISBN_book") REFERENCES "BOOK"("ISBN"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "USER" (
	"id"	INTEGER,
	"email"	VARCHAR(100),
	"hashpass"	TEXT,
	"first_name"	VARCHAR(100),
	"last_name"	VARCHAR(100),
	"phoneNumber"	VARCHAR(100),
	"blacklisted"	INTEGER DEFAULT 0,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "AUTHOR" VALUES (1,'Alice','Adams');
INSERT INTO "AUTHOR" VALUES (2,'Bob','Baker');
INSERT INTO "AUTHOR" VALUES (3,'Cindy','Carter');
INSERT INTO "AUTHOR" VALUES (4,'David','Davis');
INSERT INTO "AUTHOR" VALUES (5,'Emily','Evans');
INSERT INTO "AUTHOR" VALUES (6,'Frank','Fisher');
INSERT INTO "AUTHOR" VALUES (7,'Grace','Green');
INSERT INTO "AUTHOR" VALUES (8,'Henry','Harris');
INSERT INTO "AUTHOR" VALUES (9,'Irene','Ingram');
INSERT INTO "AUTHOR" VALUES (10,'Jack','Johnson');
INSERT INTO "AUTHOR" VALUES (11,'Kate','Kelly');
INSERT INTO "AUTHOR" VALUES (12,'Luke','Lewis');
INSERT INTO "AUTHOR" VALUES (13,'Mary','Miller');
INSERT INTO "AUTHOR" VALUES (14,'Nathan','Nelson');
INSERT INTO "AUTHOR" VALUES (15,'Olivia','Owens');
INSERT INTO "AUTHOR" VALUES (16,'Paul','Parker');
INSERT INTO "AUTHOR" VALUES (17,'Quinn','Quinn');
INSERT INTO "AUTHOR" VALUES (18,'Rachel','Rogers');
INSERT INTO "AUTHOR" VALUES (19,'Sam','Smith');
INSERT INTO "AUTHOR" VALUES (20,'Tom','Taylor');
INSERT INTO "AUTHOR" VALUES (21,'Ursula','Underwood');
INSERT INTO "AUTHOR" VALUES (22,'Victor','Vincent');
INSERT INTO "AUTHOR" VALUES (23,'Wendy','Wilson');
INSERT INTO "AUTHOR" VALUES (24,'Xavier','Xavier');
INSERT INTO "AUTHOR" VALUES (25,'Yvonne','Young');
INSERT INTO "AUTHOR" VALUES (26,'Zack','Zane');
INSERT INTO "AUTHOR" VALUES (27,'Andrew','Adams');
INSERT INTO "AUTHOR" VALUES (28,'Bella','Brown');
INSERT INTO "AUTHOR" VALUES (29,'Charlie','Clark');
INSERT INTO "AUTHOR" VALUES (30,'Daniel','Drake');
INSERT INTO "AUTHOR" VALUES (31,'Emma','Edwards');
INSERT INTO "AUTHOR" VALUES (32,'Freddie','Fox');
INSERT INTO "AUTHOR" VALUES (33,'Grace','Gray');
INSERT INTO "AUTHOR" VALUES (34,'Harry','Hayes');
INSERT INTO "AUTHOR" VALUES (35,'Ivy','Irving');
INSERT INTO "AUTHOR" VALUES (36,'Jack','Jackson');
INSERT INTO "AUTHOR" VALUES (37,'Katie','Knight');
INSERT INTO "AUTHOR" VALUES (38,'Liam','Long');
INSERT INTO "AUTHOR" VALUES (39,'Molly','Murphy');
INSERT INTO "AUTHOR" VALUES (40,'Nathan','Norris');
INSERT INTO "AUTHOR" VALUES (41,'Olivia','Olsen');
INSERT INTO "AUTHOR" VALUES (42,'Peter','Perry');
INSERT INTO "AUTHOR" VALUES (43,'Quincy','Quinn');
INSERT INTO "AUTHOR" VALUES (44,'Rachel','Reid');
INSERT INTO "AUTHOR" VALUES (45,'Sam','Scott');
INSERT INTO "AUTHOR" VALUES (46,'Tom','Turner');
INSERT INTO "AUTHOR" VALUES (47,'Ursula','Underhill');
INSERT INTO "AUTHOR" VALUES (48,'Victor','Vaughn');
INSERT INTO "AUTHOR" VALUES (49,'Wendy','White');
INSERT INTO "AUTHOR" VALUES (50,'Xavier','Xander');
INSERT INTO "AUTHOR" VALUES (51,'Yvonne','York');
INSERT INTO "AUTHOR" VALUES (52,'Zack','Zimmerman');
INSERT INTO "AUTHOR" VALUES (53,'Albert','Adams');
INSERT INTO "AUTHOR" VALUES (54,'Beatrice','Brown');
INSERT INTO "AUTHOR" VALUES (55,'Charles','Cox');
INSERT INTO "AUTHOR" VALUES (56,'Diana','Davis');
INSERT INTO "AUTHOR" VALUES (57,'Edward','Evans');
INSERT INTO "AUTHOR" VALUES (58,'Fiona','Fisher');
INSERT INTO "AUTHOR" VALUES (59,'George','Gray');
INSERT INTO "AUTHOR" VALUES (60,'Helen','Hill');
INSERT INTO "AUTHOR" VALUES (61,'Isaac','Ingram');
INSERT INTO "AUTHOR" VALUES (62,'Jasmine','Jackson');
INSERT INTO "AUTHOR" VALUES (63,'Kevin','Kelly');
INSERT INTO "AUTHOR" VALUES (64,'Laura','Lee');
INSERT INTO "AUTHOR" VALUES (65,'Michael','Moore');
INSERT INTO "AUTHOR" VALUES (66,'Nicole','Nelson');
INSERT INTO "AUTHOR" VALUES (67,'Oscar','Owens');
INSERT INTO "AUTHOR" VALUES (68,'Peter','Parker');
INSERT INTO "AUTHOR" VALUES (69,'Quentin','Quinn');
INSERT INTO "AUTHOR" VALUES (70,'Rachel','Roberts');
INSERT INTO "AUTHOR" VALUES (71,'Samuel','Smith');
INSERT INTO "AUTHOR" VALUES (72,'Taylor','Turner');
INSERT INTO "AUTHOR" VALUES (73,'Ursula','Ulrich');
INSERT INTO "AUTHOR" VALUES (74,'Vincent','Vaughn');
INSERT INTO "AUTHOR" VALUES (75,'Wendy','Wilson');
INSERT INTO "AUTHOR" VALUES (76,'Xavier','Xavier');
INSERT INTO "AUTHOR" VALUES (77,'Yvonne','Yates');
INSERT INTO "AUTHOR" VALUES (78,'Zack','Zane');
INSERT INTO "AUTHOR" VALUES (79,'Adam','Andrews');
INSERT INTO "AUTHOR" VALUES (80,'Beth','Baker');
INSERT INTO "AUTHOR" VALUES (81,'Carl','Carter');
INSERT INTO "AUTHOR" VALUES (82,'Dana','Davis');
INSERT INTO "AUTHOR" VALUES (83,'Eric','Edwards');
INSERT INTO "AUTHOR" VALUES (84,'Fiona','Fox');
INSERT INTO "AUTHOR" VALUES (85,'George','Gray');
INSERT INTO "AUTHOR" VALUES (86,'Holly','Hayes');
INSERT INTO "AUTHOR" VALUES (87,'Ian','Ingram');
INSERT INTO "AUTHOR" VALUES (88,'Jackie','Johnson');
INSERT INTO "AUTHOR" VALUES (89,'Karl','Kelly');
INSERT INTO "AUTHOR" VALUES (90,'Laura','Long');
INSERT INTO "AUTHOR" VALUES (91,'Matthew','Murphy');
INSERT INTO "AUTHOR" VALUES (92,'Naomi','Norris');
INSERT INTO "AUTHOR" VALUES (93,'Oliver','Olsen');
INSERT INTO "AUTHOR" VALUES (94,'Paul','Perry');
INSERT INTO "AUTHOR" VALUES (95,'Queenie','Quinn');
INSERT INTO "AUTHOR" VALUES (96,'Ryan','Reid');
INSERT INTO "AUTHOR" VALUES (97,'Sarah','Scott');
INSERT INTO "AUTHOR" VALUES (98,'Tom','Turner');
INSERT INTO "AUTHOR" VALUES (99,'Ursula','Underwood');
INSERT INTO "AUTHOR" VALUES (100,'Victor','Vaughn');
INSERT INTO "BOOK" VALUES (1,'Clean Code: A Handbook of Agile Software Craftsmanship','Prentice Hall','August 11, 2008',1,464,'Clean Code is divided into three parts. The first describes the principles, patterns, and practices of writing clean code. The second part consists of several case studies of increasing complexity. Each case study is an exercise in cleaning up code—of transforming a code base that has some problems into one that is sound and efficient. The third part is the payoff: a single chapter containing a list of heuristics and “smells” gathered while creating the case studies.',NULL);
INSERT INTO "BOOK" VALUES (2,'Design Patterns: Elements of Reusable Object-Oriented Software','Addison-Wesley Professional','November 10, 1994',1,395,'Design Patterns: Elements of Reusable Object-Oriented Software is a software engineering book describing software design patterns. The books authors are Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides with a foreword by Grady Booch. The book is divided into two parts, with the first two chapters exploring the capabilities and pitfalls of object-oriented programming, and the remaining chapters describing 23 classic software design patterns.',NULL);
INSERT INTO "BOOK" VALUES (3,'The Pragmatic Programmer: Your Journey to Mastery','Addison-Wesley Professional','October 20, 1999',1,352,'The Pragmatic Programmer: Your Journey to Mastery is a book about computer programming and software engineering, written by Andrew Hunt and David Thomas and published in October 1999. It is published by Addison-Wesley. The book has become a classic in the software engineering community and is often recommended to software developers just starting their careers.',NULL);
INSERT INTO "BOOK" VALUES (4,'Refactoring: Improving the Design of Existing Code','Addison-Wesley Professional','June 24, 1999',1,464,'Refactoring: Improving the Design of Existing Code is a book by Martin Fowler about refactoring, which is a systematic process of improving existing computer code without changing its external behavior. Its first edition was written in 1999 and became an instant classic.',NULL);
INSERT INTO "BOOK" VALUES (5,'Domain-Driven Design: Tackling Complexity in the Heart of Software','Addison-Wesley Professional','August 22, 2003',1,560,'Domain-Driven Design: Tackling Complexity in the Heart of Software is a book by Eric Evans. It offers readers a systematic approach to domain-driven design, presenting an extensive set of design best practices, experience-based techniques, and fundamental principles that facilitate the development of software projects facing complex domains.',NULL);
INSERT INTO "BOOK" VALUES (6,'Clean Architecture: A Craftsman''s Guide to Software Structure and Design','Prentice Hall','September 20, 2017',1,432,'Clean Architecture: A Craftsman''s Guide to Software Structure and Design presents a practical, pragmatic, and mindset-focused approach to software architecture. This book is written by Robert C. Martin, an experienced software engineer and author known for his work on software design principles and practices.',NULL);
INSERT INTO "BOOK" VALUES (7,'Test Driven Development: By Example','Addison-Wesley Professional','November 18, 2002',1,240,'Test Driven Development: By Example is a book written by Kent Beck that explains test-driven development (TDD) concepts and practices. It is a practical guide to developing software using TDD and how to apply it effectively in real-world projects.',NULL);
INSERT INTO "BOOK" VALUES (8,'Effective Java','Addison-Wesley Professional','May 28, 2017',3,432,'Effective Java is a book written by Joshua Bloch, a Google Java software engineer. It presents 78 programming best practices and tips for writing better Java code. The book covers various topics such as Java language features, design patterns, concurrency, and performance optimization.',NULL);
INSERT INTO "BOOK" VALUES (9,'Code Complete: A Practical Handbook of Software Construction','Microsoft Press','June 9, 2004',2,960,'Code Complete: A Practical Handbook of Software Construction is a software development book, written by Steve McConnell and published in 1993 by Microsoft Press, encouraging developers to continue past code-and-fix programming and the big design up front and instead consider what the most appropriate design is to take.',NULL);
INSERT INTO "BOOK" VALUES (10,'Head First Design Patterns','O''Reilly Media','October 25, 2004',1,694,'Head First Design Patterns is a book by Elisabeth Robson and Eric Freeman, published in 2004. It presents design patterns in a unique and engaging way, making them easier to understand and remember. The book uses a combination of visual aids, humor, and practical examples to explain complex concepts.',NULL);
INSERT INTO "BOOK" VALUES (11,'Structure and Interpretation of Computer Programs','MIT Press','July 17, 1996',2,657,'Structure and Interpretation of Computer Programs is a textbook by Harold Abelson and Gerald Jay Sussman, published in 1984 and revised in 1996. It is known as the Wizard Book in hacker culture. It teaches fundamental principles of computer programming, including abstraction, recursion, and metacircular evaluation.',NULL);
INSERT INTO "BOOK" VALUES (12,'Cracking the Coding Interview: 189 Programming Questions and Solutions','CareerCup','July 1, 2015',6,687,'Cracking the Coding Interview: 189 Programming Questions and Solutions is a book by Gayle Laakmann McDowell about programming interviews. It contains hundreds of coding questions and answers, ranging from basic to advanced difficulty levels, to help programmers prepare for technical interviews at top technology companies.',NULL);
INSERT INTO "BOOK" VALUES (13,'Patterns of Enterprise Application Architecture','Addison-Wesley Professional','November 15, 2002',1,560,'Patterns of Enterprise Application Architecture is a book written by Martin Fowler, describing common design patterns for enterprise applications. The book covers patterns such as Data Source Architectural Patterns, Object-Relational Behavioral Patterns, Object-Relational Structural Patterns, and Object-Relational Metadata Mapping Patterns.',NULL);
INSERT INTO "BOOK" VALUES (14,'Introduction to Algorithms','The MIT Press','July 31, 2009',3,1312,'Introduction to Algorithms is a book on computer programming by Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, and Clifford Stein. The book has been widely used as the textbook for algorithms courses at many universities and is commonly cited as a reference in published papers.',NULL);
INSERT INTO "BOOK" VALUES (15,'Code: The Hidden Language of Computer Hardware and Software','Microsoft Press','October 21, 1999',1,400,'Code: The Hidden Language of Computer Hardware and Software is a book by Charles Petzold, published in 1999. It covers the history and inner workings of computers, explaining concepts such as binary code, logic gates, and machine language in an accessible way.',NULL);
INSERT INTO "BOOK" VALUES (16,'Designing Data-Intensive Applications: The Big Ideas Behind Reliable, Scalable, and Maintainable Systems','O''Reilly Media','April 2, 2017',1,616,'Designing Data-Intensive Applications is a book by Martin Kleppmann that explores the principles, techniques, and best practices for building scalable and reliable data systems. It covers a wide range of topics, including data modeling, storage engines, distributed systems, and fault tolerance.',NULL);
INSERT INTO "BOOK" VALUES (17,'Designing Interfaces: Patterns for Effective Interaction Design','O''Reilly Media','January 15, 2010',1,332,'Designing Interfaces: Patterns for Effective Interaction Design is a book by Jenifer Tidwell that provides an overview of user interface design patterns and best practices. It covers a wide range of topics, including navigation patterns, input controls, and layout strategies, with examples and practical advice for creating effective user interfaces.',NULL);
INSERT INTO "BOOK" VALUES (18,'Programming Pearls','Addison-Wesley Professional','October 14, 1999',2,256,'Programming Pearls is a book written by Jon Bentley, published in 1986 and reprinted in 1999. It presents a collection of programming problems and solutions, along with insights and techniques for writing clear, efficient, and elegant code.',NULL);
INSERT INTO "BOOK" VALUES (19,'The Mythical Man-Month: Essays on Software Engineering','Addison-Wesley Professional','August 12, 1995',2,322,'The Mythical Man-Month: Essays on Software Engineering is a book by Fred Brooks, published in 1975 and reprinted in 1995. It is a collection of essays on software engineering, discussing topics such as project management, scheduling, and team dynamics. The book is considered a classic in the field and is still widely read and referenced today.',NULL);
INSERT INTO "BOOK" VALUES (20,'Working Effectively with Legacy Code','Prentice Hall','October 14, 2004',1,456,'Working Effectively with Legacy Code is a book by Michael Feathers, published in 2004. It provides strategies and techniques for dealing with legacy codebases, including refactoring, testing, and dependency management. The book is aimed at software developers who need to maintain and improve existing code.',NULL);
INSERT INTO "BOOK" VALUES (21,'The Art of Computer Programming','Addison-Wesley Professional','January 10, 1998',4,3168,'The Art of Computer Programming is a multi-volume series of books by Donald Knuth, published in 1968 and still being actively revised and expanded. It covers a wide range of topics in computer science and mathematics, including algorithms, data structures, and combinatorial optimization.',NULL);
INSERT INTO "BOOK" VALUES (22,'Programming Interviews Exposed: Secrets to Landing Your Next Job','Wrox','July 5, 2012',3,336,'Programming Interviews Exposed: Secrets to Landing Your Next Job is a book by John Mongan, Noah Suojanen Kindler, and Eric Giguère, published in 2000. It provides practical advice and strategies for preparing for programming interviews, including coding exercises, problem-solving techniques, and communication skills.',NULL);
INSERT INTO "BOOK" VALUES (23,'The C Programming Language','Prentice Hall','April 1, 1988',2,288,'The C Programming Language is a book by Brian Kernighan and Dennis Ritchie, published in 1978 and reprinted in 1988. It is a concise and comprehensive guide to the C programming language, covering its syntax, semantics, and standard library.',NULL);
INSERT INTO "BOOK" VALUES (24,'Design Patterns Explained: A New Perspective on Object-Oriented Design','Addison-Wesley Professional','July 27, 2004',2,480,'Design Patterns Explained: A New Perspective on Object-Oriented Design is a book by Alan Shalloway, James R. Trott, and Scott Bain, published in 2001. It provides a comprehensive introduction to design patterns and their application in object-oriented design.',NULL);
INSERT INTO "BOOK" VALUES (25,'Effective C++: 55 Specific Ways to Improve Your Programs and Designs','Addison-Wesley Professional','May 22, 2005',3,320,'Effective C++: 55 Specific Ways to Improve Your Programs and Designs is a book by Scott Meyers, published in 1992 and revised in subsequent editions. It provides practical advice and best practices for writing efficient and maintainable C++ code.',NULL);
INSERT INTO "BOOK" VALUES (26,'Concurrency in Go: Tools and Techniques for Developers','O''Reilly Media','August 29, 2017',1,350,'Concurrency in Go: Tools and Techniques for Developers is a book by Katherine Cox-Buday, published in 2017. It provides an in-depth exploration of concurrency in the Go programming language, covering topics such as goroutines, channels, synchronization primitives, and patterns for concurrent programming.',NULL);
INSERT INTO "BOOK" VALUES (27,'Effective Python: 90 Specific Ways to Write Better Python','Addison-Wesley Professional','October 27, 2015',1,480,'Effective Python: 90 Specific Ways to Write Better Python is a book by Brett Slatkin, published in 2015. It provides practical advice and best practices for writing clear, idiomatic, and efficient Python code.',NULL);
INSERT INTO "BOOK" VALUES (28,'The Linux Programming Interface: A Linux and UNIX System Programming Handbook','No Starch Press','October 28, 2010',1,1552,'The Linux Programming Interface: A Linux and UNIX System Programming Handbook is a book by Michael Kerrisk, published in 2010. It provides a comprehensive guide to Linux system programming, covering topics such as file I/O, processes, threads, interprocess communication, and networking.',NULL);
INSERT INTO "BOOK" VALUES (29,'Eloquent JavaScript: A Modern Introduction to Programming','No Starch Press','December 14, 2014',3,472,'Eloquent JavaScript: A Modern Introduction to Programming is a book by Marijn Haverbeke, published in 2011 and revised in subsequent editions. It provides a comprehensive introduction to JavaScript programming, covering topics such as syntax, functions, objects, and asynchronous programming.',NULL);
INSERT INTO "BOOK" VALUES (30,'Computer Systems: A Programmer''s Perspective','Pearson','October 10, 2015',3,1072,'Computer Systems: A Programmer''s Perspective is a book by Randal E. Bryant and David R. O''Hallaron, published in 2003 and revised in subsequent editions. It provides a comprehensive introduction to computer systems, covering topics such as machine-level representation of data, processor architecture, memory hierarchy, and system-level I/O.',NULL);
INSERT INTO "CATEGORY" VALUES (1,'Fiction');
INSERT INTO "CATEGORY" VALUES (2,'Non-Fiction');
INSERT INTO "CATEGORY" VALUES (3,'Science Fiction');
INSERT INTO "CATEGORY" VALUES (4,'Fantasy');
INSERT INTO "CATEGORY" VALUES (5,'Mystery');
INSERT INTO "CATEGORY" VALUES (6,'Romance');
INSERT INTO "CATEGORY" VALUES (7,'Horror');
INSERT INTO "CATEGORY" VALUES (8,'Biography');
INSERT INTO "CATEGORY" VALUES (9,'Self-Help');
INSERT INTO "CATEGORY" VALUES (10,'History');
INSERT INTO "CATEGORY" VALUES (11,'Children');
INSERT INTO "CATEGORY" VALUES (12,'Young Adult');
INSERT INTO "CATEGORY" VALUES (13,'Thriller');
INSERT INTO "CATEGORY" VALUES (14,'Science');
INSERT INTO "CATEGORY" VALUES (15,'Poetry');
INSERT INTO "KEYWORD" VALUES (1,'clean');
INSERT INTO "KEYWORD" VALUES (2,'code');
INSERT INTO "KEYWORD" VALUES (3,'agile');
INSERT INTO "KEYWORD" VALUES (4,'software');
INSERT INTO "KEYWORD" VALUES (5,'craftsmanship');
INSERT INTO "KEYWORD" VALUES (6,'design');
INSERT INTO "KEYWORD" VALUES (7,'patterns');
INSERT INTO "KEYWORD" VALUES (8,'object-oriented');
INSERT INTO "KEYWORD" VALUES (9,'engineering');
INSERT INTO "KEYWORD" VALUES (10,'pragmatic');
INSERT INTO "KEYWORD" VALUES (11,'programmer');
INSERT INTO "KEYWORD" VALUES (12,'refactoring');
INSERT INTO "KEYWORD" VALUES (13,'existing');
INSERT INTO "KEYWORD" VALUES (14,'domain-driven');
INSERT INTO "KEYWORD" VALUES (15,'tackling');
INSERT INTO "KEYWORD" VALUES (16,'complexity');
INSERT INTO "KEYWORD" VALUES (17,'heart');
INSERT INTO "KEYWORD" VALUES (18,'architecture');
INSERT INTO "KEYWORD" VALUES (19,'structured');
INSERT INTO "KEYWORD" VALUES (20,'system');
INSERT INTO "KEYWORD" VALUES (21,'introduction');
INSERT INTO "KEYWORD" VALUES (22,'effective');
INSERT INTO "KEYWORD" VALUES (23,'java');
INSERT INTO "KEYWORD" VALUES (24,'complete');
INSERT INTO "KEYWORD" VALUES (25,'practical');
INSERT INTO "KEYWORD" VALUES (26,'handbook');
INSERT INTO "KEYWORD" VALUES (27,'programming');
INSERT INTO "KEYWORD" VALUES (28,'data');
INSERT INTO "KEYWORD" VALUES (29,'algorithms');
INSERT INTO "KEYWORD" VALUES (30,'hidden');
INSERT INTO "KEYWORD" VALUES (31,'language');
INSERT INTO "KEYWORD" VALUES (32,'hardware');
INSERT INTO "KEYWORD" VALUES (33,'interface');
INSERT INTO "KEYWORD" VALUES (34,'interaction');
INSERT INTO "KEYWORD" VALUES (35,'pearls');
INSERT INTO "KEYWORD" VALUES (36,'man-month');
INSERT INTO "KEYWORD" VALUES (37,'mythical');
INSERT INTO "KEYWORD" VALUES (38,'legacy');
INSERT INTO "KEYWORD" VALUES (39,'wizard');
INSERT INTO "KEYWORD" VALUES (40,'hacker');
INSERT INTO "KEYWORD" VALUES (41,'management');
INSERT INTO "KEYWORD" VALUES (42,'scheduling');
INSERT INTO "KEYWORD" VALUES (43,'team');
INSERT INTO "KEYWORD" VALUES (44,'dynamics');
INSERT INTO "KEYWORD" VALUES (45,'art');
INSERT INTO "KEYWORD" VALUES (46,'computing');
INSERT INTO "KEYWORD" VALUES (47,'programming');
INSERT INTO "KEYWORD" VALUES (48,'interviews');
INSERT INTO "KEYWORD" VALUES (49,'job');
INSERT INTO "KEYWORD" VALUES (50,'systems');
INSERT INTO "KEYWORD" VALUES (51,'perspective');
INSERT INTO "KEYWORD" VALUES (52,'coding');
INSERT INTO "KEYWORD" VALUES (53,'questions');
INSERT INTO "KEYWORD" VALUES (54,'solutions');
INSERT INTO "KEYWORD" VALUES (55,'enterprise');
INSERT INTO "KEYWORD" VALUES (56,'application');
INSERT INTO "KEYWORD" VALUES (57,'interface');
INSERT INTO "KEYWORD" VALUES (58,'metadata');
INSERT INTO "KEYWORD" VALUES (59,'mapping');
INSERT INTO "KEYWORD" VALUES (60,'structured');
INSERT INTO "KEYWORD" VALUES (61,'interpretation');
INSERT INTO "KEYWORD" VALUES (62,'modern');
INSERT INTO "KEYWORD" VALUES (63,'test');
INSERT INTO "KEYWORD" VALUES (64,'driven');
INSERT INTO "KEYWORD" VALUES (65,'example');
INSERT INTO "KEYWORD" VALUES (66,'concurrency');
INSERT INTO "KEYWORD" VALUES (67,'tools');
INSERT INTO "KEYWORD" VALUES (68,'techniques');
INSERT INTO "KEYWORD" VALUES (69,'go');
INSERT INTO "KEYWORD" VALUES (70,'python');
INSERT INTO "KEYWORD" VALUES (71,'linux');
INSERT INTO "KEYWORD" VALUES (72,'unix');
INSERT INTO "KEYWORD" VALUES (73,'javascript');
INSERT INTO "KEYWORD" VALUES (74,'computer');
INSERT INTO "KEYWORD" VALUES (75,'systems');
INSERT INTO "KEYWORD" VALUES (76,'system');
INSERT INTO "KEYWORD" VALUES (77,'programming');
INSERT INTO "KEYWORD" VALUES (78,'language');
INSERT INTO "KEYWORD" VALUES (79,'design');
INSERT INTO "KEYWORD" VALUES (80,'programming');
INSERT INTO "KEYWORD" VALUES (81,'principles');
INSERT INTO "KEYWORD" VALUES (82,'object-oriented');
INSERT INTO "KEYWORD" VALUES (83,'oriented');
INSERT INTO "KEYWORD" VALUES (84,'introduction');
INSERT INTO "KEYWORD" VALUES (85,'programming');
INSERT INTO "KEYWORD" VALUES (86,'languages');
INSERT INTO "KEYWORD" VALUES (87,'efficiency');
INSERT INTO "KEYWORD" VALUES (88,'maintainability');
INSERT INTO "KEYWORD" VALUES (89,'concurrency');
INSERT INTO "KEYWORD" VALUES (90,'systems');
INSERT INTO "KEYWORD" VALUES (91,'programming');
INSERT INTO "KEYWORD" VALUES (92,'programming');
INSERT INTO "KEYWORD" VALUES (93,'language');
INSERT INTO "KEYWORD" VALUES (94,'language');
INSERT INTO "KEYWORD" VALUES (95,'practical');
INSERT INTO "KEYWORD" VALUES (96,'programming');
INSERT INTO "KEYWORD" VALUES (97,'unix');
INSERT INTO "KEYWORD" VALUES (98,'linux');
INSERT INTO "KEYWORD" VALUES (99,'system');
INSERT INTO "KEYWORD" VALUES (100,'programming');
INSERT INTO "WRITES" VALUES (1,1);
INSERT INTO "WRITES" VALUES (2,2);
INSERT INTO "WRITES" VALUES (3,3);
INSERT INTO "WRITES" VALUES (4,4);
INSERT INTO "WRITES" VALUES (5,5);
INSERT INTO "WRITES" VALUES (6,6);
INSERT INTO "WRITES" VALUES (7,7);
INSERT INTO "WRITES" VALUES (8,8);
INSERT INTO "WRITES" VALUES (9,9);
INSERT INTO "WRITES" VALUES (10,10);
INSERT INTO "WRITES" VALUES (11,11);
INSERT INTO "WRITES" VALUES (12,12);
INSERT INTO "WRITES" VALUES (13,13);
INSERT INTO "WRITES" VALUES (14,14);
INSERT INTO "WRITES" VALUES (15,15);
INSERT INTO "WRITES" VALUES (16,16);
INSERT INTO "WRITES" VALUES (17,17);
INSERT INTO "WRITES" VALUES (18,18);
INSERT INTO "WRITES" VALUES (19,19);
INSERT INTO "WRITES" VALUES (20,20);
INSERT INTO "WRITES" VALUES (21,21);
INSERT INTO "WRITES" VALUES (22,22);
INSERT INTO "WRITES" VALUES (23,23);
INSERT INTO "WRITES" VALUES (24,24);
INSERT INTO "WRITES" VALUES (25,25);
INSERT INTO "WRITES" VALUES (26,26);
INSERT INTO "WRITES" VALUES (27,27);
INSERT INTO "WRITES" VALUES (28,28);
INSERT INTO "WRITES" VALUES (29,29);
INSERT INTO "WRITES" VALUES (30,30);
INSERT INTO "WRITES" VALUES (31,1);
INSERT INTO "WRITES" VALUES (32,2);
INSERT INTO "WRITES" VALUES (33,3);
INSERT INTO "WRITES" VALUES (34,4);
INSERT INTO "WRITES" VALUES (35,5);
INSERT INTO "WRITES" VALUES (36,6);
INSERT INTO "WRITES" VALUES (37,7);
INSERT INTO "WRITES" VALUES (38,8);
INSERT INTO "WRITES" VALUES (39,9);
INSERT INTO "WRITES" VALUES (40,10);
INSERT INTO "WRITES" VALUES (41,11);
INSERT INTO "WRITES" VALUES (42,12);
INSERT INTO "WRITES" VALUES (43,13);
INSERT INTO "WRITES" VALUES (44,14);
INSERT INTO "WRITES" VALUES (45,15);
INSERT INTO "WRITES" VALUES (46,16);
INSERT INTO "WRITES" VALUES (47,17);
INSERT INTO "WRITES" VALUES (48,18);
INSERT INTO "WRITES" VALUES (49,19);
INSERT INTO "WRITES" VALUES (50,20);
INSERT INTO "WRITES" VALUES (51,21);
INSERT INTO "WRITES" VALUES (52,22);
INSERT INTO "WRITES" VALUES (53,23);
INSERT INTO "WRITES" VALUES (54,24);
INSERT INTO "WRITES" VALUES (55,25);
INSERT INTO "WRITES" VALUES (56,26);
INSERT INTO "WRITES" VALUES (57,27);
INSERT INTO "WRITES" VALUES (58,28);
INSERT INTO "WRITES" VALUES (59,29);
INSERT INTO "WRITES" VALUES (60,30);
INSERT INTO "WRITES" VALUES (61,1);
INSERT INTO "WRITES" VALUES (62,2);
INSERT INTO "WRITES" VALUES (63,3);
INSERT INTO "WRITES" VALUES (64,4);
INSERT INTO "WRITES" VALUES (65,5);
INSERT INTO "WRITES" VALUES (66,6);
INSERT INTO "WRITES" VALUES (67,7);
INSERT INTO "WRITES" VALUES (68,8);
INSERT INTO "WRITES" VALUES (69,9);
INSERT INTO "WRITES" VALUES (70,10);
INSERT INTO "WRITES" VALUES (71,11);
INSERT INTO "WRITES" VALUES (72,12);
INSERT INTO "WRITES" VALUES (73,13);
INSERT INTO "WRITES" VALUES (74,14);
INSERT INTO "WRITES" VALUES (75,15);
INSERT INTO "WRITES" VALUES (76,16);
INSERT INTO "WRITES" VALUES (77,17);
INSERT INTO "WRITES" VALUES (78,18);
INSERT INTO "WRITES" VALUES (79,19);
INSERT INTO "WRITES" VALUES (80,20);
INSERT INTO "WRITES" VALUES (81,21);
INSERT INTO "WRITES" VALUES (82,22);
INSERT INTO "WRITES" VALUES (83,23);
INSERT INTO "WRITES" VALUES (84,24);
INSERT INTO "WRITES" VALUES (85,25);
INSERT INTO "WRITES" VALUES (86,26);
INSERT INTO "WRITES" VALUES (87,27);
INSERT INTO "WRITES" VALUES (88,28);
INSERT INTO "WRITES" VALUES (89,29);
INSERT INTO "WRITES" VALUES (90,30);
INSERT INTO "WRITES" VALUES (91,1);
INSERT INTO "WRITES" VALUES (92,2);
INSERT INTO "WRITES" VALUES (93,3);
INSERT INTO "WRITES" VALUES (94,4);
INSERT INTO "WRITES" VALUES (95,5);
INSERT INTO "WRITES" VALUES (96,6);
INSERT INTO "WRITES" VALUES (97,7);
INSERT INTO "WRITES" VALUES (98,8);
INSERT INTO "WRITES" VALUES (99,9);
INSERT INTO "WRITES" VALUES (100,10);
INSERT INTO "BELONGS_TO" VALUES (1,3);
INSERT INTO "BELONGS_TO" VALUES (2,5);
INSERT INTO "BELONGS_TO" VALUES (3,7);
INSERT INTO "BELONGS_TO" VALUES (4,9);
INSERT INTO "BELONGS_TO" VALUES (5,11);
INSERT INTO "BELONGS_TO" VALUES (6,13);
INSERT INTO "BELONGS_TO" VALUES (7,15);
INSERT INTO "BELONGS_TO" VALUES (8,2);
INSERT INTO "BELONGS_TO" VALUES (9,4);
INSERT INTO "BELONGS_TO" VALUES (10,6);
INSERT INTO "BELONGS_TO" VALUES (11,8);
INSERT INTO "BELONGS_TO" VALUES (12,10);
INSERT INTO "BELONGS_TO" VALUES (13,12);
INSERT INTO "BELONGS_TO" VALUES (14,14);
INSERT INTO "BELONGS_TO" VALUES (15,1);
INSERT INTO "BELONGS_TO" VALUES (16,3);
INSERT INTO "BELONGS_TO" VALUES (17,5);
INSERT INTO "BELONGS_TO" VALUES (18,7);
INSERT INTO "BELONGS_TO" VALUES (19,9);
INSERT INTO "BELONGS_TO" VALUES (20,11);
INSERT INTO "BELONGS_TO" VALUES (21,13);
INSERT INTO "BELONGS_TO" VALUES (22,15);
INSERT INTO "BELONGS_TO" VALUES (23,2);
INSERT INTO "BELONGS_TO" VALUES (24,4);
INSERT INTO "BELONGS_TO" VALUES (25,6);
INSERT INTO "BELONGS_TO" VALUES (26,8);
INSERT INTO "BELONGS_TO" VALUES (27,10);
INSERT INTO "BELONGS_TO" VALUES (28,12);
INSERT INTO "BELONGS_TO" VALUES (29,14);
INSERT INTO "BELONGS_TO" VALUES (30,1);
INSERT INTO "INCLUDES" VALUES (1,5);
INSERT INTO "INCLUDES" VALUES (1,10);
INSERT INTO "INCLUDES" VALUES (1,15);
INSERT INTO "INCLUDES" VALUES (2,20);
INSERT INTO "INCLUDES" VALUES (2,25);
INSERT INTO "INCLUDES" VALUES (2,30);
INSERT INTO "INCLUDES" VALUES (3,35);
INSERT INTO "INCLUDES" VALUES (3,40);
INSERT INTO "INCLUDES" VALUES (3,45);
INSERT INTO "INCLUDES" VALUES (4,50);
INSERT INTO "INCLUDES" VALUES (4,55);
INSERT INTO "INCLUDES" VALUES (4,60);
INSERT INTO "INCLUDES" VALUES (5,65);
INSERT INTO "INCLUDES" VALUES (5,70);
INSERT INTO "INCLUDES" VALUES (5,75);
INSERT INTO "INCLUDES" VALUES (6,80);
INSERT INTO "INCLUDES" VALUES (6,85);
INSERT INTO "INCLUDES" VALUES (6,90);
INSERT INTO "INCLUDES" VALUES (7,95);
INSERT INTO "INCLUDES" VALUES (7,100);
INSERT INTO "INCLUDES" VALUES (7,4);
INSERT INTO "INCLUDES" VALUES (8,9);
INSERT INTO "INCLUDES" VALUES (8,14);
INSERT INTO "INCLUDES" VALUES (8,19);
INSERT INTO "INCLUDES" VALUES (9,24);
INSERT INTO "INCLUDES" VALUES (9,29);
INSERT INTO "INCLUDES" VALUES (9,34);
INSERT INTO "INCLUDES" VALUES (10,39);
INSERT INTO "INCLUDES" VALUES (10,44);
INSERT INTO "INCLUDES" VALUES (10,49);
INSERT INTO "INCLUDES" VALUES (11,54);
INSERT INTO "INCLUDES" VALUES (11,59);
INSERT INTO "INCLUDES" VALUES (11,64);
INSERT INTO "INCLUDES" VALUES (12,69);
INSERT INTO "INCLUDES" VALUES (12,74);
INSERT INTO "INCLUDES" VALUES (12,79);
INSERT INTO "INCLUDES" VALUES (13,84);
INSERT INTO "INCLUDES" VALUES (13,89);
INSERT INTO "INCLUDES" VALUES (13,94);
INSERT INTO "INCLUDES" VALUES (14,3);
INSERT INTO "INCLUDES" VALUES (14,8);
INSERT INTO "INCLUDES" VALUES (14,13);
INSERT INTO "INCLUDES" VALUES (15,18);
INSERT INTO "INCLUDES" VALUES (15,23);
INSERT INTO "INCLUDES" VALUES (15,28);
INSERT INTO "INCLUDES" VALUES (16,33);
INSERT INTO "INCLUDES" VALUES (16,38);
INSERT INTO "INCLUDES" VALUES (16,43);
INSERT INTO "INCLUDES" VALUES (17,48);
INSERT INTO "INCLUDES" VALUES (17,53);
INSERT INTO "INCLUDES" VALUES (17,58);
INSERT INTO "INCLUDES" VALUES (18,63);
INSERT INTO "INCLUDES" VALUES (18,68);
INSERT INTO "INCLUDES" VALUES (18,73);
INSERT INTO "INCLUDES" VALUES (19,78);
INSERT INTO "INCLUDES" VALUES (19,83);
INSERT INTO "INCLUDES" VALUES (19,88);
INSERT INTO "INCLUDES" VALUES (20,93);
INSERT INTO "INCLUDES" VALUES (20,2);
INSERT INTO "INCLUDES" VALUES (20,7);
INSERT INTO "INCLUDES" VALUES (21,12);
INSERT INTO "INCLUDES" VALUES (21,17);
INSERT INTO "INCLUDES" VALUES (21,22);
INSERT INTO "INCLUDES" VALUES (22,27);
INSERT INTO "INCLUDES" VALUES (22,32);
INSERT INTO "INCLUDES" VALUES (22,37);
INSERT INTO "INCLUDES" VALUES (23,42);
INSERT INTO "INCLUDES" VALUES (23,47);
INSERT INTO "INCLUDES" VALUES (23,52);
INSERT INTO "INCLUDES" VALUES (24,57);
INSERT INTO "INCLUDES" VALUES (24,62);
INSERT INTO "INCLUDES" VALUES (24,67);
INSERT INTO "INCLUDES" VALUES (25,72);
INSERT INTO "INCLUDES" VALUES (25,77);
INSERT INTO "INCLUDES" VALUES (25,82);
INSERT INTO "INCLUDES" VALUES (26,87);
INSERT INTO "INCLUDES" VALUES (26,92);
INSERT INTO "INCLUDES" VALUES (26,1);
INSERT INTO "INCLUDES" VALUES (27,6);
INSERT INTO "INCLUDES" VALUES (27,11);
INSERT INTO "INCLUDES" VALUES (27,16);
INSERT INTO "INCLUDES" VALUES (28,21);
INSERT INTO "INCLUDES" VALUES (28,26);
INSERT INTO "INCLUDES" VALUES (28,31);
INSERT INTO "INCLUDES" VALUES (29,36);
INSERT INTO "INCLUDES" VALUES (29,41);
INSERT INTO "INCLUDES" VALUES (29,46);
INSERT INTO "INCLUDES" VALUES (30,51);
INSERT INTO "INCLUDES" VALUES (30,56);
INSERT INTO "INCLUDES" VALUES (30,61);
INSERT INTO "REVIEW" VALUES (1,4,1,'Great book, highly recommended!');
INSERT INTO "REVIEW" VALUES (2,5,2,'Excellent read, very informative.');
INSERT INTO "REVIEW" VALUES (3,3,3,'Average book, could be better.');
INSERT INTO "REVIEW" VALUES (4,4,4,'Enjoyable book, learned a lot.');
INSERT INTO "REVIEW" VALUES (5,2,5,'Disappointing, not what I expected.');
INSERT INTO "REVIEW" VALUES (6,4,6,'Well-written and engaging.');
INSERT INTO "REVIEW" VALUES (7,5,7,'One of the best books I''ve read!');
INSERT INTO "REVIEW" VALUES (8,3,8,'Decent book, but a bit repetitive.');
INSERT INTO "REVIEW" VALUES (9,4,9,'Good overview of the topic.');
INSERT INTO "REVIEW" VALUES (10,5,10,'Incredible book, couldn''t put it down.');
INSERT INTO "REVIEW" VALUES (11,4,11,'Fascinating insights, highly recommended.');
INSERT INTO "REVIEW" VALUES (12,3,12,'Interesting read, but a bit dry.');
INSERT INTO "REVIEW" VALUES (13,5,13,'Absolutely loved it, a must-read.');
INSERT INTO "REVIEW" VALUES (14,2,14,'Struggled to get through it, not my cup of tea.');
INSERT INTO "REVIEW" VALUES (15,4,15,'Informative and well-researched.');
INSERT INTO "REVIEW" VALUES (16,5,16,'Life-changing book, highly impactful.');
INSERT INTO "REVIEW" VALUES (17,3,17,'Okay read, but nothing special.');
INSERT INTO "REVIEW" VALUES (18,4,18,'Enjoyed the book overall, worth reading.');
INSERT INTO "REVIEW" VALUES (19,5,19,'A masterpiece, beautifully written.');
INSERT INTO "REVIEW" VALUES (20,4,20,'Insightful and thought-provoking.');
INSERT INTO "REVIEW" VALUES (21,3,21,'Good book, but a bit long-winded.');
INSERT INTO "REVIEW" VALUES (22,4,22,'Captivating story, couldn''t stop reading.');
INSERT INTO "REVIEW" VALUES (23,5,23,'Must-read for anyone interested in the topic.');
INSERT INTO "REVIEW" VALUES (24,2,24,'Didn''t live up to the hype, disappointed.');
INSERT INTO "REVIEW" VALUES (25,4,25,'Well-organized and informative.');
INSERT INTO "REVIEW" VALUES (26,5,26,'Couldn''t recommend it enough, a must-read.');
INSERT INTO "REVIEW" VALUES (27,3,27,'Decent book, but not groundbreaking.');
INSERT INTO "REVIEW" VALUES (28,4,28,'Enjoyed the author''s writing style.');
INSERT INTO "REVIEW" VALUES (29,5,29,'Absolutely fantastic, exceeded my expectations.');
INSERT INTO "REVIEW" VALUES (30,4,30,'Thought-provoking and insightful.');
INSERT INTO "MAKES" VALUES (1,1,'2024-05-14');
INSERT INTO "MAKES" VALUES (2,2,'2024-05-14');
INSERT INTO "MAKES" VALUES (3,3,'2024-05-14');
INSERT INTO "MAKES" VALUES (4,4,'2024-05-14');
INSERT INTO "MAKES" VALUES (5,5,'2024-05-14');
INSERT INTO "MAKES" VALUES (6,6,'2024-05-14');
INSERT INTO "MAKES" VALUES (7,7,'2024-05-14');
INSERT INTO "MAKES" VALUES (8,8,'2024-05-14');
INSERT INTO "MAKES" VALUES (9,9,'2024-05-14');
INSERT INTO "MAKES" VALUES (10,10,'2024-05-14');
INSERT INTO "MAKES" VALUES (11,11,'2024-05-14');
INSERT INTO "MAKES" VALUES (12,12,'2024-05-14');
INSERT INTO "MAKES" VALUES (13,13,'2024-05-14');
INSERT INTO "MAKES" VALUES (14,14,'2024-05-14');
INSERT INTO "MAKES" VALUES (15,15,'2024-05-14');
INSERT INTO "MAKES" VALUES (16,16,'2024-05-14');
INSERT INTO "MAKES" VALUES (17,17,'2024-05-14');
INSERT INTO "MAKES" VALUES (18,18,'2024-05-14');
INSERT INTO "MAKES" VALUES (19,19,'2024-05-14');
INSERT INTO "MAKES" VALUES (20,20,'2024-05-14');
INSERT INTO "MAKES" VALUES (21,21,'2024-05-14');
INSERT INTO "MAKES" VALUES (22,22,'2024-05-14');
INSERT INTO "MAKES" VALUES (23,23,'2024-05-14');
INSERT INTO "MAKES" VALUES (24,24,'2024-05-14');
INSERT INTO "MAKES" VALUES (25,25,'2024-05-14');
INSERT INTO "MAKES" VALUES (26,26,'2024-05-14');
INSERT INTO "MAKES" VALUES (27,27,'2024-05-14');
INSERT INTO "MAKES" VALUES (28,28,'2024-05-14');
INSERT INTO "MAKES" VALUES (29,29,'2024-05-14');
INSERT INTO "MAKES" VALUES (30,30,'2024-05-14');
INSERT INTO "APPLIES_FOR" VALUES (1,5,'2024-01-15');
INSERT INTO "APPLIES_FOR" VALUES (2,10,'2024-02-20');
INSERT INTO "APPLIES_FOR" VALUES (3,15,'2024-03-25');
INSERT INTO "APPLIES_FOR" VALUES (4,20,'2024-04-10');
INSERT INTO "APPLIES_FOR" VALUES (5,25,'2024-05-05');
INSERT INTO "APPLIES_FOR" VALUES (6,30,'2024-06-18');
INSERT INTO "APPLIES_FOR" VALUES (7,1,'2024-07-22');
INSERT INTO "APPLIES_FOR" VALUES (8,6,'2024-08-11');
INSERT INTO "APPLIES_FOR" VALUES (9,11,'2024-09-14');
INSERT INTO "APPLIES_FOR" VALUES (10,16,'2024-10-19');
INSERT INTO "APPLIES_FOR" VALUES (11,21,'2024-11-23');
INSERT INTO "APPLIES_FOR" VALUES (12,26,'2024-12-28');
INSERT INTO "APPLIES_FOR" VALUES (13,2,'2024-01-02');
INSERT INTO "APPLIES_FOR" VALUES (14,7,'2024-02-15');
INSERT INTO "APPLIES_FOR" VALUES (15,12,'2024-03-18');
INSERT INTO "APPLIES_FOR" VALUES (16,17,'2024-04-25');
INSERT INTO "APPLIES_FOR" VALUES (17,22,'2024-05-10');
INSERT INTO "APPLIES_FOR" VALUES (18,27,'2024-06-14');
INSERT INTO "APPLIES_FOR" VALUES (19,3,'2024-07-19');
INSERT INTO "APPLIES_FOR" VALUES (20,8,'2024-08-23');
INSERT INTO "APPLIES_FOR" VALUES (21,13,'2024-09-27');
INSERT INTO "APPLIES_FOR" VALUES (22,18,'2024-10-30');
INSERT INTO "APPLIES_FOR" VALUES (23,23,'2024-11-04');
INSERT INTO "APPLIES_FOR" VALUES (24,28,'2024-12-08');
INSERT INTO "APPLIES_FOR" VALUES (25,4,'2024-01-12');
INSERT INTO "APPLIES_FOR" VALUES (26,9,'2024-02-18');
INSERT INTO "APPLIES_FOR" VALUES (27,14,'2024-03-22');
INSERT INTO "APPLIES_FOR" VALUES (28,19,'2024-04-27');
INSERT INTO "APPLIES_FOR" VALUES (29,24,'2024-05-09');
INSERT INTO "APPLIES_FOR" VALUES (30,29,'2024-06-13');
INSERT INTO "APPLIES_FOR" VALUES (31,5,'2024-07-16');
INSERT INTO "APPLIES_FOR" VALUES (32,10,'2024-08-21');
INSERT INTO "APPLIES_FOR" VALUES (33,15,'2024-09-25');
INSERT INTO "APPLIES_FOR" VALUES (34,20,'2024-10-28');
INSERT INTO "APPLIES_FOR" VALUES (35,25,'2024-11-30');
INSERT INTO "APPLIES_FOR" VALUES (36,30,'2024-12-03');
INSERT INTO "APPLIES_FOR" VALUES (37,1,'2024-01-04');
INSERT INTO "APPLIES_FOR" VALUES (38,6,'2024-02-08');
INSERT INTO "APPLIES_FOR" VALUES (39,11,'2024-03-11');
INSERT INTO "APPLIES_FOR" VALUES (40,16,'2024-04-14');
INSERT INTO "APPLIES_FOR" VALUES (41,21,'2024-05-16');
INSERT INTO "APPLIES_FOR" VALUES (42,26,'2024-06-19');
INSERT INTO "APPLIES_FOR" VALUES (43,2,'2024-07-22');
INSERT INTO "APPLIES_FOR" VALUES (44,7,'2024-08-25');
INSERT INTO "APPLIES_FOR" VALUES (45,12,'2024-09-28');
INSERT INTO "APPLIES_FOR" VALUES (46,17,'2024-10-31');
INSERT INTO "APPLIES_FOR" VALUES (47,22,'2024-11-02');
INSERT INTO "APPLIES_FOR" VALUES (48,27,'2024-12-05');
INSERT INTO "APPLIES_FOR" VALUES (49,3,'2024-01-07');
INSERT INTO "APPLIES_FOR" VALUES (50,8,'2024-02-11');
INSERT INTO "APPLIES_FOR" VALUES (1,13,'2024-03-15');
INSERT INTO "APPLIES_FOR" VALUES (2,18,'2024-04-18');
INSERT INTO "APPLIES_FOR" VALUES (3,23,'2024-05-20');
INSERT INTO "APPLIES_FOR" VALUES (4,28,'2024-06-23');
INSERT INTO "APPLIES_FOR" VALUES (5,4,'2024-07-26');
INSERT INTO "APPLIES_FOR" VALUES (6,9,'2024-08-29');
INSERT INTO "APPLIES_FOR" VALUES (7,14,'2024-09-03');
INSERT INTO "APPLIES_FOR" VALUES (8,19,'2024-10-06');
INSERT INTO "APPLIES_FOR" VALUES (9,24,'2024-11-09');
INSERT INTO "APPLIES_FOR" VALUES (10,29,'2024-12-12');
INSERT INTO "COPY" VALUES (1,1);
INSERT INTO "COPY" VALUES (2,2);
INSERT INTO "COPY" VALUES (3,3);
INSERT INTO "COPY" VALUES (4,4);
INSERT INTO "COPY" VALUES (5,5);
INSERT INTO "COPY" VALUES (6,6);
INSERT INTO "COPY" VALUES (7,7);
INSERT INTO "COPY" VALUES (8,8);
INSERT INTO "COPY" VALUES (9,9);
INSERT INTO "COPY" VALUES (10,10);
INSERT INTO "COPY" VALUES (11,11);
INSERT INTO "COPY" VALUES (12,12);
INSERT INTO "COPY" VALUES (13,13);
INSERT INTO "COPY" VALUES (14,14);
INSERT INTO "COPY" VALUES (15,15);
INSERT INTO "COPY" VALUES (16,16);
INSERT INTO "COPY" VALUES (17,17);
INSERT INTO "COPY" VALUES (18,18);
INSERT INTO "COPY" VALUES (19,19);
INSERT INTO "COPY" VALUES (20,20);
INSERT INTO "COPY" VALUES (21,21);
INSERT INTO "COPY" VALUES (22,22);
INSERT INTO "COPY" VALUES (23,23);
INSERT INTO "COPY" VALUES (24,24);
INSERT INTO "COPY" VALUES (25,25);
INSERT INTO "COPY" VALUES (26,26);
INSERT INTO "COPY" VALUES (27,27);
INSERT INTO "COPY" VALUES (28,28);
INSERT INTO "COPY" VALUES (29,29);
INSERT INTO "COPY" VALUES (30,30);
INSERT INTO "COPY" VALUES (31,1);
INSERT INTO "COPY" VALUES (32,2);
INSERT INTO "COPY" VALUES (33,3);
INSERT INTO "COPY" VALUES (34,4);
INSERT INTO "COPY" VALUES (35,5);
INSERT INTO "COPY" VALUES (36,6);
INSERT INTO "COPY" VALUES (37,7);
INSERT INTO "COPY" VALUES (38,8);
INSERT INTO "COPY" VALUES (39,9);
INSERT INTO "COPY" VALUES (40,10);
INSERT INTO "COPY" VALUES (41,11);
INSERT INTO "COPY" VALUES (42,12);
INSERT INTO "COPY" VALUES (43,13);
INSERT INTO "COPY" VALUES (44,14);
INSERT INTO "COPY" VALUES (45,15);
INSERT INTO "COPY" VALUES (46,16);
INSERT INTO "COPY" VALUES (47,17);
INSERT INTO "COPY" VALUES (48,18);
INSERT INTO "COPY" VALUES (49,19);
INSERT INTO "COPY" VALUES (50,20);
INSERT INTO "COPY" VALUES (51,21);
INSERT INTO "COPY" VALUES (52,22);
INSERT INTO "COPY" VALUES (53,23);
INSERT INTO "COPY" VALUES (54,24);
INSERT INTO "COPY" VALUES (55,25);
INSERT INTO "COPY" VALUES (56,26);
INSERT INTO "COPY" VALUES (57,27);
INSERT INTO "COPY" VALUES (58,28);
INSERT INTO "COPY" VALUES (59,29);
INSERT INTO "COPY" VALUES (60,30);
INSERT INTO "COPY" VALUES (61,1);
INSERT INTO "COPY" VALUES (62,2);
INSERT INTO "COPY" VALUES (63,3);
INSERT INTO "COPY" VALUES (64,4);
INSERT INTO "COPY" VALUES (65,5);
INSERT INTO "COPY" VALUES (66,6);
INSERT INTO "COPY" VALUES (67,7);
INSERT INTO "COPY" VALUES (68,8);
INSERT INTO "COPY" VALUES (69,9);
INSERT INTO "COPY" VALUES (70,10);
INSERT INTO "COPY" VALUES (71,11);
INSERT INTO "COPY" VALUES (72,12);
INSERT INTO "COPY" VALUES (73,13);
INSERT INTO "COPY" VALUES (74,14);
INSERT INTO "COPY" VALUES (75,15);
INSERT INTO "COPY" VALUES (76,16);
INSERT INTO "COPY" VALUES (77,17);
INSERT INTO "COPY" VALUES (78,18);
INSERT INTO "COPY" VALUES (79,19);
INSERT INTO "COPY" VALUES (80,20);
INSERT INTO "COPY" VALUES (81,21);
INSERT INTO "COPY" VALUES (82,22);
INSERT INTO "COPY" VALUES (83,23);
INSERT INTO "COPY" VALUES (84,24);
INSERT INTO "COPY" VALUES (85,25);
INSERT INTO "COPY" VALUES (86,26);
INSERT INTO "COPY" VALUES (87,27);
INSERT INTO "COPY" VALUES (88,28);
INSERT INTO "COPY" VALUES (89,29);
INSERT INTO "COPY" VALUES (90,30);
INSERT INTO "COPY" VALUES (91,1);
INSERT INTO "COPY" VALUES (92,2);
INSERT INTO "COPY" VALUES (93,3);
INSERT INTO "COPY" VALUES (94,4);
INSERT INTO "COPY" VALUES (95,5);
INSERT INTO "COPY" VALUES (96,6);
INSERT INTO "COPY" VALUES (97,7);
INSERT INTO "COPY" VALUES (98,8);
INSERT INTO "COPY" VALUES (99,9);
INSERT INTO "COPY" VALUES (100,10);
INSERT INTO "USER" VALUES (1,'john.doe@example.com','password123','John','Doe','123-456-7890',0);
INSERT INTO "USER" VALUES (2,'jane.smith@example.com','letmein','Jane','Smith','987-654-3210',0);
INSERT INTO "USER" VALUES (3,'mike.jackson@example.com','mypass','Mike','Jackson','555-123-4567',1);
INSERT INTO "USER" VALUES (4,'sarah.johnson@example.com','password','Sarah','Johnson','111-222-3333',0);
INSERT INTO "USER" VALUES (5,'chris.brown@example.com','pass123','Chris','Brown','444-555-6666',1);
INSERT INTO "USER" VALUES (6,'amanda.wilson@example.com','123456','Amanda','Wilson','777-888-9999',0);
INSERT INTO "USER" VALUES (7,'alex.miller@example.com','password1234','Alex','Miller','222-333-4444',0);
INSERT INTO "USER" VALUES (8,'emily.thompson@example.com','password12345','Emily','Thompson','999-888-7777',0);
INSERT INTO "USER" VALUES (9,'matt.davis@example.com','123456789','Matt','Davis','111-222-3333',1);
INSERT INTO "USER" VALUES (10,'laura.clark@example.com','letmein123','Laura','Clark','444-555-6666',0);
INSERT INTO "USER" VALUES (11,'ryan.taylor@example.com','password','Ryan','Taylor','777-888-9999',1);
INSERT INTO "USER" VALUES (12,'samantha.anderson@example.com','abc123','Samantha','Anderson','555-666-7777',0);
INSERT INTO "USER" VALUES (13,'kevin.thomas@example.com','qwerty','Kevin','Thomas','333-444-5555',0);
INSERT INTO "USER" VALUES (14,'jessica.walker@example.com','password123','Jessica','Walker','888-999-0000',1);
INSERT INTO "USER" VALUES (15,'david.wright@example.com','pass123','David','Wright','222-333-4444',0);
INSERT INTO "USER" VALUES (16,'ashley.evans@example.com','letmein1234','Ashley','Evans','666-777-8888',0);
INSERT INTO "USER" VALUES (17,'joshua.rodriguez@example.com','password','Joshua','Rodriguez','333-444-5555',1);
INSERT INTO "USER" VALUES (18,'katie.martinez@example.com','123456','Katie','Martinez','999-888-7777',0);
INSERT INTO "USER" VALUES (19,'justin.hernandez@example.com','password1234','Justin','Hernandez','777-666-5555',0);
INSERT INTO "USER" VALUES (20,'brittany.hall@example.com','password12345','Brittany','Hall','111-222-3333',0);
INSERT INTO "USER" VALUES (21,'stephen.nelson@example.com','123456789','Stephen','Nelson','444-555-6666',1);
INSERT INTO "USER" VALUES (22,'olivia.adams@example.com','letmein123','Olivia','Adams','777-888-9999',0);
INSERT INTO "USER" VALUES (23,'jacob.baker@example.com','abc123','Jacob','Baker','555-666-7777',0);
INSERT INTO "USER" VALUES (24,'lauren.gonzalez@example.com','qwerty','Lauren','Gonzalez','333-444-5555',0);
INSERT INTO "USER" VALUES (25,'tyler.russell@example.com','password123','Tyler','Russell','888-999-0000',1);
INSERT INTO "USER" VALUES (26,'rachel.stewart@example.com','pass123','Rachel','Stewart','222-333-4444',0);
INSERT INTO "USER" VALUES (27,'brandon.gomez@example.com','letmein1234','Brandon','Gomez','666-777-8888',0);
INSERT INTO "USER" VALUES (28,'alyssa.diaz@example.com','password','Alyssa','Diaz','333-444-5555',1);
INSERT INTO "USER" VALUES (29,'jesse.cruz@example.com','123456','Jesse','Cruz','999-888-7777',0);
INSERT INTO "USER" VALUES (30,'natalie.rivera@example.com','password1234','Natalie','Rivera','777-666-5555',0);
INSERT INTO "USER" VALUES (31,'cameron.howard@example.com','password12345','Cameron','Howard','111-222-3333',0);
INSERT INTO "USER" VALUES (32,'maria.ward@example.com','123456789','Maria','Ward','444-555-6666',1);
INSERT INTO "USER" VALUES (33,'jesse.hamilton@example.com','letmein123','Jesse','Hamilton','777-888-9999',0);
INSERT INTO "USER" VALUES (34,'megan.perez@example.com','abc123','Megan','Perez','555-666-7777',0);
INSERT INTO "USER" VALUES (35,'nathan.wood@example.com','qwerty','Nathan','Wood','333-444-5555',0);
INSERT INTO "USER" VALUES (36,'victoria.brooks@example.com','password123','Victoria','Brooks','888-999-0000',1);
INSERT INTO "USER" VALUES (37,'daniel.bailey@example.com','pass123','Daniel','Bailey','222-333-4444',0);
INSERT INTO "USER" VALUES (38,'rebecca.long@example.com','letmein1234','Rebecca','Long','666-777-8888',0);
INSERT INTO "USER" VALUES (39,'gary.foster@example.com','password','Gary','Foster','333-444-5555',1);
INSERT INTO "USER" VALUES (40,'lindsay.russell@example.com','123456','Lindsay','Russell','999-888-7777',0);
INSERT INTO "USER" VALUES (41,'peter.gomez@example.com','password1234','Peter','Gomez','777-666-5555',0);
INSERT INTO "USER" VALUES (42,'rachel.ramirez@example.com','password12345','Rachel','Ramirez','111-222-3333',0);
INSERT INTO "USER" VALUES (43,'jacob.ward@example.com','123456789','Jacob','Ward','444-555-6666',1);
INSERT INTO "USER" VALUES (44,'jenna.hamilton@example.com','letmein123','Jenna','Hamilton','777-888-9999',0);
INSERT INTO "USER" VALUES (45,'brandon.perez@example.com','abc123','Brandon','Perez','555-666-7777',0);
INSERT INTO "USER" VALUES (46,'maria.rivera@example.com','qwerty','Maria','Rivera','333-444-5555',0);
INSERT INTO "USER" VALUES (47,'matthew.brooks@example.com','password123','Matthew','Brooks','888-999-0000',1);
INSERT INTO "USER" VALUES (48,'kelsey.bailey@example.com','pass123','Kelsey','Bailey','222-333-4444',0);
INSERT INTO "USER" VALUES (49,'ryan.long@example.com','letmein1234','Ryan','Long','666-777-8888',0);
INSERT INTO "USER" VALUES (50,'natalie.foster@example.com','password','Natalie','Foster','333-444-5555',1);
COMMIT;
