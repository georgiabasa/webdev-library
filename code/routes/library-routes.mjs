import express from 'express';

import * as loginController from '../controller/login-controller-password.mjs';
import * as libraryController from '../controller/library-controller.mjs';

const router = express.Router();


//router.get('/books/:ISBN', libraryController.listShowBook);
//router.get('/books', libraryController.listFindBooks);

router.get('/searchresult', libraryController.listFindBooks);
router.get('/book', libraryController.listShowBook);

router.get('/login', loginController.showLogInForm);
router.post('/login', loginController.doLogin);
router.get('/signup', loginController.showSignUpForm);
router.post('/signup', loginController.doSignUp);
router.get('/logout', loginController.doLogout);


export default router;
