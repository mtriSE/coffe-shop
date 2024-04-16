require('dotenv').config({ path: '.env' })
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.status(200).json({ message: "hello world!" });
});

app.listen(process.env.NODE_SERVER_PORT, () => {
    console.info('listening on port ' + process.env.NODE_SERVER_PORT)
})