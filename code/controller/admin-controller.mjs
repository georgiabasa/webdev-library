import * as model from '../model/sqlite-async/model_lite.mjs'

export async function viewAllUsers(req, res, next) {
    try {
        const allusers = await model.getAllUsers();
        res.render('allusers', { allusers: allusers, model: process.env.MODEL, session: req.session });
    } catch (err) {
        throw err;
    }
};

export async function viewAllApplications(req, res, next) {
    try {
        const id_location = req.params.locationSelect;
        const allapplications = await model.getAllApplications(id_location);
        res.render('allapplications', { allapplications: allapplications, model: process.env.MODEL, session: req.session });
    } catch (err) {
        throw err;
    }
};

export async function viewAllBorrows(req, res, next) {
    try {
        const id_location = req.params.locationSelect;
        const allborrows = await model.getAllBorrows(id_location);
        res.render('allborrows', { allborrows: allborrows, model: process.env.MODEL, session: req.session });
    } catch (err) {
        throw err;
    }
};

export async function acceptApplication(req, res, next) {
    try {
        const id_user = req.params.id_user;
        const ISBN_book = req.params.ISBN_book;
        const id_location = req.params.id_location;
        const confirmation = await model.acceptApplicationConfirm(id_user, ISBN_book, id_location);
        res.render('borrowDone', { confirmation: confirmation, model: process.env.MODEL, session: req.session});
    } catch (err) {
        throw err;
    }
};

export async function acceptReturn(req, res, next) {
    try {
        const id_user = req.params.id_user;
        const id_copy = req.params.id_copy;
        const date_borrowing = req.params.date_borrowing;
        const id_location = req.params.id_location;
        const blacklisted = await model.acceptReturnConfirm(id_user, id_copy, date_borrowing, id_location);
        res.render('returnDone', { blacklisted: blacklisted, model: process.env.MODEL, session: req.session});
    } catch (err) {
        throw err;
    }
}