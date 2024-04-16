require('dotenv').config({ path: '.env' })
const express = require('express');
const cors = require('cors');
const app = express();

app.use(express.urlencoded({ extended: true }));
app.use(cors({
    origin: '*'
}))

app.get('/', (req, res) => {
    res.status(200).send('<h1>hello world</h1>');
});

app.listen(process.env.NODE_SERVER_PORT, () => {
    console.info('listening on port ' + process.env.NODE_SERVER_PORT)
})