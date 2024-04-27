const express = require('express');;
const router = express.Router();
const controller = require('./menu.controller');


// find all menu items of all branches
router.get('/', async (req, res) => {
    try {
        const result = await controller.findAll();
        res.status(200).json({
            status: 200,
            message: `Get all menu items`,
            data: result
        });
    } catch (error) {
        res.status(500).json({
            status: 500,
            message: error
        });
    }
});

// create an item in the menu of branch with id
router.post('/create/:branchId', async (req, res) => {
    try {
        const result = await controller.createAnItemAtBranch(req.params.branchId, req.body);
        res.status(200).json({
            message: `Created an item at branch ${req.params.branchId} with Item_ID:`,
            status: 200,
            data: result
        });
    } catch (error) {
        res.status(500)
    }
});

// update item with id
router.put('/update/:itemId', async (req, res) => {
    try {
        const itemAfterUpdate = await controller.updateAnItem(req.params.itemId, req.body);
        res.status(200).json({
            message: `Updated item with id ${req.params.id}`,
            status: 200,
            data: itemAfterUpdate
        });
    } catch (error) {
        res.status(500).json({
            message: error.sqlMessage,
            status: 500
        });
    }
});


// find items of the branch with the given branch's id
router.get('/:branchId', async (req, res) => {
    try {
        const items = await controller.findAllOfBranch(req.params.branchId);
        res.status(200).json({
            message: `Get all items from branch with id: ${req.params.branchId}`,
            status: 200,
            data: items
        });
    } catch (error) {
        res.sendStatus(500);
    }
});


module.exports = router;
