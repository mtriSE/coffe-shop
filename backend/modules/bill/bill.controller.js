const db = require('../database');
const { generateId, createARecord } = require('../../utils/index');
const { findAnItemInMenu } = require('../menu/menu.controller');

exports.findBills = async (userId) => {
    try {
        const bills = await db.query(userId ? `SELECT * FROM bill WHERE Customer_CCCD = '${userId}';` : `SELECT * FROM bill;`)
            .then(([results, _]) => results)
            .then(bills => {
                return Promise.all(bills.map(bill => {
                    return db.query(`SELECT menu.Item, detail.amount FROM detail JOIN menu ON detail.Item_ID = menu.Item_ID WHERE detail.Bill_ID = ?`, [bill.Bill_ID])
                        .then(([results, _]) => results)
                        .then(items => {
                            return {
                                ...bill,
                                Item: items
                            }
                        })
                        .catch(err => {
                            throw err;
                        })
                }));
            })
            .catch(err => {
                throw err;
            });
        return bills;
    } catch (error) {
        throw error;
    }
}


exports.createOneBill = async ({ customer_CCCD, itemsPurchased, roomId, total, Bmgr_CCCD }) => {
    try {
        const Bill_ID = await generateId(10);

        if (roomId) {
            const roomStatus = db.query(`SELECT Status FROM room WHERE Room_ID = ?`, [roomId])
                .then(([result, field]) => result[0])
                .catch(error => {
                    throw error;
                });

            if (roomStatus !== 'A') {
                await db.query(`UPDATE room SET Status = 'U' WHERE Room_ID = ?`, [roomId])
                    .then(([result, field]) => result)
                    .catch(error => {
                        throw error;
                    })

            } else {
                return {
                    result: false,
                    message: "Phòng này hiện tại đang không sẵn sàng để đặt, vui lòng chọn phòng khác"
                }
            }
        }

        // create a new bill
        await db.query(`INSERT INTO bill VALUE (?,?,?,?,?);`, [Bill_ID, parseInt(total), Bmgr_CCCD, customer_CCCD, roomId ? roomId : null])
            .then(([result, field]) => result)
            .catch(error => {
                throw error;
            })

        // insert into detail of that bill
        const toInsertDetail = itemsPurchased.reduce((accumulator, item) =>
            accumulator += `('${Bill_ID}', ${parseInt(item.Amount)}, '${item.Item_ID}'),`
            , []).slice(0,-1);

        await db.query(`INSERT INTO detail VALUES ${toInsertDetail};`);

    } catch (error) {
        throw error;
    }
}