const express = require('express');;
const router = express.Router();
const controller = require('./staff.controller');
const { sendSusccessResponse, handleErrorResponse } = require('../../utils/index');

// find all staff in all branches
router.get('/', async (req, res) => {
    try {
        const staffs = await controller.findAll();
        sendSusccessResponse(res, 200, 'Get all staff from all branches', staffs)
    } catch (error) {

        console.error(error);
        res.status(500).json({
            statusCode: 500,
            message: error
        });
    }
})

/**
 * @description: Register a new staff's account and create a new record in staff table
*/
router.post('/createStaff/:branchId', async (req, res) => {
    try {
        const newStaff = await controller.createOneStaff(req.params.branchId, req.body);
        sendSusccessResponse(res, 200, 'Created staff', newStaff)
    } catch (error) {
        handleErrorResponse(res, 500, error);
    }
})

// delete a staff
router.delete('/deleteStaff/:staffId', async (req, res) => {
    try {
        const deletedStaff = await controller.deleteStaff(req.params.staffId);
        sendSusccessResponse(res, 200, `Deleted staff with id ${req.params.staffId}`, deletedStaff);
    } catch (error) {
        handleErrorResponse(res, 500, error);
    }
})

// update a staff
router.put('/updateStaff/:staffId', async (req, res) => {
    try {
        const result = await controller.updateStaff(req.params.staffId, req.body);
        sendSusccessResponse(res, 200, 'Updated staff', result);
    } catch (error) {
        handleErrorResponse(res, 500, error)
    }
})

// find all staff in one branches
router.get('/ofBranch/:branchId', async (req, res) => {
    try {
        const staffs = await controller.findAllStaffOfBranch(req.params.branchId);
        sendSusccessResponse(res, 200, 'Found all staff in branch ' + req.params.branchId, staffs);
    } catch (error) {
        handleErrorResponse(res, 500, error);
    }
})

// get details information about one staff
router.get('/:staffId', async (req, res) => {
    try {
        const staff = await controller.findById(req.params.staffId);
        sendSusccessResponse(res, 200, `Found staff with id ${req.params.staffId}`, staff);
    } catch (error) {
        handleErrorResponse(res, 500, error);
    }
})


module.exports = router;