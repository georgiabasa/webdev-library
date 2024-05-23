import express from 'express';

import * as loginController from '../controller/login-controller-password.mjs';
import * as libraryController from '../controller/library-controller.mjs';

const router = express.Router();

router.get('/', (req, res)=>{
    res.render('index');

})

//search results and single book show page
router.get('/book', libraryController.listShowBook);
router.get('/searchresult', libraryController.listFindBooks);
router.get('/book/:ISBN', loginController.checkAuthenticated, libraryController.listShowBook);


//info page
router.get('/about', libraryController.showInfo);

//contact page
router.get('/contact', libraryController.showContact);

//locations
router.get('/location', libraryController.showLocations);

//login
router.route('/login').get(loginController.showLogInForm);
router.route('/login').post(loginController.doLogin);




//signup 
router.route('/signup').get(loginController.showSignUpForm);
router.route('/signup').post(loginController.doSignUp);

export default router;
