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
};

export let getAllUsers = async () => {
    // ανάκτηση των χρηστών
    const command = `SELECT * FROM USER`;
    const stmt = await sql.prepare(command);
    try {
        const users = await stmt.all();
        await stmt.finalize();
        return users;
    } catch (err) {
        throw err;
    }
};

export let getAllApplications = async (id_location) => {
    // ανάκτηση των αιτήσεων
    const command = `SELECT * 
    FROM APPLIES_FOR
    WHERE id_location = ?`;
    const stmt = await sql.prepare(command);
    try {
        const applications = await stmt.all(id_location);
        await stmt.finalize();
        return applications;
    } catch (err) {
        console.error('Error retrieving applications:', err);
        throw err;
    }
}

export let getAllBorrows = async (id_location) => {
    // ανάκτηση των δανεισμών
    const command = `SELECT * FROM BORROWS WHERE id_location = ?`;
    const stmt = await sql.prepare(command);
    try {
        const borrows = await stmt.all(id_location);
        await stmt.finalize();
        return borrows;
    } catch (err) {
        throw err;
    }
}

export let findCopyForISBN = async (ISBN, id_location) => {
    // ανάκτηση των αντιτύπων
    const command = `SELECT id FROM COPY WHERE ISBN_book = ? AND id_location = ? LIMIT 0, 1`;
    const stmt = await sql.prepare(command);
    try {
        const copy = await stmt.all(ISBN, id_location);
        await stmt.finalize();
        return copy;
    } catch (err) {
        throw err;
    }
}

export let acceptApplicationConfirm = async (id_user, ISBN_book, id_location) => {
    // αποδοχή της αίτησης
    const id_copy = await findCopyForISBN(ISBN_book, id_location);
    //console.log('id_copy:', id_copy)
    if (!id_copy || id_copy.length === 0) {
        const confirmation = false;
        console.error('No copy found');
        return confirmation;
    }
    else {
        const confirmation = true;
        const command1 = `INSERT INTO BORROWS (id_user, id_copy, date_borrowing, date_must_return, id_location) VALUES (?, ?, ?, ?, ?)`;
        const command2 = `DELETE FROM APPLIES_FOR WHERE id_user = ? AND ISBN_book = ? AND id_location = ?`;
        const stmt1 = await sql.prepare(command1);
        const stmt2 = await sql.prepare(command2);
        try {
            const today = new Date()
            const formattedToday = today.toISOString().split('T')[0]; // ημερομηνία του δανεισμού σε μορφή 'YYYY-MM-DD'
            const returnDate = new Date(today.getTime() + 14 * 24 * 60 * 60 * 1000); // ημερομηνία επιστροφής μετά από 14 μέρες
            const formattedReturnDate = returnDate.toISOString().split('T')[0]; // ημερομηνία επιστροφής σε μορφή 'YYYY-MM-DD'
            await stmt1.run(id_user, id_copy[0].id, formattedToday, formattedReturnDate, id_location);
            await stmt2.run(id_user, ISBN_book, id_location);
            await stmt1.finalize();
            await stmt2.finalize();
            return confirmation;
        } catch (err) {
            throw err;
        }
    }
};

export let checkBlacklist = async (id_user, id_copy, date_borrowing) => {
    // έλεγχος αν ο χρήστης είναι στη μαύρη λίστα
    const command = `SELECT date_must_return FROM BORROWS WHERE id_user = ? AND id_copy = ? AND date_borrowing = ?`;
    const stmt = await sql.prepare(command);
    try {
        const row = await stmt.get(id_user, id_copy, date_borrowing);
        await stmt.finalize();
        const today = new Date().toISOString().split('T')[0]; // current date in 'YYYY-MM-DD' format
        const dateMustReturn = row.date_must_return;
        const bl = dateMustReturn < today ? false : true;
        return bl;
    } catch (err) {
        throw err;
    }

}

export let acceptReturnConfirm = async (id_user, id_copy, date_borrowing, id_location) => {
    // αποδοχή της επιστροφής
    const blacklist = false;
    const command = `INSERT INTO RETURNS (id_user, id_copy, date_borrowing, date_returning, id_location) VALUES (?, ?, ?, ?, ?)`;
    const stmt = await sql.prepare(command);
    try {
        const blacklisted = await checkBlacklist(id_user, id_copy, date_borrowing);
        const today = new Date().toISOString().split('T')[0]; // ημερομηνία της επιστροφής σε μορφή 'YYYY-MM-DD'
        await stmt.run(id_user, id_copy, date_borrowing, today,  id_location);
        await stmt.finalize();
        return blacklisted;
    } catch (err) {
        throw err;
    }
}