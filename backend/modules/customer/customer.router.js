const express = require('express');;
const router = express.Router();
const controller = require('./customer.controller');
const { handleErrorResponse, sendSusccessResponse } = require('../../utils');

router.use(express.urlencoded({ extended: true }));

router.get('/', async (req, res) => {
    try {
        const customers = await controller.findAll();
        sendSusccessResponse(res, 200, 'Get all customers', customers);
    } catch (error) {
        handleErrorResponse(res, 500, error);
    }
});

router.put('/update/:customerId', async (req, res) => {
    try {
        const updatedCustomer = await controller.updateCustomer(req.params.customerId, req.body);
        sendSusccessResponse(res, 200, 'Update customer', updatedCustomer);
    } catch (error) {
        handleErrorResponse(res, 500, error);
    }
});

router.delete('/delete/:customerId', async (req, res) => {
    try {
        const deletedCustomer = await controller.deleteCustomer(req.params.customerId);
        sendSusccessResponse(res, 200, 'success deleted', {});
    } catch (error) {
        handleErrorResponse(res, 500, error);
    }
});


module.exports = router;
