import express from "express";
import handlebars from 'hbs';
import exphbs from "express-handlebars";
import path from "path";
import session from "express-session";


import { fileURLToPath } from 'url';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

import * as model from './model/better-sqlite/model_lite.js'; 
import bookRoutes from './routes/library-routes.mjs';

// Δημιουργία εξυπηρετητή Express
const app = express();



const redirectHome = (req, res, next) => {
  console.log('redirect...', req.session)
  if (!req.session.userID) {
    res.redirect('/');
  } else {
    next();
  }
};


// GET /
app.get("/", (req, res) => {
  console.log("GET / session=", req.session);
  const userID = req.session.userID
  console.log("/get/", userID)
  if (userID) {
    model.findUser(userID, null, (err, row) => {
      if (err) {
        console.error(err.message);
      } else
        console.log(row)
      res.render("index", { user: row[0].userName });
    });
  } else
    res.render("index");
});

// POST /
app.post("/", (req, res) => {
  console.log("POST / session=", req.session);
  console.log("/", req.body.userName);
  // έχει συμπληρωθεί το userName στη φόρμα
  // βρες τον χρήστη id ή δημιούργησε χρήστη αν δεν υπάρχει
  let userID = null;
  let userName = req.body.userName
  model.findUser(userID, userName, (err, row) => {
    console.log('POST / returned row....', row)
    if (err) {
      console.log(err.message);
    } else {
      req.session.userID = row[0].userID;
      req.session.userName = row[0].userName;
      console.log("new session", req.session)
    }
    res.redirect("/")
  });
});

//GET /about
//app.get("/about", (req, res) => {
//  console.log("GET /about session=", req.session);
// res.render("about");
//});

// GET /locations
//app.get("/location", (req, res) => {
 //   console.log("GET /location session=", req.session);
  //  res.render("location");
 // });

// GET /communication
//app.get("/contact", (req, res) => {
 // console.log("GET /contact session=", req.session);
 // res.render("contact");
//});

// GET /login
//app.get("/login", (req, res) => {
//    console.log("GET /login session=", req.session);
  //  res.render("login");
 // });

// GET /signup
//app.get("/signup", (req, res) => {
//    console.log("GET /signup session=", req.session);
 //   res.render("signup");
 // });



app.use('/api', bookRoutes);