const Sequelize = require("sequelize");

const connection = new Sequelize('guiaperguntas', 'root', 'fealbe1611@', {
    host: 'localhost',
    dialect: 'mysql'
});

module.exports = connection // Exportando conexao