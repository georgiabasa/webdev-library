//import dotenv from 'dotenv';
//const express = re
//const model = await import (`code/model/${process.env.MODEL}/model_lite-${process.env.MODEL}.mjs`);
const model = await import ('code/model/better-sqlite/model_lite.js')

export async function listShowBook(req, res, next) {
    const { ISBN } = req.params;

    try {
        const book = await model.showBook(ISBN);
        res.render('book', { book: book , model: process.env.MODEL, session: req.session });
    } catch (err) {
        throw err;
    }
}

export async function listFindBooks(req, res, next) {
    const searchInput = `%${req.query.q}%`;

    try {
        const allbooks = await model.findBooks(searchInput);
        res.render('searchresult', { searchresult: allbooks, model: process.env.MODEL, session: req.session });
    } catch (err) {
        throw err;
    }
}