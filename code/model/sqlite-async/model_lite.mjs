'use strict';
import { Database } from 'sqlite-async'
//import sqlite3 from "sqlite3";
import path from "path";
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import bcrypt from 'bcrypt'


let sql;
try{
    sql = await Database.open('model/db/library_db.db');
}
catch (error){
    throw Error('Not able to open database' + error);
}

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
    } 
    else {
        try {
            const hashedPassword = await bcrypt.hash(password, 10);
            const stmt = await sql.prepare('INSERT INTO USER VALUES (null, ?, ?, ?, ?, ?, 0)');
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
        return user[0];
    } catch (err) {
        throw err;
    }
}

export let findBooks = async (searchInput) => {
    // ανάκτηση των βιβλίων αναλογα την αναζητηση
    const command = `
    SELECT DISTINCT BOOK.ISBN, CATEGORY.name, BOOK.image_id, BOOK.title, AUTHOR.firstName, AUTHOR.lastName 
    FROM BOOK
    LEFT JOIN WRITES ON BOOK.ISBN = WRITES.ISBN_book
    LEFT JOIN AUTHOR ON WRITES.id_author = AUTHOR.id
    LEFT JOIN INCLUDES ON BOOK.ISBN = INCLUDES.ISBN_book
    LEFT JOIN KEYWORD ON INCLUDES.id_keyword = KEYWORD.id
    LEFT JOIN BELONGS_TO ON BOOK.ISBN = BELONGS_TO.ISBN_book
    LEFT JOIN CATEGORY ON BELONGS_TO.id_category = CATEGORY.id
    WHERE BOOK.title LIKE '%' || ? || '%' 
    OR AUTHOR.lastName LIKE '%' || ? || '%'  
    OR CATEGORY.name LIKE '%' || ? || '%'  
    OR KEYWORD.word LIKE '%' || ? || '%' 
    ORDER BY BOOK.title;
`;
    const stmt = await sql.prepare(command);
    try {
        const books = await stmt.all(searchInput, searchInput, searchInput, searchInput);
        return books;
    } catch (err) {
        throw err;
    }
}

export let showBook = async (ISBN) => {
    // ανάκτηση ενός βιβλίου από το ISBN
    const command = `SELECT BOOK.image_id, BOOK.title, AUTHOR.firstName, AUTHOR.lastName, CATEGORY.name AS category, BOOK.ISBN, BOOK.date_published, BOOK.edition, BOOK.num_pages, BOOK.publisher, BOOK.summary
    FROM BOOK , WRITES, AUTHOR, CATEGORY, BELONGS_TO
    WHERE BOOK.ISBN = WRITES.ISBN_book AND WRITES.id_author = AUTHOR.id
    AND BOOK.ISBN = BELONGS_TO.ISBN_book AND BELONGS_TO.id_category = CATEGORY.id
    AND ISBN = ?`;
    const stmt = await sql.prepare(command);
    try {
        const book = await stmt.all(ISBN);
        return book[0];
    } catch (err) {
        throw err;
    }
}
