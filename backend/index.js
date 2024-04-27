require('dotenv').config({ path: '.env' })
const express = require('express');
const cors = require('cors');
const app = express();
const authRoute = require('./modules/auth/auth.router');
const customerRoute = require('./modules/customer/customer.router');
const staffRoute = require('./modules/staff/staff.router');
const bmanagerRoute = require('./modules/bmanager/bmanager.router');
const managerRoute = require('./modules/manager/manager.router');
const menuRoute = require('./modules/menu/menu.router');

app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(cors({
    origin: '*'
}))
app.get('/', (req, res) => {
    res.status(200).send('<h1>hello world</h1>');
});


app.use('/auth', authRoute);
app.use('/customer', customerRoute);
app.use('/staff', staffRoute);
app.use('/bmanager', bmanagerRoute);
app.use('/manager', managerRoute);
app.use('/menu', menuRoute);

app.listen(process.env.NODE_SERVER_PORT, () => {
    console.info('listening on port ' + process.env.NODE_SERVER_PORT)
})