const express = require('express');;
const router = express.Router();
const controller = require('./bill.controller');
const { handleErrorResponse, sendSusccessResponse } = require('../../utils');
const { verifyToken } = require('../../middlewares/authorization');

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
router.post('/createBill', verifyToken, async (req, res) => {
    try {
        const { User_ID } = res.locals.decoded;
        const { roomId, itemsPurchased, total, Bmgr_CCCD } = req.body;
        const control = await controller.createOneBill({ customer_CCCD: User_ID, itemsPurchased, roomId, total, Bmgr_CCCD });
        // sendSusccessResponse(res, 200, 'test', { itemsPurchased, roomId, total });
        sendSusccessResponse(res, 200, 'test', control);
    } catch (error) {
        handleErrorResponse(res, 500, error)
    }
})


module.exports = router;