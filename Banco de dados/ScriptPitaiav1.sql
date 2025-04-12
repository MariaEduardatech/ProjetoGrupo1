
Create database PI;
use PI;

create table empresa (
idEmpresa int primary key auto_increment,
nome varchar(45),
cnpj char(14),
telefone char(11),
email varchar(100),
UF  char(2),
bairro varchar(45),
rua varchar(45),
numero varchar(45)
);

insert into empresa (nome, cnpj, telefone, email, UF, bairro, rua, numero) values
('PitayaCorp', '01451145000101', '11987418741','email@pitayacorp.com', 'SP', 'Jardim Pitaya', 'Fruta do Dragão', 1042);

create table usuario (
idUsuario int primary key auto_increment,
nome varchar (45),
telefone char(11),
email varchar(100),
senha varchar(45),
cargo varchar(45),
fkEmpresa int,
constraint cckCargo check (cargo in ('Fucionário', 'Administrador')),
constraint fkEpreFunci 
	foreign key (fkEmpresa)
		references empresa(idEmpresa)

);

insert into usuario (nome, telefone, email, senha, cargo, fkEmpresa) values
('Alberto','11982075137','alberto@pitayacorp.com','passwordteste123','Administrador', 1);

create table sensorUmidadeSolo(
idSensor int primary key auto_increment,
porcentagemUmidade Decimal (5,2),
localSensor varchar(45),
dtAtual datetime default current_timestamp,
fKEmpresaDonaSensor int,
constraint fkEmpreSensor 
	foreign key (fKEmpresaDonaSensor)
		references empresa (idEmpresa)
);


insert into sensorUmidadeSolo (porcentagemUmidade, localSensor, fkEmpresaDonaSensor) values
(22.11, 'Campo Central', 1);

select * from sensorUmidadeSolo;

