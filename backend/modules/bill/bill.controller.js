const _ = require('lodash');
const db = require('../database');
const { generateId, createARecord } = require('../../utils/index');
const { findAnItemInMenu } = require('../menu/menu.controller');

exports.findAllBills = async () => {
    try {
        return await db.query(`SELECT bill.Bill_ID, bill.Customer_CCCD, bill.Total, bill.Time_paid, bill.room_ID FROM bill`)
            .then(([bills, fields]) => bills)
            .then(bills => _.map(bills, bill => db.query(`SELECT menu.Item, detail.Amount FROM detail JOIN menu on detail.Item_ID = menu.Item_ID WHERE detail.Bill_ID = ?`, [bill.Bill_ID])
                .then(([results, fields]) => results)
                .then(items => {
                    return 1
                }))
            )
            .catch(err => {
                throw err;
            })

        console.log(bills);
        return bills;

        const billIds = _.map(bills, bill => bill.Bill_ID);
        return bills;
        // const items = await db.query

        bills.map(bill => {
            return db.query(`SELECT menu.Item, detail.Amount FROM detail JOIN menu on detail.Item_ID = menu.Item_ID WHERE detail.Bill_ID = ?`, [bill.Bill_ID])
                .then(([results, fields]) => results)
                .then((items) => {
                    return {
                        ...bill,
                        items: items
                    }
                })
        })

    } catch (error) {
        throw error;
    }
}

const _findAmoutOfEachItem = async (itemId) => {
    return await 
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