const crypto = require('crypto');
const { v4: uuid4 } = require('uuid');
const database = require('../modules/database');

exports.hashPassword = async (password) => {
    const hash = crypto.createHash('sha256');
    hash.update(password);
    return hash.digest('hex');
}

exports.generateId = async (length) => {
    const test = await uuid4().toString().slice(0, length);
    return test;
}

exports.sendSusccessResponse = (res, statusCode, message, data) => {
    return res.status(statusCode).json({
        statusCode,
        message,
        data
    });
}


exports.handleErrorResponse = (res, statusCode, error) => {
    console.error(error);
    return res.status(statusCode).json({
        statusCode,
        message: error
    })
}

exports.updateRecordWithVariableFields = ({ tableName, identifiedColumns, recordIdentifications, bodyUpdate }) => {
    try {
        return database.query(`DESCRIBE ${tableName}`)
            .then(([columns, fields]) => columns.map(column => column.Field))
            .then((columnNames) => {
                const fieldsToUpdate = Object.keys(bodyUpdate);

                let updateQuery = `UPDATE ${tableName} SET `;
                let args = [];

                let hasFieldToUpdate = false;

                updateQuery = fieldsToUpdate
                    .filter(field => {
                        if (columnNames.includes(field)) {
                            // console.log(`field: ${field}`);
                            args.push(bodyUpdate[field]);
                            // console.log(`args: ${args}`);
                            return true;
                        }
                    })
                    .reduce((updateQuery, field) => {
                        hasFieldToUpdate = true;
                        return updateQuery + `${field} = ?, `
                    }, updateQuery)
                    .slice(0, hasFieldToUpdate ? -2 : undefined);


                updateQuery += ` WHERE ` + identifiedColumns.map(columnName => columnName + ' = ? ').join('AND ');
                recordIdentifications.map(id => args.push(id));

                return { updateQuery, args };
            })
            .then(({ updateQuery, args }) => {
                return database.query(updateQuery, args)
                    .then(([rows, fields]) => rows)
                    .catch(err => {
                        throw err
                    });
            })
            .then((_) => {
                return database.query(`SELECT * FROM ${tableName} WHERE ${identifiedColumns.map(column => column + ' = ? ').join('AND ')}`, recordIdentifications)
                    .then(([rows, fields]) => rows[0])
                    .catch(err => {
                        throw err;
                    })
            })
            .catch(err => {
                throw err;
            })
    } catch (error) {
        throw error;
    }
}

exports.deleteRecordFromTable = ({ tableName, identifiedColumns, recordIdentifications }) => {
    try {
        return database.query(`SELECT * FROM ${tableName} WHERE ${identifiedColumns.map(column => column + ' = ? ').join('AND ')}`, recordIdentifications)
            .then(([rows, fields]) => rows[0])
            .then((deletedRecords) => {
                database.query(`DELETE FROM ${tableName} WHERE ${identifiedColumns.map((column) => column + ' = ? ').join('AND ')}`,
                    recordIdentifications)
                    .then((_) => deletedRecords)
                    .catch(err => {
                        throw err;
                    });
            })
            .catch(err => {
                throw err;
            });
    } catch (error) {
        throw error;
    }
}