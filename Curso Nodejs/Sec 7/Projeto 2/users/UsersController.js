const express = require("express");
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const isLogged = require("../middlewares/adminauth");
const router = express.Router();
const User = require("./User");

let transporter = nodemailer.createTransport({
    host: "smtp.live.com",
    port: 587,
    secureConnection: false,
    auth: {
        user: "felipebelisario2015@hotmail.com",
        pass: "fealbe1611@"
    }
});

router.get("/admin/users", isLogged, (req, res) => {
    User.findAll().then(users => {
        res.render("admin/users/index", {users: users});
    });
});

router.get("/signin", (req, res) => {
    res.render("admin/users/create");
});

router.post("/users/create", (req, res) => {
    var email = req.body.email;
    var password = req.body.password;

    User.findOne({where:{email: email}}).then(user => {
        if(user == undefined && password != ""){

            transporter.sendMail({
                from: "Rollup Blog <felipebelisario2015@hotmail.com>",
                to: email,
                subject: "[Rollup Blog] Bem-vindo!",
                text: "Seja bem-vindo ao nosso blog! Sinta-se a vontade para postar artigos e ler" +
                " os de outras pessoas!"
            }).then(message => {
                console.log(message);
            }).catch(err => {
                console.log(err);
            });

            var salt = bcrypt.genSaltSync(10);
            var hash = bcrypt.hashSync(password, salt);

            User.create({
                email: email,
                password: hash
            }).then(() => {
                res.redirect("/");
            }).catch((err) => {
                res.redirect("/");
            })

            User.findOne({where:{email: email}}).then(user => {
                
                req.session.user = {
                    user: user.id,
                    email: user.email
                }
                        
                res.redirect("/");
        
            });

        } else{
            res.redirect("/signin");
        }
    });
});

router.get("/login", (req, res) => {
    res.render("admin/users/login");
});

router.post("/authenticate", (req, res) => {
    var email = req.body.email;
    var password = req.body.password;

    User.findOne({where:{email: email}}).then(user => {
        if(user != undefined){
            var correct = bcrypt.compareSync(password, user.password);

            if(correct){
                req.session.user = {
                    user: user.id,
                    email: user.email
                }
                
                res.redirect("/");

            } else {
                res.render("admin/users/login_incorrect");
            }

        } else {
            res.render("admin/users/login_incorrect");
        }
    });

});

router.get("/logout", isLogged, (req, res) => {
    req.session.user = undefined;

    res.redirect("/");
});

module.exports = router;