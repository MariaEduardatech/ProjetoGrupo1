var usuarioModel = require("../models/usuarioModel");

function autenticar(req, res) {

    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                        usuarioModel.buscarPerfil(resultadoAutenticar[0].idUsuario)
                            .then((resultadoPerfil) => {
                                if (resultadoPerfil.length > 0) {
                                    res.json({
                                        id: resultadoAutenticar[0].idUsuario,
                                        email: resultadoAutenticar[0].email,
                                        nome: resultadoAutenticar[0].nome,
                                        cargo: resultadoAutenticar[0].cargo,
                                        idDaEmpresa: resultadoAutenticar[0].fk1Empresa
                                    });
                                }
                            })
                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var NomeEmpresa = req.body.nomeEmpresaServer;
    var Email = req.body.emailServer;
    var rua = req.body.ruaServer;
    var bairro = req.body.nomeEmpresaServer;
    var numero = req.body.numeroServer;
    var sigla = req.body.siglaServer;
    var cidade = req.body.cidadeServer;
    var cnpj = req.body.cnpjServer;
    var codigo = req.body.codigoServer;

    // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
    usuarioModel.cadastrar(codigo, NomeEmpresa, cnpj, Email, rua, bairro, cidade, numero, sigla)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function cadastrarUsuario(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var NomeUsuario = req.body.nomeServer;
    var EmailUsuario = req.body.emailServer;
    var telefoneUsuario = req.body.telefoneServer;
    var cargo = req.body.cargoServer;
    var senha = req.body.senhaServer;
    var codigo = req.body.codigoServer;

    // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
    usuarioModel.cadastrarUsuario(codigo, NomeUsuario, telefoneUsuario, EmailUsuario, senha, cargo)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function BuscarEmpresa(req, res) {

    usuarioModel.BuscarEmpresa().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado); 
        } else {
            res.status(204).send("Nenhuma empresa encontrada!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as empresas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function BuscarAlertas(req, res) {

    var idEmpresa = req.params.idDaEmpresa;

    usuarioModel.BuscarAlertas(idEmpresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado); 
        } else {
            res.status(204).send("Nenhum alerta encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os alertas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    autenticar,
    cadastrar,
    cadastrarUsuario,
    BuscarEmpresa,
    BuscarAlertas
}