const mysql = require('mysql2');

const pool = mysql.createPool({
    host: process.env.MYSQL_SERVER_HOST,
    user: process.env.MYSQL_SERVER_USER,
    password: process.env.MYSQL_SERVER_PASSWORD,
    database: process.env.MYSQL_SERVER_DATABASE,
    charset: 'utf8'
}).promise();

module.exports = pool;