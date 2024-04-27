const express = require('express');;
const router = express.Router();
const controller = require('./auth.controller');
const jwt = require('jsonwebtoken');
const middleware = require('../../middlewares/authorization');

const users = [
    {
        id: 1,
        username: 'admin',
    },
    {
        id: 2,
        username: 'mqtri'
    }
]

router.post('/login', (req, res) => {
    const username = req.body.username;
    const user = users.find(user => user.username === username);

    if (!user) {
        return res.sendStatus(401);// unauthorized
    }

    // create JWT
    const accessToken = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, {
        expiresIn: "7d"
    });
});


router.get('/posts', middleware.verifyToken, (req, res) => {
    const userId = req.userId;
    console.log(`userID: ${userId}`);
    res.status(200).json('success');
})

router.get('/postPrivate', middleware.verifyToken, (req, res) => {
    res.json(posts.filter(post => post.userId  === req.userId));
})

module.exports = router;