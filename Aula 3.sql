select * from cliente order by idcliente asc;
--Fazer uma alteração
update cliente set nome = 'Marina' where idcliente = 1;
--Alterar diversas coluna
update cliente set nome = 'Adriano', genero = 'M', numero = '241' where idcliente = 2;
--Inserir novos dados
insert into cliente (idcliente, nome) values (16, 'João');
--Deletar dados
delete from cliente where idcliente = 16;

--Exercícios 3:
--1
INSERT INTO cliente 
(idcliente, nome, cpf, rg, data_nascimento, genero, profissao, nacionalidade, logradouro, numero, complemento, bairro, municipio, uf) 
VALUES 
    (16, 'Maicon', 12349596421, 1234, '1965-10-10', 'M', 'Empresário', NULL, NULL, NULL, NULL, NULL, 'Florianópolis', 'SC'),
    (17, 'Getúlio', NULL, 4631, NULL, 'M', 'Estudante', 'Brasileira', 'Rua Central', 343, 'Apartamento', 'Centro', 'Curitiba', 'PR'),
    (18, 'Sandra', NULL, NULL, NULL, 'F', 'Professora', 'Italiana', NULL, 12, 'Bloco A', NULL, NULL, NULL);

--2
update cliente set cpf = '12349596421', genero = 'M', nacionalidade = 'Brasileira', uf = 'SC' where idcliente = 1;

--3
update cliente set data_nascimento = '1978-04-01', genero = 'M' where idcliente = 17;

--4
update cliente set genero = 'F', profissao = 'Professora', numero = 123 where idcliente = 18;

--5
delete from cliente where idcliente = 16;

--6
delete from cliente where idcliente = 18;