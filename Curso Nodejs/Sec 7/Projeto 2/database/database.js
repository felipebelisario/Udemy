const Sequelize = require("sequelize");

const connection = new Sequelize('rollupblog','root','fealbe1611@',{
    host: 'localhost',
    dialect: 'mysql',
    timezone: "-03:00"
});

module.exports = connection;

