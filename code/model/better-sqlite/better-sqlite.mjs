'use strict';
import db from 'better-sqlite3';
import bcrypt from 'bcrypt'

const sql = new db('C:/Users/renia/Desktop/University/8/Προγραμματισμός Διαδικτύου/project/webdev-library/code/model/db/library_db.db', {fileMustExist: true});


//Επιστρέφει τον χρήστη με email
export let getUserByEmail = (email) => {
    const stmt =  sql.prepare("SELECT id, email, hashpass FROM USER WHERE email = ? LIMIT 0, 1");
    try {
        const user = stmt.all(email);
        return user[0];
    } catch (err) {
        throw err;
    }
}

//eisagei neo xristi sti vasi
export let insertUser = (email, password, firstName, lastName, phone) => {
    // ελέγχουμε αν υπάρχει χρήστης με αυτό το username
    const user =  getUserByEmail(email);
    if (user != undefined) {
        //return { message: "Υπάρχει ήδη χρήστης με αυτό το όνομα" };
        throw new Error('Υπάρχει ήδη χρήστης με αυτό το email');
    } 
    else {
    try {
        const hashedPassword =  bcrypt.hash(password, 10);
        const stmt =  sql.prepare('INSERT INTO USER VALUES (null, ?, ?, ?, ?, ?,0)');
        const info =  stmt.run(email, password, firstName, lastName, phone);
        return info.lastID;
    } catch (error) {
        throw error;
    }
    }
    //UNIQUE CONSTRAINT!!!!!!!!!!!!
}

//vriskei id xristi apo ti vasi epistrefei id
export let findUser = (email, password) => {
    //Φέρε μόνο μια εγγραφή (το LIMIT 0, 1) που να έχει username και password ίσο με username και password 
    const stmt =  sql.prepare("SELECT id FROM USER WHERE email = ? and hashpass = ? LIMIT 0, 1");
    try {
        const user =  stmt.all(email, password);
        return user[0];
    } catch (err) {
        throw err;
    }
}

export let findBooks =  (searchInput) => {
    // ανάκτηση των βιβλίων αναλογα την αναζητηση
    const sql = `
    SELECT DISTINCT BOOK.ISBN, CATEGORY.name, BOOK.image_id, BOOK.title, AUTHOR.firstName, AUTHOR.lastName 
    FROM BOOK
    LEFT JOIN WRITES ON BOOK.ISBN = WRITES.ISBN_book
    LEFT JOIN AUTHOR ON WRITES.id_author = AUTHOR.id
    LEFT JOIN INCLUDES ON BOOK.ISBN = INCLUDES.ISBN_book
    LEFT JOIN KEYWORD ON INCLUDES.id_keyword = KEYWORD.id
    LEFT JOIN BELONGS_TO ON BOOK.ISBN = BELONGS_TO.ISBN_book
    LEFT JOIN CATEGORY ON BELONGS_TO.id_category = CATEGORY.id
    WHERE BOOK.title LIKE ? 
    OR AUTHOR.lastName LIKE ? 
    OR CATEGORY.name LIKE ? 
    OR KEYWORD.word LIKE ?
    ORDER BY BOOK.title;
`;
    const stmt = sql.prepare(sql);
    try {
        const books = stmt.all(searchInput, searchInput, searchInput, searchInput);
        return books;
    } catch (err) {
        throw err;
    }
}

export let showBook =  (ISBN) => {
    // ανάκτηση όλων των βιβλίων της βάσης δεδομένων
    const sql = `SELECT BOOK.title, AUTHOR.firstName, AUTHOR.lastName, CATEGORY.name, BOOK.ISBN, BOOK.date_published, BOOK.edition, BOOK.num_pages, BOOK.publisher, BOOK.summary, BOOK.image_id 
    FROM BOOK , WRITES, AUTHOR, CATEGORY, BELONGS_TO
    WHERE BOOK.ISBN = WRITES.ISBN_book AND WRITES.id_author = AUTHOR.id
    AND BOOK.ISBN = BELONGS_TO.ISBN_book AND BELONGS_TO.id_category = CATEGORY.id
    AND ISBN = ?`;
    const stmt =  sql.prepare(sql);
    try {
        const book =  stmt.all(ISBN);
        return book;
    } catch (err) {
        throw err;
    }
}
