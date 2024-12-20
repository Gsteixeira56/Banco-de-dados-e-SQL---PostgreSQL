create table cliente (
	idcliente INTEGER not null,
	nome varchar(50) not null,
	cpf char(11),
	rg varchar(15),
	data_nascimento date,
	genero char(1),
	profissao varchar(30),
	nacionalidade varchar(30),
	logradouro varchar(30),
	numero varchar(10),
	complemento varchar(30),
	bairro varchar(30),
	municipio varchar(30),
	uf varchar(30),
	observacoes text,
-- primary key
	constraint pk_cln_idcliente primary key (idcliente)
	);

insert into cliente (idcliente, nome, cpf, rg, data_nascimento, genero, profissao, nacionalidade, logradouro, numero, complemento, bairro, municipio, uf, observacoes)
values (1, 'Gustavo', '02933152412','113324', '1999-07-06', 'M', 'Estudante', 'Brasileiro', 'Rua Moraes', '25', 'Casa', 'Centro', 'Porto Alegre', 'RS',' ')

insert into cliente (idcliente, nome, cpf, rg, data_nascimento, genero, profissao, nacionalidade, logradouro, numero, complemento, bairro, municipio, uf, observacoes)
values (2, 'Rosa', '02933141259','115622453', '1999-09-26', 'F', 'Estudante', 'Brasileira', 'Rua Maria Dormecida', '599', 'Apartamento', 'Harmonia', 'Canoas', 'RS',' ')

INSERT INTO cliente (idcliente, nome, cpf, rg, data_nascimento, genero, profissao, nacionalidade, logradouro, numero, complemento, bairro, municipio, uf, observacoes)
VALUES 
(3, 'Carlos', '12345678901', '998877', '1985-12-01', 'M', 'Engenheiro', 'Brasileiro', 'Avenida dos Autonomistas', '1234', 'Apto 101', 'Centro', 'Osasco', 'SP', ''),
(4, 'Ana', '23456789012', '887766', '1990-05-14', 'F', 'Médica', 'Brasileira', 'Rua das Flores', '567', 'Casa', 'Jardim das Palmeiras', 'São Paulo', 'SP', ''),
(5, 'Pedro', '34567890123', '776655', '1978-08-22', 'M', 'Advogado', 'Brasileiro', 'Rua do Comércio', '789', 'Sala 12', 'Centro', 'Rio de Janeiro', 'RJ', ''),
(6, 'Mariana', '45678901234', '665544', '1982-03-15', 'F', 'Professora', 'Brasileira', 'Rua das Palmeiras', '101', 'Casa', 'Vila Nova', 'Salvador', 'BA', ''),
(7, 'João', '56789012345', '554433', '1975-11-30', 'M', 'Administrador', 'Brasileiro', 'Rua dos Pioneiros', '222', 'Apto 202', 'Jardim América', 'Curitiba', 'PR', ''),
(8, 'Luiza', '67890123456', '443322', '1995-06-07', 'F', 'Designer', 'Brasileira', 'Rua das Estrelas', '333', 'Casa', 'Centro', 'Belo Horizonte', 'MG', ''),
(9, 'Ricardo', '78901234567', '332211', '1987-10-12', 'M', 'Arquiteto', 'Brasileiro', 'Rua do Sol', '444', 'Apto 303', 'Jardim das Oliveiras', 'Florianópolis', 'SC', ''),
(10, 'Juliana', '89012345678', '221100', '1993-01-19', 'F', 'Jornalista', 'Brasileira', 'Rua da Praia', '555', 'Casa', 'Praia do Canto', 'Vitória', 'ES', ''),
(11, 'Rafael', '90123456789', '110099', '1980-07-28', 'M', 'Músico', 'Brasileiro', 'Rua das Araras', '666', 'Apto 404', 'Centro', 'Manaus', 'AM', ''),
(12, 'Fernanda', '01234567890', '99887766', '1988-04-04', 'F', 'Psicóloga', 'Brasileira', 'Rua das Gaivotas', '777', 'Casa', 'Centro', 'Fortaleza', 'CE', ''),
(13, 'Thiago', '09876543210', '88776655', '1972-02-09', 'M', 'Empresário', 'Brasileiro', 'Rua dos Anjos', '888', 'Apto 505', 'Jardim Botânico', 'Porto Alegre', 'RS', ''),
(14, 'Beatriz', '10987654321', '77665544', '1991-12-21', 'F', 'Nutricionista', 'Brasileira', 'Rua das Hortênsias', '999', 'Casa', 'Centro', 'Blumenau', 'SC', '');

INSERT INTO cliente (idcliente, nome, cpf, rg, data_nascimento, genero, profissao, nacionalidade, logradouro, numero, complemento, bairro, municipio, uf, observacoes)
VALUES (15, 'Larissa', '12345098765', '55667788', '2000-11-30', 'F', 'Engenheira de Software', 'Brasileira', 'Rua das Laranjeiras', '111', 'Apto 606', 'Jardim Europa', 'Campinas', 'SP', '');

select * from cliente;
-- Consultar 2 colunas
select nome, data_nascimento from cliente;
-- Renomear título de coluna
select nome, data_nascimento as "Data de nascimento" from cliente;
-- Concatenar dados de 2 colunas
select 'CPF: ' || cpf || '/ RG: ' || rg as "CPF/RG" from cliente;
-- Limitar a quantidade linhas para consulta
select * from cliente limit 5;
-- where é usado para filtrar um dado especifico
select nome, data_nascimento from cliente where data_nascimento > '1999-01-01';
-- like é "=". E quando usa "%" significa pode seguir qualquer outro caracter
select nome from cliente where nome like 'C%';

Select nome from cliente where nome like '%a%';
-- 'between' usado para filtrar entre 2 objetos. E 'And' para adicionar.
Select nome, data_nascimento from cliente where data_nascimento between '1990-01-01' and '1995-01-01';
--  'Is null' verificar se algum dado nulo
Select nome, rg from cliente where rg is null;
-- 'Order by' para deixar em ordem crescente
Select nome from cliente order by nome;
-- 'Order by' para deixar em ordem decrescente
select nome from cliente order by nome desc;
