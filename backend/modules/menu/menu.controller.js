const database = require('../database');
const errors = require('../../utils/errors');

async function findAll() {
    try {
        const sql = 'select * from meu;'
        const [result, _] = await database.query(sql);
        return result;
    } catch (error) {
        throw new errors.InternalServerError();
    }
}


async function createAnItemAtBranch(branchId, newItem) {
    try {

        const firstSqlFindCCCD = 'select Bmgr_CCCD from branch where Br_ID = ?';
        const [CCCDs, _] = await database.query(firstSqlFindCCCD, [branchId]);

        if (CCCDs.length === 0) {
            throw new errors.NotFound('Not found branch with id: ' + branchId);
        }
        const Bmgr_CCCD = CCCDs[0].Bmgr_CCCD;

        const { Item, Item_ID, Cost, Item_photo } = newItem;

        const sqlCreateItem = 'insert into menuvalue (?, ?, ?, ?, ?)';
        await database.query(sqlCreateItem, [Bmgr_CCCD, Item, Item_ID, parseInt(Cost), Item_photo]);

        return await _findAnItemInMenu(Item_ID);

    } catch (error) {
        throw new errors.InternalServerError();
    }
}

async function updateAnItem(itemId, item) {
    try {
        const { Item, Cost, Item_photo } = item;
        const sql = 'update menu set Item = ?, Cost = ?, Item_photo = ? where Item_ID = ?';
        const result = await database.query(sql, [Item, parseInt(Cost), Item_photo, itemId]);
        return result;
    } catch (error) {
        throw new errors.InternalServerError();
    }
}

async function findAllOfBranch(branchId) {
    try {
        const availableBranch = (await _findAllAvailableBranches()).map(branch => branch.Br_ID);
        if (availableBranch.includes(branchId)) {
            const sql = `select 
                    menu.Item, menu.Item_ID, menu.Cost, menu.Item_photo 
                    from menu join br_manager on menu.Bmgr_CCCD = br_manager.Bmgr_CCCD join branch on br_manager.Bmgr_CCCD = branch.Bmgr_CCCD 
                    where branch.Br_ID = ?;`
            const [result, _] = await database.query(sql, [branchId]);
            return result;
        } else {
            throw new errors.NotFound('Not found branch with id ' + branchId);
        }
    } catch (error) {
        throw new errors.InternalServerError();
    }
}

async function _findAllAvailableBranches() {
    try {
        const sqlToFindAllBranchId = `select Br_ID from branch where Status = 'A'`;
        const [result, _] = await database.query(sqlToFindAllBranchId);
        return result;
    } catch (error) {
        console.error(error);
        throw new errors.InternalServerError();
    }
}

async function _findAnItemInMenu(Item_ID) {
    try {
        const sqlFindAnItem = 'select * from menu where Item_ID = ?';
        const [items, _] = await database.query(sqlFindAnItem, [Item_ID]);
        return items[0];
    } catch (error) {
        console.error(error);
        throw new errors.InternalServerError();
    }
}

module.exports = {
    findAll,
    findAllOfBranch,
    updateAnItem,
    createAnItemAtBranch
}
