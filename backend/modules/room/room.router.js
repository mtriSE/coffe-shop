const express = require('express');;
const router = express.Router();
const controller = require('./room.controller');
const { sendSusccessResponse, handleErrorResponse } = require('../../utils');

// get all room
router.get('/', async (req, res) => {
    try {
        const rooms = await controller.getAllRoom();
        sendSusccessResponse(res, 200, 'Get all rooms from all branches', rooms);
    } catch (error) {
        handleErrorResponse(res, 500, error);
    }
});

// create a new room for a branch with branchId
router.post('/createRoom/:branchId', async (req, res) => {
    try {
        const { rooms, fields } = await controller.createRoom(req.params.branchId, req.body);
        res.status(200).json({
            statusCode: 200,
            message: 'Room created',
            data: { rooms: rooms, fields: fields }
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({
            statusCode: 500,
            message: error
        });
    }
});

// delete a roow of a branch with branchId and roomId
router.delete('/deleteRoom/:branchId/:roomId', async (req, res) => {
    try {
        const { rooms, fields } = await controller.deleteRoom(req.params.branchId, req.params.roomId);
        res.status(200).json({
            statusCode: 200,
            message: 'Room deleted successfully',
            data: { rooms: rooms, fields: fields }
        })
    } catch (error) {
        console.error(error);
        res.status(500).json({
            statusCode: 500,
            message: error
        });
    }
});

// update a room for a branch with branchId and roomId
router.put('/updateRoom/:branchId/:roomId', async (req, res) => {
    try {
        const { rooms, fields } = await controller.updateRoom(req.params.branchId, req.params.roomId, req.body);
        res.status(200).json({
            statusCode: 200,
            message: 'Room updated successfully',
            data: { rooms: rooms, fields: fields }
        })
    } catch (error) {
        console.error(error);
        res.status(500).json({
            statusCode: 500,
            message: error
        });
    }
});

// get all rooms of branch with branchId
router.get('/:branchId', async (req, res) => {
    try {
        const rooms = await controller.getAllRoomOfBranch(req.params.branchId);
        res.status(200).json({
            statusCode: 200,
            message: 'Get all rooms of branch with branch',
            data: rooms
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({
            statusCode: 500,
            message: error
        });
    }
});

module.exports = router;