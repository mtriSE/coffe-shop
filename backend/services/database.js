const mysql = require('mysql');
const pool = mysql.createPool({
    host: process.env.MYSQL_SERVER_HOST,
    user: process.env.MYSQL_SERVER_USER,
    database: process.env.MYSQL_SERVER_DATABASE_NAME,
    password: process.env.MYSQL_SERVER_PASSWORD,
    charset: 'utf8',
})

module.exports = pool;