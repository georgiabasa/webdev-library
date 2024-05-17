'use strict';
import sqlite3 from "sqlite3";
import path from "path";
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const db_name = path.join(__dirname, "../data", "library_db.db");

const showBook = (ISBN, callback) => {
    // ανάκτηση όλων των βιβλίων της βάσης δεδομένων
    const sql = "SELECT * FROM BOOK WHERE ISBN = ?";
    const db = new sqlite3.Database(db_name);
    db.all(sql, [ISBN], (err, rows) => {
    if (err) {
        db.close();
        callback(err, null);
    }
    db.close();
    callback(null, rows); // επιστρέφει array
});
}


const findBooks = (searchInput, callback) => {
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
   const db = new sqlite3.Database(db_name);
   db.all(sql, [searchInput] ,(err, rows) => {
   if (err) {
       db.close();
       callback(err, null);
   }
   db.close();
   callback(null, rows); // επιστρέφει array
}); 
}



const insertUser = (firstName, lastName, email, phone, callback) => {
    // εισαγωγή νέου χρήστη, και επιστροφή στο callback της νέας εγγραφής
    const sql = "INSERT INTO USER(first_name, last_name, email, phoneNumber) VALUES (?,?,?,?);"
    const db = new sqlite3.Database(db_name);
    db.run(sql, [firstName, lastName, email, phone], function (err, row){
        if (err) {
            db.close();
            callback(err, null)
        }
        db.close();
        console.log('1 new user inserted', this.lastID);
        //callback(null, [{"userID":this.lastID, "userName": userName}]); 
    });
}

const findUser = (userName, password,callback) => {
    const sql = "SELECT id FROM USER WHERE username = ? AND password = ?"
    console.log('new sql...', sql)
    const db = new sqlite3.Database(db_name);
    db.all(sql, [userName, password], (err, row) => {
        console.log("findUser")
        if (err || row.length === 0) {
            db.close();
            return callback(null, null)
        }
        else {
            const userId = row[0].id
            db.close();
            callback(null, userId)
        }
    });
}



export {findBooks, showBook, insertUser, findUser};

