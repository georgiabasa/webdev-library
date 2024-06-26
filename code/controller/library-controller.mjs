//import * as model from '../model/better-sqlite/better-sqlite.mjs';
import * as model from '../model/sqlite-async/model_lite.mjs'

export async function listShowBook(req, res, next) {
    const { ISBN } = req.params;

    try {
        const bookres = await model.showBook(ISBN);
        //console.log(bookres.image_id);  

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
    //console.log(searchInput);

    try {
        const allbooks = await model.findBooks(searchInput);
        res.render('searchresult', { searchresult: allbooks, model: process.env.MODEL, session: req.session });
    } catch (err) {
        throw err;
    }
}

export async function listShowCitiesAvailable(req, res, next) {
    const { ISBN } = req.params;

    try {
        const aCities = await model.showCitiesAvailable(ISBN);
        res.render('borrow', { ISBN: ISBN, aCities: aCities, model: process.env.MODEL, session: req.session });
    } catch (err) {
        throw err;
    }
}

export async function handleBorrowRequest(req, res, next) {
    const { ISBN } = req.params;
    const { city } = req.body;
    const userId = req.session.loggedUserId;

    try {
        await model.borrowBook(userId, ISBN, city);
        res.render('borrowConfirmation', {ISBN: ISBN, city: city , model: process.env.MODEL, session: req.session});
    } catch (err) {
        throw err;
    }
};

export async function listCitiesNotAvailable(req, res, next) {
    const { ISBN } = req.params;

    try {
        const naCities = await model.showCitiesNotAvailable();
        //console.log(naCities);
        res.render('ask', { ISBN: ISBN, naCities: naCities, model: process.env.MODEL, session: req.session });
    } catch (err) {
        throw err;
    }
};

export async function handleAskRequest(req, res, next) {
    const { ISBN } = req.params;
    const { city } = req.body;
    const userId = req.session.loggedUserId;

    try {
        await model.askBook(userId, ISBN, city);
        res.render('askConfirmation', {ISBN: ISBN, city: city , model: process.env.MODEL, session: req.session});
    } catch (err) {
        throw err;
    }
};

export async function showInfo(req, res) {
    res.render('about', { model: process.env.MODEL, session: req.session });
}

export async function showContact(req, res) {
    try {
        const contactInfo = await model.showLibraryInfo();
        res.render('contact', { contactInfo: contactInfo, model: process.env.MODEL, session: req.session });
    }
    catch (err) {
        throw err;
    }
};

export async function showLocations(req, res){
    try {
        const locationInfo = await model.showLibraryInfo();
        res.render('location', { locationInfo: locationInfo, model: process.env.MODEL, session: req.session });
    }
    catch (err) {
        throw err;
    }
};