const Sequelize = require("sequelize");
const connection = require("./database");

const Resposta = connection.define('resposta',{
    pergunta_id:{
        type: Sequelize.INTEGER,
        allowNull: false
    },
    corpo:{
        type: Sequelize.TEXT,
        allowNull: false
    }
});

Resposta.sync({force: false}).then(() => {});   // Cria tabela (se nao existir)

module.exports = Resposta;