import bcrypt from 'bcrypt';

import * as userModel from '../model/better-sqlite/model_lite.mjs';

export let showLogInForm = function (req, res) {
    res.render('login', {model: process.env.MODEL});
}

export let showSignUpForm = function (req, res) {
    res.render('signup', {});
}

export let doLogin = async function (req, res) {
    //Ελέγχει αν το username και το password είναι σωστά και εκτελεί την
    //συνάρτηση επιστροφής authenticated

    const user = await userModel.getUserByEmail(req.body.email);
    if (user == undefined || !user.hashpass || !user.id) {
        res.render('login', { message: 'Δε βρέθηκε αυτός ο χρήστης' });
    }
    else {
        const match = await bcrypt.compare(req.body.password, user.hashpass);
        if (match) {
            //Θέτουμε τη μεταβλητή συνεδρίας "loggedUserId"
            req.session.loggedUserId = user.id;
            //Αν έχει τιμή η μεταβλητή req.session.originalUrl, αλλιώς όρισέ τη σε "/" 
            // res.redirect("/");            
            const redirectTo = req.session.originalUrl || "/";

            res.redirect(redirectTo);
        }
        else {
            res.render("login", { message: 'Ο κωδικός πρόσβασης είναι λάθος' })
        }
    }
}

export let doSignUp = async function (req, res) {
    try {
        const registrationResult = await userModel.insertUser(req.body.email, req.body.password, req.body.firstName, req.body.lastName, req.body.phone);
        if (registrationResult.message) {
            res.render('signup', { message: registrationResult.message })
        }
        else {
            res.redirect('/login');
        }
    } catch (error) {
        console.error('registration error: ' + error);
        //FIXME: δε θα έπρεπε να περνάμε το εσωτερικό σφάλμα στον χρήστη
        //res.render('register-password', { message: error });
        res.render('signup', { message: 'Παρουσιάστηκε error κατά την εγγραφή.' });
    }
}

export let doLogout = (req, res) => {
    //Σημειώνουμε πως ο χρήστης δεν είναι πια συνδεδεμένος
    req.session.destroy();
    res.redirect('/');
}

//Τη χρησιμοποιούμε για να ανακατευθύνουμε στη σελίδα /login όλα τα αιτήματα από μη συνδεδεμένους χρήστες
export let checkAuthenticated = function (req, res, next) {
    //Αν η μεταβλητή συνεδρίας έχει τεθεί, τότε ο χρήστης είναι συνεδεμένος
    if (req.session.loggedUserId) {
        console.log("user is authenticated", req.originalUrl);
        //Καλεί τον επόμενο χειριστή (handler) του αιτήματος
        next();
    }
    else {
        //Ο χρήστης δεν έχει ταυτοποιηθεί, αν απλά ζητάει το /login ή το register δίνουμε τον
        //έλεγχο στο επόμενο middleware που έχει οριστεί στον router
        if ((req.originalUrl === "/login") || (req.originalUrl === "/signup")) {
            next()
        }
        else {
            //Στείλε το χρήστη στη "/login" 
            console.log("not authenticated, redirecting to /login")
            res.redirect('/login');
        }
    }
}