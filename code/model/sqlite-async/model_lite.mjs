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
    const stmt = await sql.prepare("SELECT id, email, hashpass FROM USER WHERE email = ?");
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
    const command1 = `SELECT BOOK.image_id, BOOK.title, AUTHOR.firstName, AUTHOR.lastName, CATEGORY.name AS category, BOOK.ISBN, BOOK.date_published, BOOK.edition, BOOK.num_pages, BOOK.publisher, BOOK.summary
    FROM BOOK , WRITES, AUTHOR, CATEGORY, BELONGS_TO
    WHERE BOOK.ISBN = WRITES.ISBN_book AND WRITES.id_author = AUTHOR.id
    AND BOOK.ISBN = BELONGS_TO.ISBN_book AND BELONGS_TO.id_category = CATEGORY.id
    AND ISBN = ?`;
    const command2 = `SELECT LIBRARY.city, COUNT(*) AS available_copies
    FROM COPY, LIBRARY
    WHERE ISBN_book=? AND COPY.id_location=LIBRARY.id
    GROUP BY id_location;`

    const stmt1 = await sql.prepare(command1);
    const stmt2 = await sql.prepare(command2);

    try {
        const book = await stmt1.all(ISBN);
        //console.log('Book: ', book);
        const copies = await stmt2.all(ISBN);
        //console.log('Copies: ', copies);

        await stmt1.finalize();
        await stmt2.finalize();

        //if(book.length === 0) {
        //    console.error('Book not found');
        //}
        //if(copies.length === 0) {
        //    console.error('No copies found');
        //}
        return { book: book[0], copies: copies };
    } catch (err) {
        await stmt1.finalize();
        await stmt2.finalize();
        //console.error('Error in showBook: ', err);
        throw err;
    }
};

export let showCitiesAvailable = async (ISBN) => {
    // ανάκτηση των πόλεων που υπάρχουν αντίτυπα του βιβλίου
    const command = `SELECT DISTINCT LIBRARY.city
    FROM LIBRARY, COPY
    WHERE COPY.id_location = LIBRARY.id
    AND COPY.ISBN_book = ?
    ORDER by LIBRARY.city`

    const stmt = await sql.prepare(command);
    try {
        const availableCities = await stmt.all(ISBN);
        await stmt.finalize();
        return availableCities;
    } catch (err) {
        throw err;
    }
}

async function getLocationId(city) {
    // ανάκτηση του id της πόλης
    const command = `SELECT id FROM LIBRARY WHERE city = ?`;
    const stmt = await sql.prepare(command);
    const row = await stmt.get(city);
    await stmt.finalize();
    return row ? row.id : null;
}

export let borrowBook = async (userId, ISBN, city) => {
    // προσθήκη ενός νέου δανεισμού
    const locationId = await getLocationId(city);
    const date = new Date().toISOString().split('T')[0]; // ημερομηνία του δανεισμού σε μορφή 'YYYY-MM-DD'
    const command = `INSERT INTO APPLIES_FOR (id_user, ISBN_book, date, id_location) VALUES (?, ?, ?, ?)`
    const stmt = await sql.prepare(command);
    try {
        await stmt.run(userId, ISBN, date, locationId);
        await stmt.finalize();
    } catch (err) {
        throw err;
    }
};

export let showCitiesNotAvailable = async () => {
    // ανάκτηση των πόλεων
    const command = `SELECT DISTINCT LIBRARY.city
    FROM LIBRARY
    LEFT JOIN COPY ON COPY.id_location = LIBRARY.id AND COPY.ISBN_book = ?
    WHERE COPY.ISBN_book IS NULL
    ORDER BY LIBRARY.city;`;
    const stmt = await sql.prepare(command);
    try {
        const notAvailableCities = await stmt.all();
        await stmt.finalize();
        return notAvailableCities;
    } catch (err) {
        throw err;
    }
};

export let askBook = async (userId, ISBN, city) => {
    // προσθήκη ενός νέου δανεισμού
    const locationId = await getLocationId(city);
    const date = new Date().toISOString().split('T')[0]; // ημερομηνία του δανεισμού σε μορφή 'YYYY-MM-DD'
    const command = `INSERT INTO APPLIES_FOR (id_user, ISBN_book, date, id_location) VALUES (?, ?, ?, ?)`
    const stmt = await sql.prepare(command);
    try {
        await stmt.run(userId, ISBN, date, locationId);
        await stmt.finalize();
    } catch (err) {
        throw err;
    }
};

export let showLibraryInfo = async () => {
    // ανάκτηση των πληροφοριών για τις βιβλιοθήκες
    const command = `SELECT * FROM LIBRARY`;
    const stmt = await sql.prepare(command);
    try {
        const libraries = await stmt.all();
        await stmt.finalize();
        return libraries;
    } catch (err) {
        throw err;
    }
}