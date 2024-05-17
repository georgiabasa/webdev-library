import express from 'express';
const libraryController = await import(`../controller/library-controller.mjs`);
const router = express.Router();


router.get('/books/:ISBN', libraryController.listShowBook);
router.get('/books', libraryController.listFindBooks);
router.post('/users', libraryController.addUser);
router.post('/user/login', libraryController.getUser);


export default router;
