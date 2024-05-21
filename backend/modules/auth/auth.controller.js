const database = require('../database');
const { hashPassword } = require('../../utils/index');
const jwt = require('jsonwebtoken');
const userController = require('../customer/customer.controller');

exports.login = async function (req, res) {
    const User_ID = req.body.User_ID;
    const Password = req.body.Password;

    const sql = 'select * from account where User_ID = ?';
    try {
        const [foundUser, fields] = await database.query(sql, [User_ID]);

        if (foundUser.length === 0) {
            return res.status(401).json({
                statusCode: 401,
                message: 'Không tồn tại tài khoản.'
            })
        } else {
            const user = foundUser[0];
            const isPasswordValid = (await hashPassword(Password)) == user.Password;
            if (!isPasswordValid) {
                return res.status(401).json({
                    statusCode: 401,
                    message: 'Mật khẩu không chính xác'
                })
            }
            const accessTokenSecret = process.env.ACCESS_TOKEN_SECRET;
            const accessTokenLife = process.env.ACCESS_TOKEN_LIFE;

            const dataForAccessToken = {
                User_ID: user.User_ID,
                Username: user.Username,
                Role: user.Role,
            }

            const accessToken = await jwt.sign(dataForAccessToken, accessTokenSecret);

            if (!accessToken) {
                return res.status(500).json({
                    statusCode: 500,
                    message: 'Đăng nhập không thành công, vui lòng thử lại'
                })
            }

            res.status(200).json({
                statusCode: 200,
                message: 'Login successful',
                data: { accessToken }
            })

        }

    } catch (error) {
        throw error;
    }
}

exports.register = async function register(req, res) {
    const { account, userInfo } = req.body;
    const { User_ID, Password, Username, Avatar } = account;
    const Role = 'Customer';
    const { Fname, Lname, Phone, Email } = userInfo;
    try {

        const foundUserWithCCCD = await userController.findById(User_ID);
        if (foundUserWithCCCD) {
            return res.status(409).json({
                statusCode: 409,
                message: `Tồn tại người dùng có CCCD ${User_ID} trong hệ thống`
            });
        }

        const sqlInsertAccount = 'INSERT INTO account(`User_ID`, `Password`, `Username`, `Role`, `Avatar`) VALUE (?, ?, ?, ?, ?);';
        const sqlInsertCustomer = 'INSERT INTO customer(`Customer_CCCD`,`Fname`,`Lname`,`Phone`,`Email`) VALUE (?, ?, ?, ?, ?);';

        const [accountsInserted, _] = await database.query(sqlInsertCustomer, [User_ID, Fname, Lname, Phone, Email]);
        await database.query(sqlInsertAccount, [User_ID, Password, Username, Role, Avatar]);

        if (accountsInserted.affectedRows > 0) {
            return res.status(201).json({
                statusCode: 201,
                message: 'Đăng kí thành công',
                data: {
                    account: accountsInserted[0]
                }
            })
        }

    } catch (error) {
        throw error;
    }
}

exports.logout = async function logout(req, res) {
    console.log('Chua lam')
}
