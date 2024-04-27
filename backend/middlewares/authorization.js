const jwt = require('jsonwebtoken');

function verifyToken(req, res, next) {
    const authHeader = req.header('Authorization');
    const token = authHeader && authHeader.split(' ')[1];   // Bearer and Token
    if (!token) {
        // neu khong co token, tuc la unauthorized
        res.sendStatus(401);
    }

    try {
        const decoded = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
        console.log(decoded);

        req.userId = decoded.id;

        // Xac thuc xong, co the di tiep
        next();
    } catch (error) {
        console.error(error);
        res.sendStatus(403);
    }
}

module.exports = {
    verifyToken
}