const { handleErrorResponse, updateRecordWithVariableFields, deleteRecordFromTable } = require('../../utils');
const database = require('../database');

async function findById(Customer_CCCD) {
    try {
        return await database.query(`SELECT * FROM customer WHERE Customer_CCCD = ?`, [Customer_CCCD])
            .then(([result, fields]) => result)
            .then(users => {
                if (users.length > 0) {
                    return users[0];
                } else {
                    console.log(false);
                    return null;
                }
            })
    } catch (error) {
        handleErrorResponse(res, 500, error);
    }
}

async function findAll() {
    try {
        return await database.query('select * from customer;')
            .then(([result, field]) => result)
            .catch(error => {
                throw error;
            });
            
    } catch (error) {
        throw error;
    }
}

async function updateCustomer(customerId, bodyUpdate) {
    try {
        return await updateRecordWithVariableFields({
            tableName: 'customer',
            identifiedColumns: ['Customer_CCCD'],
            recordIdentifications: [customerId],
            bodyUpdate: bodyUpdate
        })
    } catch (error) {
        throw error;
    }
}

async function deleteCustomer(Customer_CCCD) {
    try {
        return await deleteRecordFromTable({
            tableName: 'customer',
            identifiedColumns: ['Customer_CCCD'],
            recordIdentifications: Customer_CCCD
        })
    } catch (error) {
        throw error;
    }
}

module.exports = {
    findAll,
    findById,
    updateCustomer,
    deleteCustomer
}