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

exports.createRoom = async function createRoom(branchId, body) {
    try {
        const Br_ID = branchId;
        const { Room_ID, Status, Room_type_ID } = body;
        const sql = `INSERT INTO room VALUE (?,?,?,?)`;
        const [rooms, fields] = await db.query(sql, [Room_ID, Status, Br_ID, Room_type_ID]);
        return { rooms, fields };
    } catch (error) {
        throw error;
    }
}

exports.deleteRoom = async function deleteRoom(branchId, roomId) {
    try {
        const sql = `DELETE FROM room WHERE Br_ID = ? and Room_ID = ? `;
        const [rooms, fields] = await db.query(sql, [branchId, roomId]);
        return { rooms, fields };
    } catch (error) {
        throw error;
    }
}

exports.updateRoom = async function updateRoom(branchId, roomId, body) {
    try {
        const { Status, Room_type_ID } = body;
        const sql = "UPDATE room SET `Status` = ?, `Room_type_ID` = ? WHERE `Room_ID` = ? AND `Br_ID` = ?;"
        const [rooms, fields] = await db.query(sql, [Status, Room_type_ID, roomId, branchId]);
        return { rooms, fields };
    } catch (error) {
        throw error;
    }
}