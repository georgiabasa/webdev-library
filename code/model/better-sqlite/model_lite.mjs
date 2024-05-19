'use strict';
import sqlite3 from "sqlite3";
import path from "path";
import { fileURLToPath } from 'url';
import bcrypt from 'bcrypt'


const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const db_name = path.join(__dirname, "../data", "library_db.db");


//show to sugkekrimeno vivlio pros daneismo
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

//find ola ta vivlia vasei anazitisis
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

//Επιστρέφει τον χρήστη με email 'email'
const getUserByEmail = (email, callback) => {
    const sql = "SELECT id FROM USER WHERE email = ? LIMIT 0, 1";
    const db = new sqlite3.Database(db_name);
    db.all(sql, [email], (err, rows) => {
        if (err) {
            db.close();
            callback(err, null);
        }
        db.close();
        callback(null, rows[0]?.id); // επιστρέφει τον πρώτο χρήστη που βρέθηκε
    });
}

//epistrefei to hashpass tou USER by email
const getHashByEmail = (email, callback) => {
    const sql = "SELECT hashpass FROM USER WHERE email = ? LIMIT 0, 1";
    const db = new sqlite3.Database(db_name);
    db.all(sql, [email], (err, rows) => {
        if (err) {
            db.close();
            callback(err, null);
        }
        db.close();
        callback(null, rows[0]?.hashpass); // επιστρέφει το hashpass του πρώτου χρήστη που βρέθηκε
    });
}

//eisagei neo xristi sti vasi
const insertUser = (email, password, firstName, lastName, phone, callback) => {
    // εισαγωγή νέου χρήστη, και επιστροφή στο callback της νέας εγγραφής
    getUserByEmail(email, (err, userId) => {
        if(err){
            return callback(err,null);
        }
        if(userId != undefined) {
            const err1 = new Error("Email already used!");
            return callback(err1, null);
        }

        bcrypt.hash(password,10, (err, hashedPassword) => {
            if(err){
                return callback(err, null);
            }

            const sql = "INSERT INTO USER(email, hashpass, first_name, last_name, phoneNumber) VALUES (?,?,?,?,?);"
            const db = new sqlite3.Database(db_name);
            db.run(sql, [email,hashedPassword, firstName, lastName, phone], function(err, row) {
                if(err){
                    db.close();
                    return callback(err,null);
                }
                db.close();
                console.log("1 new user inserted!", this.lastID);
                callback(null, this.lastID);
            });
        });
    });
}

//vriskei xristi apo ti vasi epistrefei id
const findUser = (email, password,callback) => {
    getHashByEmail(email, (err, hashpass) => {
        if(err){
            return callback(err,null);
        }
        if(hashpass === undefined) {
            const err1 = new Error("This user does not exist!");
            return callback(err1, null);
        }
        bcrypt.compare(password,hashpass, (err, result) => {
            if(err){
                return callback(err, null);
            }
            if(!result) {
                const err2 = new Error("Password is incorrect!");
                return callback(err2, null);
            }
            callback(null,true);
        });

    });
};

export {findBooks, showBook, getUserByEmail, getHashByEmail, insertUser, findUser};

