var database = require("../database/config")

function buscarPerfil(idUsuario){

    var instrucaoSql = `SELECT * FROM usuario WHERE idUsuario = ${idUsuario}`;
  
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
  }

function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT idUsuario, fk1Empresa, nome, email, cargo FROM usuario WHERE email = '${email}' AND senha = '${senha}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// Coloque os mesmos parâmetros utilizados na Controller. Vá para a var instrucaoSql
function cadastrar(codigo, NomeEmpresa, cnpj, Email, rua, bairro, cidade, numero, sigla) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", codigo, NomeEmpresa, cnpj, Email, rua , bairro, cidade, numero, sigla);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO empresa (idEmpresa, nome, cnpj, email, rua, bairro, cidade, numero, UF) VALUES ('${codigo}','${NomeEmpresa}','${cnpj}', '${Email}', '${rua}', '${bairro}', '${cidade}', '${numero}', '${sigla}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrarUsuario(codigo, NomeUsuario, telefoneUsuario, EmailUsuario, senha, cargo) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", NomeUsuario, telefoneUsuario, EmailUsuario, senha, cargo);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO usuario (fk1Empresa, nome, telefone, email, senha, cargo) VALUES ('${codigo}', '${NomeUsuario}','${telefoneUsuario}', '${EmailUsuario}', '${senha}', '${cargo}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function BuscarEmpresa(){
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function BuscarEmpresa():");

    var instrucaoSql = `
        SELECT idEmpresa FROM empresa;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function BuscarAlertas(idEmpresa){
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function BuscarAlertas():");

    var instrucaoSql = `
        SELECT nivel, porcentagemUmidade FROM registro JOIN sensor ON fk2Sensor = idSensor JOIN empresa ON fk2empresa = idEmpresa WHERE idEmpresa = ${idEmpresa} AND nivel = "Umidade baixa" OR nivel = "Umidade elevada";
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    buscarPerfil,
    cadastrar,
    cadastrarUsuario,
    BuscarEmpresa,
    BuscarAlertas
};