import express from "express";
const app = express();
import dotenv from "dotenv";
if (process.env.NODE_ENV !== 'production') {
  dotenv.config();
}

import handlebars from 'hbs';
import exphbs from "express-handlebars";

//Χρειάζεται για το χειρισμό των αιτημάτων που έρχονται με POST
//(extended:false σημαίνει πως δε χρειαζόμαστε να διαβάσουμε εμφωλευμένα αντικείμενα που έχουν έρθει με το αίτημα POST)
app.use(express.urlencoded({ extended: false }));

app.use(express.static('public'));
app.use('/images', express.static('images'));

app.use((req, res, next) => {
    if(req.session){
        res.locals.session = req.session.loggedUserId;
    }
    else{
        res.locals.loggedUserId = 'επισκέπτης'; 
        //αλλιώς res.locals.userId = 'επισκέπτης';
    }
    next();
});

import routes from './routes/library-routes.mjs';
app.use('/', routes);   

app.engine('hbs', exphbs.engine({ extname: 'hbs'}));
//αλλιώς app.engine('hbs', exphbs.engine({ extname: 'hbs'}));

app.set('view engine', 'hbs');
export default app;