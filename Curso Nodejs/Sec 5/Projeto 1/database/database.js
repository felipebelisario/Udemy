const Sequelize = require("sequelize");

const connection = new Sequelize('guiaperguntas', 'root', 'Aqui é a senha (tirei pq essa é minha senha de vdd pra tudo KADJFSKD)', {
    host: 'localhost',
    dialect: 'mysql'
});

module.exports = connection // Exportando conexao