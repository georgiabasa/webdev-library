//import * as model from '../model/better-sqlite/better-sqlite.mjs';
import * as model from '../model/sqlite-async/model_lite.mjs'

export async function listShowBook(req, res, next) {
    const { ISBN } = req.params;

    try {
        const bookres = await model.showBook(ISBN);
        console.log(bookres.image_id);  

        res.render('book', {
            book: bookres.book,
            copies: bookres.copies,
            model: process.env.MODEL,
            session: req.session
        });
    } catch (err) {
        throw err;
    }
}

export async function listFindBooks(req, res, next) {
    const searchInput =  req.query.searchInput;
    console.log(searchInput);

    try {
        const allbooks = await model.findBooks(searchInput);
        res.render('searchresult', { searchresult: allbooks, model: process.env.MODEL, session: req.session });
    } catch (err) {
        throw err;
    }
}

export async function showInfo(req, res) {
    res.render('about', { model: process.env.MODEL, session: req.session });
}

export async function showContact(req, res) {
    res.render('contact', { model: process.env.MODEL, session: req.session });
}

export async function showLocations(req, res) {
    res.render('location', { model: process.env.MODEL, session: req.session });
}