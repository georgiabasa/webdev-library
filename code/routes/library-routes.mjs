import express from 'express';

import * as loginController from '../controller/login-controller-password.mjs';
import * as libraryController from '../controller/library-controller.mjs';
import * as adminController from '../controller/admin-controller.mjs';

const router = express.Router();

router.get('/', (req, res)=>{
    res.render('index');

})

//search results and single book show page
router.get('/book', libraryController.listShowBook);
router.get('/searchresult', libraryController.listFindBooks);
router.get('/book/:ISBN', loginController.checkAuthenticated, libraryController.listShowBook);

//borrowing
router.route('/borrow/:ISBN').get(loginController.checkAuthenticated, libraryController.listShowCitiesAvailable);
router.route('/borrow/:ISBN').post(loginController.checkAuthenticated, libraryController.handleBorrowRequest);

//asking
router.route('/ask/:ISBN').get(loginController.checkAuthenticated, libraryController.listCitiesNotAvailable);
router.route('/ask/:ISBN').post(loginController.checkAuthenticated, libraryController.handleAskRequest);

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

//logout
router.get('/logout', loginController.doLogout);

//adminpage
router.get('/allusers', loginController.checkAuthenticated, adminController.viewAllUsers);
router.get('/allapplications/:locationSelect', loginController.checkAuthenticated, adminController.viewAllApplications);
router.get('/allongoingborrows/:locationSelect', loginController.checkAuthenticated, adminController.viewAllBorrows);

//adminpage - accept or reject applications
router.route('/application/:id_user/:ISBN_book/:id_location').get(loginController.checkAuthenticated, adminController.acceptApplication);
router.route('/borrow/:id_user/:id_copy/:date_borrowing/:id_location').get(loginController.checkAuthenticated, adminController.acceptReturn);

export default router;
