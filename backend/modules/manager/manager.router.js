const express = require('express');;
const router = express.Router();
const controller = require('./manager.controller');

router.get('/', controller.findAll);
router.get('/:id', controller.findById);

module.exports = router;