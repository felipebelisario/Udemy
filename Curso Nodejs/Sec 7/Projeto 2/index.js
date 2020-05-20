const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const session = require("express-session");
const connection = require("./database/database");
const isLogged = require("./middlewares/adminauth");

const categoriesController = require("./categories/CategoriesController");
const articlesController = require("./articles/ArticlesController");
const usersController = require("./users/UsersController");

const Article = require("./articles/Article");
const Category = require("./categories/Category");
const User = require("./users/User");

// View engine
app.set('view engine','ejs');

// Sessions
app.use(session({
    secret: "laskfldskfsld",
    cookie: {
        maxAge: 600000
    }
}));

// Redis -> Sistemas de medio e grande porte (banco de dados para sessoes)

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
app.use("/", usersController);

app.get("/", (req, res) => {
    Article.findAll({
        order: [
            ['id', 'DESC']
        ],
        limit: 2
    }).then(articles => {

        Category.findAll().then(categories => {
            if(req.session.user == undefined){
                res.render("index", {articles: articles, categories: categories});
            } else {
                res.render("index_logged", {articles: articles, categories: categories});
            }
        });
    });
});

app.get("/:slug", (req, res) => {
    var slug = req.params.slug;

    Article.findOne({
        include: [{model: Category}],
        where: {
            slug: slug
        }
    }).then(article => {
        if(article != undefined){
            Category.findAll().then(categories => {
                res.render("article", {article: article, categories: categories});
            });
        } else{
            res.redirect("/")
            alert("Arquivo não encontrado!");
        }
    }).catch(err => {
        res.redirect("/")
        alert("Erro ao acessar o arquivo")
    });
});

app.get("/category/:slug", (req, res) => {
    var slug = req.params.slug;

    Category.findOne({
        where: {
            slug: slug
        },
        include: [{model: Article}]
    }).then(category => {
        if(category != undefined){
            
            Category.findAll().then(categories => {
                res.render("index_category", {articles: category.articles, categories: categories, category: category.title})
            })

        } else{
            res.redirect("/");
        }
    }).catch(err => {
        res.redirect("/");
    })
});

app.listen(8080, () => {
    console.log("O servidor está rodando!");
});