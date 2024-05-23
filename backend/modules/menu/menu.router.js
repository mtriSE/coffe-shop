const express = require('express');;
const router = express.Router();
const controller = require('./menu.controller');
const { sendSusccessResponse, handleErrorResponse } = require('../../utils');


// find all menu items of all branches
router.get('/', async (req, res) => {
    try {
        const result = await controller.findAll();
        sendSusccessResponse(res, 200,  `Get all menu items`, result)
    } catch (error) {
        handleErrorResponse(res, 500, error)
    }
});

// create an item in the menu of branch with id
router.post('/create', async (req, res) => {
    try {
        const result = await controller.createAnItem(req.body);
        sendSusccessResponse(res, 200, `Created an item at branch with Item_ID: ${result.Item_ID}`, result)
    } catch (error) {
        handleErrorResponse(res, 500, error)
    }
});

// update item with id
router.put('/update/:itemId', async (req, res) => {
    try {
        const itemAfterUpdate = await controller.updateAnItem(req.params.itemId, req.body);
        sendSusccessResponse(res, 200, `Updated item with id ${req.params.itemId}`, itemAfterUpdate )
    } catch (error) {
        handleErrorResponse(res, 500, error)
    }
});

router.delete('/delete/:itemId', async (req, res) => {
    try {
        const data = await controller.deleteAnItem(req.params.itemId);
        if (data.status) {
            sendSusccessResponse(res, 200, data.message, data);
        } else {
            sendSusccessResponse(res, 420, data.message, data);
        }
    } catch (error) {
        handleErrorResponse(res, 500, error)
    }
});

module.exports = router;
