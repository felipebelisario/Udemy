const Sequelize = require("sequelize");
const connection = require("../database/database");

const User = connection.define('users', {
    email:{
        type: Sequelize.STRING,
        allowNull: false
    },
    password:{
        type: Sequelize.STRING,
        allowNull: false
    }
});

// User.sync({force: false});      Se a tabela ja existir nao recria ela (tirar depois que
//                                 a tabela for criada)

module.exports = User;