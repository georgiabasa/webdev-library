'use strict';
import sqlite3 from "sqlite3";
import path from "path";
import { fileURLToPath } from 'url';
import bcrypt from 'bcrypt'


const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const db_name = path.join(__dirname, "../data", "library_db.db");

let sql = new sqlite3.Database(db_name, (err) => {
    if (err) {
        console.error(err.message);
        throw err;
    }
    console.log('Connected to the library database.');
}
);

//Επιστρέφει τον χρήστη με email
export let getUserByEmail = async (email) => {
    const stmt = await sql.prepare("SELECT id, email, hashpass FROM USER WHERE email = ? LIMIT 0, 1");
    try {
        const user = await stmt.all(email);
        return user[0];
    } catch (err) {
        throw err;
    }
}

//eisagei neo xristi sti vasi
export let insertUser = async function (email, password, firstName, lastName, phone) {
    // ελέγχουμε αν υπάρχει χρήστης με αυτό το username
    const user = await getUserByEmail(email);
    if (user != undefined) {
        return { message: "Υπάρχει ήδη χρήστης με αυτό το όνομα" };
    } else {
        try {
            const hashedPassword = await bcrypt.hash(password, 10);
            const stmt = await sql.prepare('INSERT INTO USER VALUES (null, ?, ?, ?, ?, ?)');
            const info = await stmt.run(email, hashedPassword, firstName, lastName, phone);
            return info.lastID;
        } catch (error) {
            throw error;
        }
    }
}

//vriskei id xristi apo ti vasi epistrefei id
export let findUser = async (email, password) => {
    //Φέρε μόνο μια εγγραφή (το LIMIT 0, 1) που να έχει username και password ίσο με username και password 
    const stmt = await sql.prepare("SELECT id FROM USER WHERE email = ? and hashpass = ? LIMIT 0, 1");
    try {
        const user = await stmt.all(email, password);
    } catch (err) {
        throw err;
    }
}

export let findBooks = async (searchInput) => {
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
    const stmt = await sql.prepare(sql);
    try {
        const books = await stmt.all(searchInput, searchInput, searchInput, searchInput);
        return books;
    } catch (err) {
        throw err;
    }
}

export let showBook = async (ISBN) => {
    // ανάκτηση όλων των βιβλίων της βάσης δεδομένων
    const sql = `SELECT BOOK.title, AUTHOR.firstName, AUTHOR.lastName, CATEGORY.name, BOOK.ISBN, BOOK.date_published, BOOK.edition, BOOK.num_pages, BOOK.publisher, BOOK.summary, BOOK.image_id 
    FROM BOOK , WRITES, AUTHOR, CATEGORY, BELONGS_TO
    WHERE BOOK.ISBN = WRITES.ISBN_book AND WRITES.id_author = AUTHOR.id
    AND BOOK.ISBN = BELONGS_TO.ISBN_book AND BELONGS_TO.id_category = CATEGORY.id
    AND ISBN = ?`;
    const stmt = await sql.prepare(sql);
    try {
        const book = await stmt.all(ISBN);
        return book;
    } catch (err) {
        throw err;
    }
}
