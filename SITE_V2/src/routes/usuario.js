var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
})

router.post("/cadastrarUsuario", function (req, res) {
    usuarioController.cadastrarUsuario(req, res);
})

router.post("/autenticar", function (req, res) {
    usuarioController.autenticar(req, res);
});

router.get("/BuscarEmpresa", function (req, res) {
    usuarioController.BuscarEmpresa(req, res);
})

router.get("/BuscarAlertas/:idDaEmpresa", function (req, res) {
    usuarioController.BuscarAlertas(req, res);
})

router.get("/BuscarDados/:idDaEmpresa", function (req, res) {
    usuarioController.BuscarDados(req, res);
})


router.get ("/BuscarRegistro/:idDaEmpresa", function(req, res) {
    usuarioController.BuscarRegistro(req, res);
})

module.exports = router;