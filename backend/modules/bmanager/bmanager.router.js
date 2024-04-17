const express = require('express');;
const router = express.Router();
const controller = require('./bmanager.controller');

router.get('/', controller.findById);
router.get('/:id', controller.findAll);

module.exports = router;