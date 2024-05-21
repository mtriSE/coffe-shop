const db = require('../database');
const { generateId, createARecord } = require('../../utils/index');

exports.findAllBills = async () => {
    try {
        return db.query(`SELECT * FROM bill`).then((bills, fields) => {
            return bills
        });
    } catch (error) {
        throw error;
    }
}

exports.createOneBill = async ({ itemsPurchased, roomId, total }) => {
    try {
        const Bill_ID = await generateId(6);
        const newTotal = total;
        const newRoomId = roomId ? roomId : null;
        return {
            newTotal,
            newRoomId
        }
    } catch (error) {
        throw error;
    }
}