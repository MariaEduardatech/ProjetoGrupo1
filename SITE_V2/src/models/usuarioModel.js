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
    
    var instrucaoSql = `
        INSERT INTO empresa (idEmpresa, nome, cnpj, email, rua, bairro, cidade, numero, UF) VALUES ('${codigo}','${NomeEmpresa}','${cnpj}', '${Email}', '${rua}', '${bairro}', '${cidade}', '${numero}', '${sigla}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrarUsuario(codigo, NomeUsuario, EmailUsuario, senha, cargo) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", NomeUsuario, EmailUsuario, senha, cargo);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO usuario (fk1Empresa, nome, email, senha, cargo) VALUES ('${codigo}', '${NomeUsuario}', '${EmailUsuario}', '${senha}', '${cargo}');
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
        SELECT porcentagemUmidade, nivel, dtRegistro, talhão, linha, coluna FROM registro JOIN sensor ON fk2Sensor = idSensor JOIN empresa ON fk2empresa = idEmpresa JOIN localizacao on fk1Sensor = idSensor WHERE idEmpresa = ${idEmpresa} AND (nivel = "Umidade baixa" OR nivel = "Umidade elevada");
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function BuscarDados(idEmpresa){
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function BuscarDados():");

    var instrucaoSql = `
        SELECT porcentagemUmidade, talhão FROM registro JOIN sensor ON fk2Sensor = idSensor JOIN empresa ON fk2empresa = idEmpresa JOIN localizacao on fk1Sensor = idSensor WHERE idEmpresa = ${idEmpresa};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function BuscarRegistro(idEmpresa){
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function BuscarRegistro():");

     var instrucaoSql = `
        SELECT idSensor, l.talhão AS Talhao, s.idSensor AS Sensor,
        CONCAT(l.coluna, l.linha) AS Localizacao,
        r.dtRegistro AS DataHora, r.porcentagemUmidade AS Umidade FROM registro r JOIN sensor s ON r.fk2Sensor = s.idSensor JOIN empresa e ON s.fk2Empresa = e.idEmpresa JOIN localizacao l ON s.idSensor = l.fk1Sensor WHERE e.idEmpresa = ${idEmpresa} AND statusSensor = 'Ativo' AND r.dtRegistro = (
        SELECT MAX(r2.dtRegistro) FROM registro r2
        WHERE r2.fk2Sensor = r.fk2Sensor);
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function BuscarSensor(idEmpresa, statusSensor){
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function BuscarSensor():");

     var instrucaoSql = `
        SELECT idSensor, statusSensor, talhão, linha, coluna FROM sensor 
        JOIN empresa ON fk2empresa = idEmpresa 
        JOIN localizacao on fk1Sensor = idSensor 
        WHERE idEmpresa = ${idEmpresa} and statusSensor = '${statusSensor}';
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function BuscarDadosSensor(idEmpresa, idSensor){
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function BuscarRegistro():");

     var instrucaoSql = `
        SELECT porcentagemUmidade, DATE_FORMAT(time(dtRegistro), '%H:%i:%s') FROM registro JOIN sensor ON fk2Sensor = idSensor JOIN empresa ON fk2empresa = idEmpresa JOIN localizacao on fk1Sensor = idSensor WHERE idEmpresa = ${idEmpresa} AND idSensor = ${idSensor};

    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function BuscarAlertaSensor(idEmpresa, talhao){
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function BuscarAlertaRegistro():");

        var instrucaoSql = `
            select idSensor, porcentagemUmidade, dtRegistro, statusSensor, talhão, CONCAT(coluna, linha) AS Localizacao 
            from registro join sensor on idSensor = fk2Sensor 
            join localizacao on fk2Sensor = idSensor 
            join empresa on fk2Empresa = idEmpresa 
            where idEmpresa = ${idEmpresa} and talhão = ${talhao} order by dtRegistro desc LIMIT 15;
        `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function BuscarQuantidadeSensor(idEmpresa, talhao){
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function BuscarAlertaRegistro():");

        var instrucaoSql = `
            SELECT COUNT(DISTINCT fk2Sensor) AS Quantidade
            FROM registro 
            JOIN sensor ON fk2Sensor = idSensor
            JOIN localizacao ON idSensor = fk1Sensor
            JOIN empresa on fk2Empresa = idEmpresa
            WHERE nivel IN ('Umidade baixa', 'Umidade elevada') and idEmpresa = ${idEmpresa} and talhão = ${talhao};
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
    BuscarAlertas,
    BuscarRegistro,
    BuscarDados,
    BuscarSensor,
    BuscarDadosSensor,
    BuscarAlertaSensor,
    BuscarQuantidadeSensor
};