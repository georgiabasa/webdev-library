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

// Διαμόρφωση του εξυπηρετητή
app.engine('hbs', exphbs.engine({ extname: 'hbs', defaultLayout: 'main', layoutsDir: __dirname + '/views/layouts' }));
app.set('view engine', 'hbs');
app.use(express.static(path.join(__dirname, "public")));
app.use(express.urlencoded({ extended: false }));

// Προσθήκη του express-session middleware
app.use(session({
  name: process.env.SESS_NAME,
  secret: process.env.SESSION_SECRET || "PynOjAuHetAuWawtinAytVunar", // κλειδί για κρυπτογράφηση του cookie
  resave: false, // δεν χρειάζεται να αποθηκεύεται αν δεν αλλάξει
  saveUninitialized: false, // όχι αποθήκευση αν δεν έχει αρχικοποιηθεί
  cookie: {
    maxAge: 2 * 60 * 60 * 1000, //TWO_HOURS χρόνος ζωής του cookie σε ms
    sameSite: true
  }
}));

const redirectHome = (req, res, next) => {
  console.log('redirect...', req.session)
  if (!req.session.userID) {
    res.redirect('/');
  } else {
    next();
  }
};

console.log(process.env.PORT)
// Εκκίνηση του εξυπηρετητή
const PORT = process.env.PORT || 3003
app.listen(PORT, () => {
  console.log(`Συνδεθείτε στη σελίδα: http://localhost:${PORT}`);
});

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

// GET /about
app.get("/about", (req, res) => {
  console.log("GET /about session=", req.session);
  res.render("about");
});

// GET /locations
app.get("/location", (req, res) => {
    console.log("GET /location session=", req.session);
    res.render("location");
  });

// GET /communication
app.get("/communication", (req, res) => {
  console.log("GET /communication session=", req.session);
  res.render("communication");
});

// GET /login
app.get("/login", (req, res) => {
    console.log("GET /login session=", req.session);
    res.render("login");
  });

// GET /signup
app.get("/signup", (req, res) => {
    console.log("GET /signup session=", req.session);
    res.render("signup");
  });



app.use('/api', bookRoutes);