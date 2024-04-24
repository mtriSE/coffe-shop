const express = require('express');;
const router = express.Router();
const controller = require('./customer.controller');

router.use(express.urlencoded({ extended: true }));

router.get('/', (req, res) => {
    try {
        result = controller.findAll();
    } catch (error) {

    }
});

router.get('/:id', (req, res) => {
    controller.findById();
});
router.post('/create', (req, res) => {
    controller.createCustomer();
});
router.put('/update/:id', (req, res) => {
    controller.updateCustomer();
});


module.exports = router;
