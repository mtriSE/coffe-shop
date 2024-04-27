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
router.post('/create', (req, res) => {
    try {
        const res =  controller.createCustomer();
        res.status(200).json({
            message: 'Get all',
            status: 200,
            data: res
        })
    } catch (error) {
        res.sendStatus(500)
    }
});
router.put('/update/:id', (req, res) => {
    req.params.id
    controller.updateCustomer();
});

router.get('/:id', (req, res) => {
    controller.findById();
});


module.exports = router;
