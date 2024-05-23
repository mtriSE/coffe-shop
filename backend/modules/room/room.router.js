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
router.post('/createRoom', async (req, res) => {
    try {
        const room = await controller.createRoom(req.body);
        if (room) {
            sendSusccessResponse(res, 201, 'Room created', room);
        } else {
            sendSusccessResponse(res, 304, 'Room not created', room);
        }
    } catch (error) {
        handleErrorResponse(res, 500, error)
    }
});

// delete a roow of a branch with branchId and roomId
router.delete('/deleteRoom/:roomId', async (req, res) => {
    try {
        const data = await controller.deleteRoom(req.params.roomId);
        if (data.status) {
            sendSusccessResponse(res, 200, data.message, data);
        } else {
            sendSusccessResponse(res, 420, data.message, data);
        }
    } catch (error) {
        handleErrorResponse(res, 500, error)
    }
});

// update a room for a branch with branchId and roomId
router.put('/updateRoom/:roomId', async (req, res) => {
    try {
        const updatedRoom = await controller.updateRoom(req.params.roomId, req.body);
        sendSusccessResponse(res, 201, 'Room updated successfully', updatedRoom);
    } catch (error) {
        handleErrorResponse(res, 500, error);
    }
});


module.exports = router;