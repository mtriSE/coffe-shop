const database = require('../database');
const { updateRecordWithVariableFields, deleteRecordFromTable } = require('../../utils/index');

exports.findAll = async () => {
    try {
        const sql = `select * from staff;`
        const [staffs, fields] = await database.query(sql);
        return staffs;
    } catch (error) {
        throw error;
    }
}

exports.createOneStaff = async (branchId, body) => {
    try {
        const { Staff_CCCD, ...otherData } = body;
        return {
            branchId,
            Staff_CCCD,
            otherData
        }
    } catch (error) {
        throw error;
    }
}

exports.deleteStaff = async (staffId) => {
    try {
        return await deleteRecordFromTable({
            tableName: 'staff',
            identifiedColumns: ['Staff_CCCD'],
            recordIdentifications: [staffId]
        })
    } catch (error) {
        throw error;
    }
}

exports.updateStaff = async (staffId, bodyUpdate) => {
    try {
        return await updateRecordWithVariableFields({
            tableName: 'staff',
            identifiedColumns: ['Staff_CCCD'],
            recordIdentifications: [staffId],
            bodyUpdate: bodyUpdate
        });
    } catch (error) {
        throw error;
    }
}

exports.findAllStaffOfBranch = async (branchId) => {
    try {
        const sql = `SELECT * FROM staff where Br_ID = ?`;
        const [rows, fields] = await database.query(sql, [branchId]);
        return rows;
    } catch (error) {
        throw error;
    }
}

exports.findById = async (staffId) => {
    try {
        const sql = ` select * from staff join branch on staff.Br_ID = branch.Br_ID join account on staff.Staff_CCCD = account.User_ID where staff.Staff_CCCD = ?;`;
        const [rows, fields] = await database.query(sql, [staffId]);
        return rows;
    } catch (error) {
        throw error;
    }
}
