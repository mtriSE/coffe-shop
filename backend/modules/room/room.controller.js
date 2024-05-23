const { updateRecordWithVariableFields } = require('../../utils');
const db = require('../database');

exports.getAllRoom = async function getAllRoom() {
    try {
        const sql = `select * from room;`;
        const [rooms, fields] = await db.query(sql);
        return rooms;
    } catch (error) {
        throw error;
    }
}

exports.getAllRoomOfBranch = async function getAllRoomOfBranch(req, res) {
    try {
        const sql = `select * from room where Br_ID = ?`;
        const [rooms, fields] = await db.query();
        return rooms;
    } catch (error) {
        throw error;
    }
}

exports.createRoom = async function createRoom(body) {
    try {
        const Br_ID = 1;
        const { Room_ID, Status, Room_type_ID } = body;
        const sql = `INSERT INTO room VALUE (?,?,?,?)`;
        const [rooms, fields] = await db.query(sql, [Room_ID, Status, Br_ID, Room_type_ID]);
        if (rooms.affectedRows > 0) {
            const returnedRoom = await db.query(`SELECT * FROM room WHERE Room_ID = ?`, [Room_ID]).then(([room, field]) => room);
            return returnedRoom;
        } else {
            return null;
        }
    } catch (error) {
        throw error;
    }
}

exports.deleteRoom = async function deleteRoom(roomId) {
    try {
        const sql = `DELETE FROM room WHERE Br_ID = 1 and Room_ID = ? `;
        return await db.query(sql, [roomId])
            .then(([result, field]) => {
                if (result.affectedRows > 0) {
                    return {
                        status: true,
                        message: `Successfully removed item ${roomId}`
                    }
                }
                return {
                    status: false,
                    message: `Failed to remove item ${roomId}`
                }
            })
            .catch(error => {
                throw error;
            });
    } catch (error) {
        throw error;
    }
}

exports.updateRoom = async function updateRoom(roomId, body) {
    try {
        return await updateRecordWithVariableFields({
            tableName: 'room',
            identifiedColumns: ['Room_ID'],
            recordIdentifications: [roomId],
            bodyUpdate: body
        });
    } catch (error) {
        throw error;
    }
}