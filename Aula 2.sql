-- Exercícios 2;
--1
select nome, genero, profissao from cliente order by nome desc;

--2
select nome from cliente where nome like '%r%';

--3
select nome from cliente where nome like 'C%';

--4
select nome from cliente where nome like '%a';

--5
select bairro from cliente where bairro like 'Centro';

--6
select complemento from cliente where complemento like 'A%';

--7
select genero from cliente where genero like 'F';

--8
select Cpf from cliente where cpf is null;

--9
select nome, profissao from cliente order by profissao asc;

--10
select nacionalidade from cliente where nacionalidade like 'Brasileira';

--11
select numero from cliente where numero is not null;

--12
select nome, uf from cliente where uf like 'SC';

--13
select nome, data_nascimento from cliente where data_nascimento between '2000-01-01' and '2002-01-01';

--14
select 'Nome: ' || nome || ' /Logradouro:' || logradouro || '/Número: ' || numero || '/Complemento: ' || complemento || '/Bairro:' || bairro || '/Municipio: ' || municipio || '/UF: ' || uf as "Nome/Logradouro/Número/Complemento/Bairro/Municipio/UF" from cliente;