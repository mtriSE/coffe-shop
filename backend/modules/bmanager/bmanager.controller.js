const database = require('../database');

exports.findById = async (req, res, next) => {
    await res.status(200).json({ message: `This controller function find bmanager by id ${req.params.id}` })
}

exports.findAll = async (req, res, next) => {
    await res.status(200).json({ message: `This controller function find all bmanager ` })
}