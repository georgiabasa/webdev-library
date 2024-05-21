import dotenv from "dotenv";
if (process.env.NODE_ENV !== 'production') {
  dotenv.config();
}   

import app from "./app.mjs";
const PORT = process.env.PORT || 3003;  

const server = app.listen(PORT, () => {
    console.log(`Συνδεθείτε στη σελίδα: http://localhost:${PORT}`); 
});


process.on('SIGTERM', () => {
    console.info('SIGTERM signal received.');
    console.log('Closing http server.');
    server.close(() => {
       console.log('Http server closed.');
    });
 });
 