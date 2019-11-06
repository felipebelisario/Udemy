const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const connection = require("./database/database");

const categoriesController = require("./categories/CategoriesController");
const articlesController = require("./articles/ArticlesController");

const Article = require("./articles/Article");
const Category = require("./categories/Category");

// View engine
app.set('view engine','ejs');

// Body parser
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

// Static files
app.use(express.static('public'));

// Database
connection
    .authenticate()
    .then(() => {
        console.log("Conexão feita com sucesso!");
    }).catch((error) => {
        console.log(error);
    });
    
app.use("/", categoriesController);     // Importando rotas de outro arquivo
app.use("/", articlesController);

app.get("/", (req, res) => {
    res.render("index");
});

app.listen(8080, () => {
    console.log("O servidor está rodando!");
});