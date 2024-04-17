const database = require('../database');

exports.findById = async (req, res, next) => {
    res.status(200).json({ message: `This controller function find staff by id ${req.params.id}` })
}

exports.findAll = async (req, res, next) => {
    res.status(200).json({ message: `This controller function find all staff` })
}