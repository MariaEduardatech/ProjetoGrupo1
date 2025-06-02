create database PI;

use PI;

create table empresa (
idEmpresa int primary key auto_increment,
nome varchar(45),
cnpj char(14) unique not null,
telefone char(11) unique,
email varchar(80),
rua varchar(45),
bairro varchar(45),
cidade varchar(45),
numero char(6),
UF char(2)
);

insert into empresa values
(default, 'Campal Frutas e Legumes', '43290980000117', '11912345678','campal@frutas.com', 'Avenida Doutor Gastão Vidigal', 'Vila Leopoldina', 'São Paulo', '38', 'SP'),
(default, 'Agrícola Araujo do Vale', '17747103000201', '71923456789','araujo@frutas.com', 'Rodovia BR 235', 'Zona Rural', 'Casa Nova', '100', 'BA'),
(default, 'Bonella Hortifruti', '96669288000918', '31987654321','bonella@frutas.com', 'Rua do Campo', 'Zona Rural', 'Tres Corações', 38, 'MG'),
(default, 'Up-fruit', '21028441000171', '11998765432','upfruit@frutas.com', 'Estrada Noboru Hirayama', 'Macuco', 'Valinhos', 38, 'SP');


create table usuario (
idUsuario int auto_increment,
fk1Empresa int,
nome varchar (45),
email varchar(80),
senha varchar(8),
cargo varchar(45),
constraint pkUsuEmp primary key (idUsuario, fk1Empresa),
constraint cckCargo check (cargo in ('Funcionário', 'Administrador')),
constraint fkEmpUsu
	foreign key (fk1Empresa)
		references empresa(idEmpresa)
)auto_increment 10;

insert into usuario values
(default, 1, 'Laura', 'laura_campal@frutas.com','campal11','Administrador'),
(default, 1, 'Augusto', 'augusto_campal@frutas.com','campal11','Funcionário'),
(default, 4, 'Mariana', 'mariana_upfruit@frutas.com','upfruit4','Administrador'),
(default, 4, 'Vitoria', 'vitoria_upfruit@frutas.com','upfruit4','Funcionário'),
(default, 3, 'Isabela', 'isabela_bonella@frutas.com','bonella3','Funcionário'),
(default, 3, 'Ricardo', 'ricardo_bonella@frutas.com','bonella3','Administrador'),
(default, 3, 'Luiz', 'luiz_bonella@frutas.com','bonella3','Funcionário'),
(default, 2, 'Rafael', 'rafael_araujo@frutas.com','araujo22','Administrador'),
(default, 2, 'Iara', 'iara_araujo@frutas.com','araujo22','Funcionário');


create table sensor(
idSensor int primary key auto_increment,
fK2Empresa int,
statusSensor varchar(20),
areaSensor varchar(45),
dtInstalacao date,
constraint cckStatus check (statusSensor in ('Ativo', 'Inativo', 'Manutenção', 'Suspenso')),
constraint fkEmpSensor 
	foreign key (fK2Empresa)
		references empresa(idEmpresa)
)auto_increment 100;

insert into sensor(fk2Empresa, statusSensor, areaSensor, dtInstalacao) values
(1, 'Ativo','Pomar São Paulo','2025-03-20'),
(1, 'Inativo','Pomar São Paulo','2025-03-21'),
(2, 'Ativo','Pomar Casa Nova','2025-03-06'),
(2, 'Ativo','Pomar Casa Nova','2025-03-07'),
(2, 'Manutenção','Pomar Casa Nova','2025-03-07'),
(3, 'Ativo','Pomar Tres Corações','2025-03-14'),
(3, 'Inativo','Pomar Tres Corações','2025-03-15'),
(3, 'Manutenção','Pomar Tres Corações','2025-03-15'),
(4, 'Ativo','Pomar Valinhos','2025-03-30'),
(4, 'Ativo','Pomar Valinhos','2025-03-31');

create table localizacao (
idLocalizacao int auto_increment,
fk1Sensor int unique,
região varchar(30),
talhão varchar(3),
coluna varchar(3),
linha varchar(3),
constraint pkLocSens primary key (idlocalizacao,fk1Sensor),
constraint fkSenLocal
	foreign key (fk1Sensor)
		references sensor(idSensor)
);

insert into localizacao values
(default, 108, 'Valinhos', 2, 1, 4);


create table registro (
idRegistro int auto_increment,
fk2Sensor int,
dtRegistro datetime default current_timestamp,
nivel varchar(30),
porcentagemUmidade decimal(4,2),
constraint cckNivel check (nivel in ('Umidade baixa', 'Umidade ideal', 'Umidade elevada')),
constraint pkRegSen primary key (idRegistro, fk2Sensor),
constraint fkSenReg
	foreign key (fk2Sensor)
		references sensor(idSensor)
);

insert into registro values
(default, 100,  default,'Umidade baixa', 58.00);

insert into registro values
(default, 100,  default,'Umidade ideal', 61.00);

insert into registro values
(default, 102,  default,'Umidade elevada', 85.00);

insert into registro values
(default, 102,  default,'Umidade elevada', 82.00);

insert into registro values
(default, 103,  default,'Umidade ideal', 64.00);

insert into registro values
(default, 103,  default,'Umidade ideal', 67.00);

insert into registro values
(default, 104,  default,'Umidade baixa', 50.00);

insert into registro values
(default, 104,  default,'Umidade baixa', 53.00);

insert into registro values
(default, 105,  default,'Umidade baixa', 55.00);

insert into registro values
(default, 105,  default,'Umidade baixa', 57.00);

insert into registro values
(default, 107,  default,'Umidade ideal', 60.00);

insert into registro values
(default, 108,  default,'Umidade baixa', 58.00);

insert into registro values
(default, 109,  default,'Umidade ideal', 62.00);

 
create table alerta (
idAlerta int auto_increment,
fkRegistro int,
dtAlerta datetime,
constraint pkAlertReg primary key (idAlerta, fkRegistro),
constraint fkRegAlert
	foreign key (fkRegistro)
		references registro(idRegistro)
);

insert into alerta values
(default, 1, '2025-04-23 17:11:48'),
(default, 3, '2025-04-23 17:13:59'),
(default, 4, '2025-04-23 17:14:21'),
(default, 7, '2025-04-23 17:17:01'),
(default, 8, '2025-04-23 17:18:15'),
(default, 9, '2025-04-23 17:19:03'),
(default, 10, '2025-04-23 17:20:01'),
(default, 12, '2025-04-23 17:22:01');


create table manutencao (
idManutencao int auto_increment,
fk3Sensor int,
dtManutencao date,
constraint pkManSen primary key (idManutencao, fk3Sensor),
constraint fkSenMan 
	foreign key (fk3Sensor)
		references sensor(idSensor)
);

insert into manutencao (fk3Sensor, dtManutencao) values
(104, '2025-04-20'),
(107, '2025-04-20');


-- Selects
-- Junção da tabela empresa e usuario (colocando espaço nos nomes dos campos)
select empresa.nome as Empresa,
empresa.email as 'E-mail empresa',
usuario.nome as Usuário,
usuario.cargo as Cargo,
usuario.email as 'E-mail usuário'
from empresa join usuario
on idEmpresa = fk1Empresa;

-- Junção da tabela empresa e usuario, selecionando apenas usuários que tem cargo de administrador
select empresa.nome as 'Empresa',
empresa.telefone as 'Telefone empresa',
empresa.email as 'E-mail empresa',
usuario.nome as 'Usuário administrativo',
usuario.telefone as 'Telefone usuário administrativo',
usuario.email as 'E-mail usuário administrativo'
from empresa join usuario
on idEmpresa = fk1Empresa
where usuario.cargo = 'Administrador';

-- Junção da tabela empresa e usuario concatenando os campos que formam o endereço
select empresa.nome as Empresa,
empresa.cnpj as CNPJ,
empresa.telefone as 'Telefone Empresa', 
concat(empresa.rua,' - ', empresa.bairro, ', ', empresa.cidade, ', nº ', empresa.numero, ' - ', empresa.UF) as 'Endereço empresa',
usuario.nome as Usuário,
usuario.cargo as Cargo,
usuario.telefone as 'Telefone usuário'
from empresa join usuario
on idEmpresa = fk1Empresa;

-- Junção das tabelas empresa e sensor
select empresa.nome as Empresa,
empresa.UF as Estado,
empresa.cidade as Cidade,
sensor.idSensor as Sensor,
sensor.areaSensor as Área,
sensor.dtInstalacao as Data_Instalação,
sensor.statusSensor as Status_Sensor
from empresa join sensor
on idEmpresa = fK2Empresa;

-- Junção das tabelas empresa e sensor de uma empresa específica (Bonella Hortifruti)
select empresa.nome as Empresa,
empresa.UF as Estado,
empresa.cidade as Cidade,
sensor.idSensor as Sensor,
sensor.areaSensor as Área,
sensor.dtInstalacao as Data_Instalação,
sensor.statusSensor as Status_Sensor
from empresa join sensor
on idEmpresa = fK2Empresa
where idEmpresa = 3;

-- Junção das tabelas empresa, sensor e localização
select empresa.nome as Empresa,
empresa.UF as Estado,
sensor.areaSensor as Área,
sensor.dtInstalacao as Data_Instalação,
sensor.statusSensor as Status_Sensor,
localizacao.fk1Sensor as Sensor,
localizacao.localS as Localização from empresa 
join sensor on empresa.idEmpresa = sensor.fk2Empresa
join localizacao on sensor.idSensor = localizacao.fk1Sensor;

-- Junção das tabelas sensor e localização
select sensor.areaSensor as Área,
sensor.dtInstalacao as Data_Instalação,
sensor.statusSensor as Status_Sensor,
localizacao.fk1Sensor as Sensor,
localizacao.localS as Localização
from sensor join localizacao
on idSensor = fk1Sensor;

-- Junção das tabelas sensor e localização mostrando todos os sensores, mesmo sem localização cadastrada
select sensor.areaSensor as Área,
sensor.dtInstalacao as Data_Instalação,
sensor.statusSensor as Status_Sensor,
sensor.idSensor as Sensor,
localizacao.localS as Localização
from sensor left join localizacao
on idSensor = fk1Sensor;

-- Junção das tabelas sensor e localização mostrando todos os sensores, mesmo sem localização cadastrada e renomeando campos nulos
select sensor.areaSensor as Área,
sensor.dtInstalacao as Data_Instalação,
sensor.statusSensor as Status_Sensor,
sensor.idSensor as Sensor,
ifnull(localizacao.localS, 'Não cadastrada') as Localização
from sensor left join localizacao
on idSensor = fk1Sensor;

-- Junção das tabelas sensor e registro
select sensor.idSensor as 'Sensor',
sensor.areaSensor as 'Área',
sensor.dtInstalacao as 'Data de Instalação',
sensor.statusSensor as 'Status do Sensor',
registro.nivel as 'Nível de Umidade',
registro.porcentagemUmidade as 'Taxa de umidade (%)',
registro.dtRegistro as 'Data e hora'
from sensor join registro
on idSensor = fk2Sensor;
 
 -- Junção das tabelas sensor e registro mostrando todos os sensores, mesmo os inativos
 select sensor.idSensor as 'Sensor',
sensor.areaSensor as 'Área',
sensor.dtInstalacao as 'Data de Instalação',
sensor.statusSensor as 'Status do Sensor',
registro.nivel as 'Nível de Umidade',
registro.porcentagemUmidade as 'Taxa de umidade (%)',
registro.dtRegistro as 'Data e hora'
from sensor left join registro
on idSensor = fk2Sensor;
 
  -- Junção das tabelas sensor e registro mostrando todos os sensores, mesmo os inativos e renomeando campos nulos
 select sensor.idSensor as 'Sensor',
sensor.areaSensor as 'Área',
sensor.dtInstalacao as 'Data de Instalação',
sensor.statusSensor as 'Status do Sensor',
ifnull(registro.nivel, 'Sem registro') as 'Nível de Umidade',
ifnull(registro.porcentagemUmidade, 'Sem registro') as 'Taxa de umidade (%)',
ifnull(registro.dtRegistro, 'Sem registro') as 'Data e hora'
from sensor left join registro
on idSensor = fk2Sensor;

-- Junção das tabelas empresa, sensor, localização e registro
select empresa.nome as Empresa,
empresa.UF as Estado,
sensor.areaSensor as 'Área',
sensor.idSensor as 'Sensor',
sensor.statusSensor as 'Status do Sensor',
localizacao.localS as 'Localização',
registro.nivel as 'Nível de Umidade',
registro.porcentagemUmidade as 'Taxa de umidade (%)',
registro.dtRegistro as 'Data e hora'
from empresa 
join sensor on empresa.idEmpresa = sensor.fk2Empresa
join registro on sensor.idSensor = registro.fk2Sensor
join localizacao on sensor.idSensor = localizacao.fk1Sensor;

-- Junção das tabelas registro e alerta
select registro.nivel as 'Nível de Umidade',
registro.porcentagemUmidade as 'Taxa de umidade (%)',
alerta.fkRegistro as 'Registro',
alerta.dtAlerta as 'Data do alerta'
from registro join alerta
on registro.idRegistro = alerta.fkRegistro;

-- Junção das tabelas sensor, registro e alerta
select sensor.idSensor as 'Sensor',
sensor.areaSensor as 'Área',
sensor.dtInstalacao as 'Data de Instalação',
sensor.statusSensor as 'Status do Sensor',
registro.nivel as 'Nível de Umidade',
registro.porcentagemUmidade as 'Taxa de umidade (%)',
alerta.fkRegistro as 'Registro',
alerta.dtAlerta as 'Data do alerta' from registro 
join alerta on registro.idRegistro = alerta.fkRegistro
join sensor on sensor.idSensor = registro.fk2Sensor;

-- Junção das tabelas empresa, sensor, localização, registro e alerta
select empresa.nome as Empresa,
empresa.UF as Estado,
sensor.areaSensor as 'Área',
sensor.idSensor as 'Sensor',
sensor.statusSensor as 'Status do Sensor',
localizacao.localS as 'Localização',
registro.nivel as 'Nível de Umidade',
registro.porcentagemUmidade as 'Taxa de umidade (%)',
registro.dtRegistro as 'Data e hora',
alerta.dtAlerta as 'Data do alerta'
from empresa 
join sensor on empresa.idEmpresa = sensor.fk2Empresa
join registro on sensor.idSensor = registro.fk2Sensor
join localizacao on sensor.idSensor = localizacao.fk1Sensor
join alerta on registro.idRegistro = alerta.fkRegistro;

-- -- Junção das tabelas sensor e manutenção
select sensor.areaSensor as 'Área',
sensor.idSensor as 'Sensor',
sensor.statusSensor as 'Status do Sensor',
manutencao.dtManutencao as 'Data de Manutenção',
manutencao.idManutencao as 'Manutenção'
from sensor join manutencao
on sensor.idSensor = manutencao.fk3Sensor;

-- Junção das tabelas sensor e manutenção, mostrando todos os sensores, mesmo os que não tiveram manutenção, renomeando os campos
select sensor.areaSensor as 'Área',
sensor.idSensor as 'Sensor',
sensor.statusSensor as 'Status do Sensor',
case when manutencao.dtManutencao is null then 'Sem Manutenção'
else 'Sensor já passou por manutenção'
end as Manutencao
from manutencao right join sensor on manutencao.fk3Sensor = sensor.idSensor;



-- -- Junção das tabelas sensor e manutenção, mostrando todos os sensores, mesmo os que não tiveram manutenção, renomeando os campos
select sensor.areaSensor as 'Área',
sensor.idSensor as 'Sensor',
sensor.statusSensor as 'Status do Sensor',
ifnull(manutencao.dtManutencao, 'Sem Manutenção') as 'Data de Manutenção',
ifnull(manutencao.idManutencao, 'Sem Manutenção') as 'Manutenção'
from manutencao right join sensor on manutencao.fk3Sensor = sensor.idSensor;

-- -- Junção das tabelas empresa, sensor, localização, registro, alerta e manutenção (todas menos usuário)
select empresa.nome as 'Empresa',
empresa.UF as 'Estado',
sensor.areaSensor as 'Área',
ifnull(localizacao.localS, 'Não cadastrada') as Localização,
sensor.statusSensor as 'Status do Sensor',
sensor.idSensor as 'Sensor',
ifnull(registro.nivel, 'Sem registro') as 'Nível de Umidade',
ifnull(registro.porcentagemUmidade, 'Sem registro') as 'Taxa de umidade (%)',
ifnull(manutencao.dtManutencao, 'Sem Manutenção') as 'Data de Manutenção',
ifnull(alerta.dtAlerta, 'Sem alerta') as 'Data do alerta' from sensor
left join empresa on empresa.idEmpresa = sensor.fk2Empresa
left join registro on sensor.idSensor = registro.fk2Sensor
left join localizacao on sensor.idSensor = localizacao.fk1Sensor
left join alerta on registro.idRegistro = alerta.fkRegistro
left join manutencao on sensor.idSensor = manutencao.fk3Sensor;