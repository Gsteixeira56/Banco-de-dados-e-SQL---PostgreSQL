create table profissao (
	idprofissao INTEGER not NULL,
	nome varchar (30) not NULL,

	constraint pk_prf_idprofissao primary key (idprofissao),
	constraint un_prf_nome unique (nome)
);

select * from profissao;

insert into profissao (idprofissao, nome)
	values 
(1,'Estudante'),
(2,'Engenheiro'),
(3,'Pedreiro'),
(4,'Jornalista'),
(5,'Professsor');

create table nacionalidade (
	idnacionalidade INTEGER not NULL,
	nome varchar(30) not NULL,

	constraint pk_ncn_idnacionalidade primary key (idnacionalidade),
	constraint un_ncn_nome unique (nome)
);

insert into nacionalidade (idnacionalidade, nome)
	values
(1,'Brasileira'),
(2,'Italiana'),
(3,'Norte-americana'),
(4,'Alemã');

select * from nacionalidade;

create table complemento(
	idcomplemento INTEGER not NULL,
	nome varchar(30) not NULL,

	constraint pk_cpl_idcomplemento primary key (idcomplemento),
	constraint un_cpl_nome unique (nome)
		);

insert into complemento (idcomplemento, nome)     
		values
	(1,'Casa'),
	(2,'Apartamento');

select * from complemento

create table bairro (
	idbairro INTEGER not NULL,
	nome varchar(30) not NULL,

	constraint pk_brr_idbairro primary key(idbairro),
	constraint pk_brr_nome unique (nome)
);

insert into bairro (idbairro, nome)
	values
(1,'Cidade Nova'),
(2,'Centro'),
(3,'São Pedro'),
(4,'Santa Rosa');

select * from bairro

select * from cliente order by idcliente

alter table cliente rename column profissao to idprofissao; --Altera renomeia o nome da coluna
alter table cliente after column idprofissao type INTEGER; --Altera o tipo de dado quando nenhuma chave vinculada
--1 Estudante 2,3,5
--2 Engenheiro 8,6,1
--3 Pedreiro 9,15,17
--4 Jornalista 12,13
--5 Professor 10,4
--Null 7,11,14

alter table cliente drop idprofissao;
alter table cliente add idprofissao INTEGER; --foreign key = chave estrangeira
alter table cliente add constraint fk_cln_idprofissao foreign key (idprofissao) references profissao (idprofissao) --conectando a chave estrangeira com chave primária
;
--atualizando os dados da idprofissao
update cliente set idprofissao = 1 where idcliente in (2,3,5);
update cliente set idprofissao = 2 where idcliente in (8,6,1);
update cliente set idprofissao = 3 where idcliente in (9,15,17);
update cliente set idprofissao = 4 where idcliente in (12,13);
update cliente set idprofissao = 5 where idcliente in (10,4);

--testando se pode ser apagada
select * from profissao;
delete from profissao where idprofissao = 1; --dará erro porque está vinculado a tabela cliente, trazendo mais consitências dos dados e segurança para manipular dados

select * from cliente order by idcliente
alter table cliente drop nacionalidade;
alter table cliente add idnacionalidade integer;
alter table cliente add constraint fk_cln_idnacionalidade foreign key (idnacionalidade) references nacionalidade (idnacionalidade)
update cliente set idnacionalidade = 1 where idcliente in (1,2,3,4,6,10,11,14);
update cliente set idnacionalidade = 2 where idcliente in (5,7);
update cliente set idnacionalidade = 3 where idcliente = 8;
update cliente set idnacionalidade = 4 where idcliente in (9,13);
select * from nacionalidade

alter table cliente drop complemento;
alter table cliente add idcomplemento integer;
alter table cliente add constraint fk_cln_idcomplemento foreign key (idcomplemento) references complemento (idcomplemento);
select * from complemento
update cliente set idcomplemento = 1 where idcliente in (1,4,9,13);
update cliente set idcomplemento = 2 where idcliente in (2,3,7);

select * from cliente;
alter table cliente drop bairro;
alter table cliente add idbairro integer;
alter table cliente add constraint fk_cln_idbairro foreign key (idbairro)references bairro (idbairro);
update cliente set idbairro = 1 where idcliente in (1,12,13);
update cliente set idbairro = 2 where idcliente in (2,3,6,8,9);
update cliente set idbairro = 3 where idcliente in (4,5);
update cliente set idbairro = 4 where idcliente = 7;

select * from cliente;

create table uf (
	iduf integer not NULL,
	nome varchar(30) not NULL,
	sigla char(2) not NULL,

	constraint pk_ufd_idunidade_federacao primary key (iduf),
	constraint un_ufd_nome unique (nome),
	constraint un_ufd_sigla unique (sigla)
)

select * from uf order by iduf asc;

insert into uf (iduf, nome, sigla)
	values
(3,'São Paulo', 'SP'),
(5,'Rio Grande do Sul', 'RS'),
(1,'Santa Catarina', 'SC'),
(2,'Parana', 'PR'),
(6,'Rio de Janeiro','RJ');


insert into uf (iduf, nome, sigla)
	values (4,'Minas Gerais','MG');

create table municipio (
	idmunicipio integer not NULL,
	nome varchar(30) not NULL,
	iduf integer not NULL,

	constraint pk_mnc_idmunicipio primary key (idmunicipio),
	constraint un_mnc_nome unique (nome),
	constraint fk_mnc_iduf foreign key (iduf) references uf (iduf)
);

select * from municipio;
insert into municipio (idmunicipio,nome,iduf)
	values
(1,'Porto União',1),
(2,'Canoinhas',1),
(3,'Porto Vitória',2),
(4,'Gerenal Carneiro',2),
(5,'São Paulo',3),
(6,'Rio de Janeiro',6),
(7,'Uberlândia',4),
(8,'Porto Alegre',5),
(9,'União da Vitória',2);

select * from cliente

alter table cliente drop municipio;
alter table cliente drop uf;
alter table cliente add idmunicipio integer;
alter table cliente add constraint fk_clt_idmunicipio foreign key (idmunicipio) references municipio (idmunicipio);

update cliente set idmunicipio = 1 where idcliente in (1,2,10,11);
update cliente set idmunicipio = 2 where idcliente in (3,12);
update cliente set idmunicipio = 3 where idcliente = 4;
update cliente set idmunicipio = 4 where idcliente = 5;
update cliente set idmunicipio = 5 where idcliente in (6,13);
update cliente set idmunicipio = 6 where idcliente = 7;
update cliente set idmunicipio = 7 where idcliente = 8;
update cliente set idmunicipio = 8 where idcliente = 9;
update cliente set idmunicipio = 9 where idcliente in (14,15);

--Exercícios:
create table fornecedor (
	IdFornecedor integer not NULL,
	nome varchar(50) not NULL,

	constraint pk_fnd_IdFornecedor primary key (IdFornecedor),
	constraint un_fnd_nome unique (nome)
);

select * from Fornecedor

create table Vendedor (
	IdVendedor integer not NULL,
	nome varchar(50) not NULL,

	constraint pk_vnd_IdVendedor primary key (IdVendedor),
	constraint un_vnd_nome unique (nome)
	);

Create table Transportadora (
	IdTransportadora integer not NULL,
	IdMunicipio integer not NULL,
	nome varchar(50) not NULL,
	logradouro varchar (50) not NULL,
	numero varchar(10) not NULL,

	constraint pk_tpd_IdTransportadora primary key (IdTransportadora),
	constraint fk_tpd_IdMunicipio foreign key (IdMunicipio) references municipio(IdMunicipio)
	
);

alter table Transportadora add constraint un_tpd_nome unique (nome);

Create table Produto (
	IdProduto integer not NULL,
	IdFornecedor integer not NULL,
	nome varchar(50) not NULL,
	valor numeric (10,2) not NULL,

	constraint pk_pdt_IdProduto primary key (IdProduto),
	constraint fk_pdt_IfFornecedor foreign key (IdFornecedor) references Fornecedor (IdFornecedor)
	
);

select * from Vendedor;

insert into Vendedor (idvendedor,nome)
	values
(1,'André'),
(2,'Alisson'),
(3,'José'),
(4,'Ailton'),
(5,'Maria'),
(6,'Suelem'),
(7,'Aline'),
(8,'Silvana');

insert into Fornecedor(idfornecedor,nome)
	values
(1,'Cap. Computadores'),
(2,'AA. Computadores'),
(3,'BB. Máquinas');

select * from Produto;

INSERT INTO Transportadora (IdTransportadora, IdMunicipio, nome, logradouro, numero)
VALUES
(1, 9, 'BS Transportes', 'Rua das Limas', '01'),
(2, 5, 'União Transportes', '','' );


insert into Produto (Idproduto, Idfornecedor, nome, valor)
	values
(1,1,'Microcomputador',800),
(2,1,'Monitor',500),
(3,2,'Placa Mãe',200),
(4,2,'HD',150),
(5,2,'Placa de video',200),
(6,3,'Memória RAM',100),
(7,1,'Gabinete',35);


select * from pedido;
Create table Pedido (
	idpedido integer not NULL,
	idcliente integer not NULL,
	idtransportadora integer,
	idvendedor integer not NULL,
	data_pedido date not NULL,
	valor float not NULL,

	constraint pk_pdd_idpedido primary key (idpedido),
	constraint fk_pdd_idcliente foreign key (idcliente) references cliente (idcliente),
	constraint fk_pdd_idtransportadora foreign key (idtransportadora) references transportadora (idtransportadora),
	constraint fk_pdd_idvendedor foreign key (idvendedor) references vendedor (idvendedor)
);

alter table pedido alter column Valor type numeric(10,2);

select * from pedido;

insert into pedido(idpedido,data_pedido, valor, idcliente, idtransportadora, idvendedor)
	values 
(1,'2008-04-01',1300,1,1,1 ),
(2,'2008-04-01',500,1,1,1 ),
(3,'2008-04-02',300,11,2,5 ),
(4,'2008-04-05',1000,8,1,7 ),
(5,'2008-04-06',200,9,2,6 ),
(6,'2008-04-06',1985,10,1,6 ),
(7,'2008-04-06',800,3,1,7 ),
(8,'2008-04-06',175,3,null,7 ),
(9,'2008-04-07',1300,12,null,8),
(10,'2008-04-10',200,6,1,8 ),
(11,'2008-04-15',300,15,2,1 ),
(12,'2008-04-20',500,15,2,5 ),
(13,'2008-04-20',350,9,1,7 ),
(14,'2008-04-23',300,2,1,5 ),
(15,'2008-04-25',200,11,null,5);

create table Pedido_Produto (
	Idpedido integer not NULL,
	Idproduto integer not NULL,
	quantidade integer not NULL,
	valor_unitario float not NULL,

	constraint pk_pdp_idpedidoproduto primary key (idpedido, idproduto), --Foi criado uma chave primária composta, e não deixa criar duplicidade de valores na tabela
	constraint fk_pdp_idpedido foreign key (idpedido) references pedido (idpedido),
	constraint fk_pdp_idproduto foreign key (idproduto) references produto (idproduto)
	);

select * from pedido_produto;

insert into pedido_produto (idpedido,idproduto,quantidade, valor_unitario)
	values
(1,1,1,800),
(1,2,1,500),
(2,2,1,500),
(3,4,2,150),
(4,1,1,800),
(4,3,1,200),
(5,3,1,200),
(6,1,2,800),
(6,7,1,35),
(6,5,1,200),
(6,4,1,150),
(7,1,1,800),
(8,7,5,35),
(9,1,1,800),
(9,2,1,500),
(10,5,1,200),
(11,5,1,200),
(11,6,1,100),
(12,2,1,500),
(13,3,1,200),
(13,4,1,150),
(14,6,3,100),
(15,3,1,200);

