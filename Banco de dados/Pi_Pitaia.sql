
Create database PI;

use PI;

create table empresa (
idEmpresa int primary key auto_increment,
nome varchar(45),
cnpj char(14),
telefone char(11),
email varchar(80),
UF  char(2),
bairro varchar(45),
rua varchar(45),
numero varchar(45)
);

insert into empresa (nome, cnpj, telefone, email, UF, bairro, rua, numero) values
('PitayaCorp', '01451145000101', '11987418741','email@pitayacorp.com', 'SP', 'Jardim Pitaya', 'Fruta do Dragão', 1042);

create table usuario (
idUsuario int ,
fk1Empresa int,
nome varchar (45),
telefone char(11),
email varchar(80),
senha varchar(8),
cargo varchar(45),
constraint pkEmpComp primary key (idUsuario, fkEmpresa),
constraint cckCargo check (cargo in ('Fucionário', 'Administrador')),
constraint fkEpreFunci 
	foreign key (fk1Empresa)
		references empresa(idEmpresa)
);

insert into usuario (idUsuario, nome, telefone, email, senha, cargo, fkEmpresa) values
(1,'Alberto','11982075137','alberto@pitayacorp.com','passwordteste123','Administrador', 1);

create table sensor(
idSensor int primary key auto_increment,
statusSensor VARCHAR(20),
areaSensor varchar(45),
dtInstalacao date,
fK2Empresa int,
constraint fkEmpreSensor 
	foreign key (fK2Empresa)
		references empresa (idEmpresa)
);

-- dtAtual datetime default current_timestamp,

insert into sensor(statusSensor, areaSensor, dtInstalacao, fk2Empresa) values
();

create table localizacao (
idLocalizacao int,
fk1Sensor int,
localS varchar(45),
constraint pkSenComp primary key (idlocalizacao,fk1Sensor),
constraint fkSenLocal 
	foreign key (fk1Sensor)
		references sensor (idSensor)

);

create table registro (
idRegistro int,
fk2Sensor int,
dtRegistro datetime default current_timestamp,
nivel varchar(45),
porcentagemUmidade decimal(3,2),
constraint pkRegSen primary key (idRegistro, fk2Sensor),
constraint fkRegSensor 
	foreign key (fk2Sensor)
		references sensor (idSensor)
);

create table alerta (
idAlerta int,
fkRegistro int,
dtAlerta datetime,
constraint pkAlerReg primary key (idAlerta, fkRegistro),
constraint fkAlertReg 
	foreign key (fkRegistro)
		references registro (idRegistro)

);

create table manuntencao (
idManutencao int,
fk3Sensor int,
dtManutencao date,
constraint pkManSen primary key (idManuntencao, fk3Sensor),
constraint fkManSens 
	foreign key (fk3Sensor)
		references sensor(idSensor)

);

