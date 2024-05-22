const express = require('express');;
const router = express.Router();
const controller = require('./bill.controller');
const { handleErrorResponse, sendSusccessResponse } = require('../../utils');

// get all bills 
router.get('/history', async (req, res) => {
    try {
        const bills = await controller.findAllBills();
        sendSusccessResponse(res, 200, 'Get all bills', bills);
    } catch (error) {
        handleErrorResponse(res, 500, error);
    }
})

// 
router.post('/createBill', async (req, res) => {
    try {
        const { customer_CCCD, roomId, itemsPurchased, total } = req.body;
        await controller.createOneBill({ itemsPurchased, roomId, total });
        sendSusccessResponse(res, 200, 'test', { itemsPurchased, roomId, total });
    } catch (error) {
        handleErrorResponse(res, 500, error)
    }
})

module.exports = router;