import session from 'express-session'

let librarySession = session({
    secret: 'librarytopsecret',
    resave: false,
    saveUninitialized: false,
    cookie: { secure: false }
});

export default librarySession;