//import dotenv from 'dotenv';
//const express = re
//const model = await import (`code/model/${process.env.MODEL}/model_lite-${process.env.MODEL}.mjs`);
const model = await import ('code/model/better-sqlite/model_lite.js')

export const listShowBook = (req, res) => {
    const { ISBN } = req.params;

    book = model.showBook(ISBN, (err, rows) => {
        if(err){
            res.status(500).json({error: err.message});
        }
        else{
            res.status(200).json(rows);
        }
    });
};

export const listFindBooks = (req, res) => {
    const searchInput = `%${req.query.q}%`;

    model.findBooks(searchInput, (err, rows) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.status(200).json(rows);
        }
    });
}

export const addUser = (req, res) => {
    const { firstName, lastName, phone, email } = req.body;

    model.insertUser(firstName, lastName, email, phone, (err, user) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.status(200).json(user);
        }
    });
};

export const getUser = (req, res) => {
    const { email, password} = req.body;
    model.findUser(email, password, (err, userId) => {
        if(err || !userId){
            res.status(404).json({error: "USER NOT FOUND!!"});

        }
        else{
            res.status(200).json(userId);
        }
    });
};