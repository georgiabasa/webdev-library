import bcrypt from 'bcrypt';

//import * as userModel from '../model/better-sqlite/better-sqlite.mjs';   
import * as userModel from '../model/sqlite-async/model_lite.mjs'

export let showLogInForm = function (req, res) {
    res.render('login', {model: process.env.MODEL});
}

export let showSignUpForm = function (req, res) {
    res.render('signup', {});
}

export let doLogin = async function (req, res) {
    console.log("kapoios kanei login");

    try{
        const user = await userModel.getUserByEmail(req.body.email);
        console.log(user);

        if(!user || !user.hashpass || !user.id){
            return res.render('login', { message: 'Δεν βρέθηκε αυτός ο χρήστης.'});
        }

        const isAdmin = user.email === "admin@admin.gr";
        const match = await bcrypt.compare(req.body.password, user.hashpass);

        if(match) {
            req.session.loggedUserId = user.id;
            if(isAdmin) {
                console.log('user is authenticated: ADMIN', user.id);
            }
            else {
                console.log('user is authenticated: regular user', user.id);
            }
            const redirectTo = isAdmin ? "adminpage" : "/";
            return res.redirect(redirectTo);
        }
        else {
            return res.render('login', { message: 'Λάθος κωδικός.' });
        }
    }
    catch(error) {
        console.error("Error during login process:", error);
        res.render('login', { message: 'Παρουσιάστηκε error κατά την είσοδο.' });
    }
};

export let doSignUp = async function (req, res) {
    try {
        const registrationResult = await userModel.insertUser(req.body.email, req.body.password, req.body.firstName, req.body.lastName, req.body.phone);
        res.redirect('login');

    } catch (error) {
        console.error('registration ' + error);
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