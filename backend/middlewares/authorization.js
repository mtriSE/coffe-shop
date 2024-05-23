const jwt = require('jsonwebtoken');

exports.verifyToken = function (req, res, next) {
    const authHeader = req.header('Authorization');
    const token = authHeader && authHeader.split(' ')[1];   // Bearer and Token
    if (!token) {
        // neu khong co token, tuc la unauthorized
        res.sendStatus(401);
    }

    try {
        const decoded = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
        res.locals.decoded = decoded;
        next();
    } catch (error) {
        console.error(error);
        res.sendStatus(403);
    }
}
