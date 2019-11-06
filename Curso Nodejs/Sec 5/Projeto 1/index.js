// express (web framework [http]) --> npm install express --save
// ejs (renderizador de HTML para o Nodejs) --> npm install ejs --save
// body-parser (pegar dados do formulario) --> npm install body-parser --save
// sequelize (manipulacao do banco de dados) --> npm install sequelize --save
//      sequelize trabalhar com MySQL --> npm install mysql2 --save

const express = require("express"); // Importando o express
const app = express();  // Iniciando o express
const bodyParser = require("body-parser");
const connection = require("./database/database");

const Pergunta = require("./database/Pergunta");
const Resposta = require("./database/Resposta");

// Database

connection
    .authenticate()
    .then(() => {               // Se a autenticacao ocorrer com sucesso
        console.log("Conexão feita com o banco de dados!");
    })
    .catch((msgErro) => {       // Se falhar
        console.log(msgErro);
    })

// Usar EJS como view engine (renderizador de HTML) com .ejs da pasta "views"
app.set('view engine', 'ejs');

// Usar arquivos estáticos da pasta especificada
app.use(express.static('public'));

// Decodificar do formulario (body-parser)
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

// Rotas
app.get("/",(req,res) => {

    Pergunta.findAll({raw: true, order:[
        ['id','DESC']
    ]}).then(perguntas => {
        res.render("index",{
            perguntas: perguntas
        });
    })

    // Renderiza o arquivo HTML especificado (da pasta views)
    
});

app.get("/perguntar",(req,res) => {
    // Renderiza o arquivo HTML especificado (da pasta views)
    res.render("perguntar");
});

app.post("/salvarpergunta", (req,res) => {
    var titulo = req.body.titulo;
    var descriao = req.body.descricao;

    Pergunta.create({
        titulo: titulo,
        descricao: descriao
    }).then(() => {
        res.redirect("/");
    });

});

app.get("/pergunta/:id", (req,res) => {
    var id = req.params.id;

    Pergunta.findOne({
        where: {id: id}
    }).then(pergunta => {
        if(pergunta != undefined){  // Pergunta encontrada

            Resposta.findAll({
                where: {pergunta_id: pergunta.id},
                order: [
                    ['id','DESC']
                ]
            }).then(resposta => {
                res.render("pergunta",{
                    pergunta: pergunta,
                    resposta: resposta
                });
            });

            
        } else{     // Pergunta nao encontrada
            res.redirect("/");
        }
    });
});

app.post("/responder", (req,res) => {
    var corpo = req.body.corpo;
    var pergunta_id = req.body.pergunta_id;

    Resposta.create({
        pergunta_id: pergunta_id,
        corpo: corpo
    }).then(() => {
        res.redirect("/pergunta/" + pergunta_id);
    });
});

app.listen(8080,(erro) => {
    if(erro){
        console.log("Ocorreu um erro!");
    }else{
        console.log("Servidor iniciado com sucesso!");
    }
})