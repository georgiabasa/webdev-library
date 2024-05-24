import * as model from '../model/sqlite-async/model_lite.mjs'

export async function viewAllUsers(req, res, next) {
    try {
        const allusers = await model.getAllUsers();
        res.render('allusers', { allusers: allusers, model: process.env.MODEL, session: req.session });
    } catch (err) {
        throw err;
    }
}

export async function viewAllApplications(req, res, next) {
    try {
        const allapplications = await model.getAllApplications();
        res.render('allapplications', { allapplications: allapplications, model: process.env.MODEL, session: req.session });
    } catch (err) {
        throw err;
    }
}

export async function viewAllBorrows(req, res, next) {
    try {
        const allborrows = await model.getAllBorrows();
        res.render('allborrows', { allborrows: allborrows, model: process.env.MODEL, session: req.session });
    } catch (err) {
        throw err;
    }
}