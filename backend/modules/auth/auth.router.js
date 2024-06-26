const express = require('express');;
const router = express.Router();
const controller = require('./auth.controller');
const jwt = require('jsonwebtoken');
const middleware = require('../../middlewares/authorization');

router.post('/login', controller.login);

router.post('/register', controller.register);

router.get('/logout', controller.logout);

module.exports = router;