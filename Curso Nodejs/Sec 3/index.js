const express = require("express"); // Importando o express
const app = express();  // Iniciando o express

// Rota inicial (Home)
app.get("/",function(req,res){
    res.send("Fala meu confrade!");
});   
app.get("/blog",function(req,res){
    res.send("Aqui é o blog!!!");
});

// Usuario envia (obrigatoriamente) dados junto com rota /enterName por parametro
app.get("/enterName/:name/:empresa",function(req,res){
    res.send("<h2>Olá " + req.params.name + " da " +
        req.params.empresa + "!</h2>");
});

// Usuario envia (não obrigatoriamente) dados junto com rota /enterName por parametro
app.get("/enterName2/:name?",function(req,res){

    var nome = req.params.name;

    if(nome){
        res.send("<h2>Olá " + nome + "!</h2>");
    }else{
        res.send("<h2>Olá anônimo!</h2>");
    }

});

app.get("/queryParams",function(req,res){
    var query = req.query["nome"];
    res.send(query);
});



app.listen(4000,function(erro){
    if(erro){
        console.log("Ocorreu um erro!");
    }else{
        console.log("Servidor iniciado com sucesso!");
    }
})