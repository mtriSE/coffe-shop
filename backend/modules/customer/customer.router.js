const express = require('express');;
const router = express.Router();
const controller = require('./customer.controller');

router.use(express.urlencoded({ extended: true }));

router.get('/', controller.findAll);
router.get('/:id', controller.findById);
router.post('/create', controller.createCustomer);
router.put('/update/:id', controller.updateCustomer);


module.exports = router;
