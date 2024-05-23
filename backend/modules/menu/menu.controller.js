const database = require('../database');
const errors = require('../../utils/errors');
const { generateId } = require('../../utils/index');

async function findAll() {
    try {
        const sql = 'select * from menu;'
        const [result, _] = await database.query(sql);
        return result;
    } catch (error) {
        throw error;
    }
}


async function createAnItem(newItem) {
    try {

        const { Item, Cost, Item_photo } = newItem;
        const Item_ID = await generateId(3);

        const sqlCreateItem = 'insert into menu value (?, ?, ?, ?)';
        await database.query(sqlCreateItem, [Item, Item_ID, parseInt(Cost), Item_photo]);

        return await findAnItemInMenu(Item_ID);

    } catch (error) {
        throw error;
    }
}

async function updateAnItem(itemId, item) {
    try {
        const { Item, Cost, Item_photo } = item;
        const sql = 'update menu set Item = ?, Cost = ?, Item_photo = ? where Item_ID = ?';
        const result = await database.query(sql, [Item, parseInt(Cost), Item_photo, itemId]);
        return await database.query(`SELECT * FROM menu WHERE Item_ID = ?`, [itemId]).then(([result, field]) => result[0]);
    } catch (error) {
        throw error;
    }
}



async function findAnItemInMenu(Item_ID) {
    try {
        const sqlFindAnItem = 'select * from menu where Item_ID = ?';
        const [items, _] = await database.query(sqlFindAnItem, [Item_ID]);
        return items[0];
    } catch (error) {
        console.error(error);
        throw error;
    }
}


async function deleteAnItem(itemId) {
    try {
        return await database.query(`DELETE FROM menu WHERE Item_ID = ?`, [itemId])
            .then(([result, field]) => {
                if (result.affectedRows > 0) {
                    return {
                        status: true,
                        message: `Successfully removed item ${itemId}`
                    }
                } 
                return {
                    status: false,
                    message: `Failed to remove item ${itemId}`
                }
            })
            .catch(error => {
                throw error;
            })
    } catch (error) {
        throw error
    }
}

module.exports = {
    findAll,
    updateAnItem,
    createAnItem,
    findAnItemInMenu,
    deleteAnItem
}
