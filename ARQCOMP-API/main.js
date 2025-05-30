// Importação das bibliotecas necessárias para o funcionamento do projeto
const serialport = require('serialport'); // Comunicação com o Arduino via porta serial
const express = require('express');       // Criação do servidor web (API REST)
const mysql = require('mysql2');          // Conexão com o banco de dados MySQL

// Configurações básicas do sistema
const SERIAL_BAUD_RATE = 9600;       // Taxa de comunicação entre Arduino e Node.js
const SERVIDOR_PORTA = 3300;         // Porta onde o servidor Express irá rodar

// Controle de gravação no banco (habilita ou desabilita a inserção de dados no MySQL)
const HABILITAR_OPERACAO_INSERIR = true;

// Função responsável por iniciar a comunicação com o Arduino
const serial = async (valoresSensorAnalogico) => {

    // Criação da conexão com o banco de dados
    let poolBancoDados = mysql.createPool({
        host: 'localhost',
        user: 'aluno',
        password: 'Sptech#2024',
        database: 'PI',
        port: 3307
    }).promise();

    // Busca todas as portas seriais conectadas e procura o Arduino
    const portas = await serialport.SerialPort.list();
    const portaArduino = portas.find((porta) => porta.vendorId == 2341 && porta.productId == 43);

    // Se não encontrar o Arduino, exibe erro no terminal
    if (!portaArduino) {
        throw new Error('O Arduino não foi encontrado em nenhuma porta serial');
    }

    // Configura a porta de comunicação com o Arduino
    const arduino = new serialport.SerialPort({
        path: portaArduino.path,
        baudRate: SERIAL_BAUD_RATE
    });

    // Mensagem quando a conexão com o Arduino for iniciada com sucesso
    arduino.on('open', () => {
        console.log(`Leitura do Arduino iniciada na porta ${portaArduino.path} com baud rate ${SERIAL_BAUD_RATE}`);
    });

    // Quando o Arduino envia dados, eles são recebidos aqui
    arduino.pipe(new serialport.ReadlineParser({ delimiter: '\r\n' }))
        .on('data', async (data) => {
            console.log("Dados recebidos:", data);

            const valores = data.split(';');
            const sensorAnalogico = parseFloat(valores[0]);

            valoresSensorAnalogico.push(data);

            if (HABILITAR_OPERACAO_INSERIR) {
                let nivel;

                // Define o nível com base no valor da umidade
                if (sensorAnalogico < 60) {
                    nivel = 'Umidade baixa';
                } else if (sensorAnalogico <= 80) {
                    nivel = 'Umidade ideal';
                } else {
                    nivel = 'Umidade elevada';
                }

                try {
                    await poolBancoDados.execute(
                        'INSERT INTO registro (fk2Sensor, nivel, porcentagemUmidade) VALUES (?, ?, ?)',
                        [100, nivel, sensorAnalogico] // Substitua 1 pelo ID real do sensor
                    );
                    console.log(`Valor inserido na tabela 'registro': ${sensorAnalogico}%, nível: ${nivel}`);
                } catch (erro) {
                    console.error('Erro ao inserir no banco:', erro);
                }
            }
        });

    // Caso ocorra algum erro durante a leitura do Arduino
    arduino.on('error', (mensagem) => {
        console.error(`Erro na comunicação com o Arduino: ${mensagem}`);
    });
}

// Função responsável por criar e iniciar o servidor web (API)
const servidor = (valoresSensorAnalogico) => {
    const app = express();

    // Permite que qualquer origem (frontend) acesse a API (CORS)
    app.use((request, response, next) => {
        response.header('Access-Control-Allow-Origin', '*');
        response.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
        next();
    });

    // Inicia o servidor e mostra mensagem no terminal
    app.listen(SERVIDOR_PORTA, () => {
        console.log(`API executada com sucesso na porta ${SERVIDOR_PORTA}`);
    });

    // Rota da API para retornar os valores do sensor de umidade analógico
    app.get('/sensores/analogico', (_, response) => {
        return response.json(valoresSensorAnalogico);
    });
}

// Função principal que executa tudo
(async () => {
    const valoresSensorAnalogico = [];
    await serial(valoresSensorAnalogico);
    servidor(valoresSensorAnalogico);
})();
