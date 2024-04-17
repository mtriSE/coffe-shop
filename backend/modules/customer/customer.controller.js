const database = require('../database');

exports.findById = async (req, res, next) => {
    try {
        await res.status(200).json({ message: `This controller function find user by id ${req.params.id}` })
    } catch (error) {
        throw Error(error);
    }
}

exports.findAll = async (req, res, next) => {
    try {
        const [data, metadata] = await database.query('select * from data;');
        console.log(data);
        console.log('------');
        console.log(metadata);
        await res.status(200).json({ message: `This controller function find all user ` })
    } catch (error) {
        throw Error(error);
    }
}

exports.createCustomer = async (req, res, next) => {
    try {
        const body = req.body;
        console.log(body);
        res.status(200).json(body);
    } catch (error) {
        throw Error(error);
    }
}

exports.updateCustomer = async (req, res, next) => {
    try {
        console.log('this function update customer');
        res.status(200).json(req.body);
    } catch (error) {
        throw Error(error);
    }
    
}