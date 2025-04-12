create database PI;

use PI;

create table empresa (
idEmpresa int primary key auto_increment,
nome varchar(45),
cnpj char(14),
telefone char(11),
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
telefone char(11),
email varchar(80),
senha varchar(8),
cargo varchar(45),
constraint pkUsuEmp primary key (idUsuario, fk1Empresa),
constraint cckCargo check (cargo in ('Fucionário', 'Administrador')),
constraint fkEmpUsu
	foreign key (fk1Empresa)
		references empresa(idEmpresa)
)auto_increment 10;


insert into usuario values
(default, 1, 'Laura','11912345670','laura_campal@frutas.com','campal11','Administrador'),
(default, 1, 'Augusto','11998765433','augusto_campal@frutas.com','campal11','Fucionário'),
(default, 4, 'Mariana','11982075137','mariana_upfruit@frutas.com','upfruit4','Administrador'),
(default, 4, 'Vitoria','11923456786','vitoria_upfruit@frutas.com','upfruit4','Fucionário'),
(default, 3, 'Isabela','31934567894','isabela_bonella@frutas.com','bonella3','Fucionário'),
(default, 3, 'Ricardo','31912345673','ricardo_bonella@frutas.com','bonella3','Administrador'),
(default, 3, 'Luiz','31987654327','luiz_bonella@frutas.com','bonella3','Fucionário'),
(default, 2, 'Rafael','71998765434','rafael_araujo@frutas.com','araujo22','Administrador'),
(default, 2, 'Iara','71987654322','iara_araujo@frutas.com','araujo22','Fucionário');

select empresa.nome as Empresa,
empresa.telefone as Telefone,
empresa.email as email,
usuario.nome as Colaborador,
usuario.telefone as Telefone,
usuario.email as emailColaborador
from empresa join usuario
on idEmpresa = fk1Empresa;


create table sensor(
idSensor int primary key auto_increment,
fK2Empresa int,
statusSensor VARCHAR(20),
areaSensor varchar(45),
dtInstalacao date,
constraint cckStatus check (statusSensor in ('Ativo', 'Inativo')),
constraint fkEmpSensor 
	foreign key (fK2Empresa)
		references empresa(idEmpresa)
)auto_increment 100;


insert into sensor(fk2Empresa, statusSensor, areaSensor, dtInstalacao) values
(default, 2, 'Ativo','Pomar Minas Gerais','2025-03-20');


create table localizacao (
idLocalizacao int auto_increment,
fk1Sensor int,
localS varchar(45),
constraint pkLocSens primary key (idlocalizacao,fk1Sensor),
constraint fkSenLocal 
	foreign key (fk1Sensor)
		references sensor(idSensor)
);

create table registro (
idRegistro int auto_increment,
fk2Sensor int,
dtRegistro datetime default current_timestamp,
nivel varchar(30),
porcentagemUmidade decimal(3,2),
constraint cckNivel check (nivel in ('Umidade baixa', 'Umidade ideal', 'Umidade elevada')),
constraint pkRegSen primary key (idRegistro, fk2Sensor),
constraint fkSenReg
	foreign key (fk2Sensor)
		references sensor(idSensor)
);

create table alerta (
idAlerta int auto_increment,
fkRegistro int,
dtAlerta datetime,
constraint pkAlertReg primary key (idAlerta, fkRegistro),
constraint fkRegAlert
	foreign key (fkRegistro)
		references registro(idRegistro)
) auto_increment 50;

create table manuntencao (
idManutencao int auto_increment,
fk3Sensor int,
dtManutencao date,
constraint pkManSen primary key (idManutencao, fk3Sensor),
constraint fkSenMan 
	foreign key (fk3Sensor)
		references sensor(idSensor)
);