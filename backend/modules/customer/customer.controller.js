const database = require('../database');

async function findById() {
    try {
        await res.status(200).json({ message: `This controller function find user by id ${req.params.id}` })
    } catch (error) {
        throw Error(error);
    }
}

async function findAll() {
    try {
        const [data, metadata] = await database.query('select * from data;');
        console.log(data);
        console.log('------');
        console.log(metadata);

// 


// return 

        await res.status(200).json({ message: `This controller function find all user ` })
    } catch (error) {
        throw Error(error);
    }
}

async function createCustomer() {
    try {
        const body = req.body;
        console.log(body);
        res.status(200).json(body);
    } catch (error) {
        throw Error(error);
    }
}

async function updateCustomer() {
    try {
        console.log('this function update customer');
        res.status(200).json(req.body);
    } catch (error) {
        throw Error(error);
    }

}

module.exports = {
    findAll,
    findById,
    createCustomer,
    updateCustomer
}