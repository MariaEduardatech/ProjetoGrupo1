// Definições dos pinos e variáveis
const int PINO_SENSOR_UMIDADE_SOLO = A0;  // Pino conectado ao sensor capacitivo de umidade de solo

// Função de inicialização
void setup() {
  Serial.begin(9600);  // Inicializa a comunicação serial a 9600 bps
  pinMode(PINO_SENSOR_UMIDADE_SOLO, INPUT);  // Configura o pino como entrada
}

// Função principal de execução contínua
void loop() {
  // Lê o valor analógico do sensor de umidade
  int leituraSensor = analogRead(PINO_SENSOR_UMIDADE_SOLO);

  // Inverte o valor para que umidade alta resulte em porcentagem alta
  float porcentagemUmidade = ((1023.0 - leituraSensor) / 1023.0) * 100;

  // Exibe os valores no monitor serial

  Serial.print(porcentagemUmidade);
  Serial.println(" ");
 

  // Aguarda 1 segundo antes da próxima leitura
  delay(1000);
}
