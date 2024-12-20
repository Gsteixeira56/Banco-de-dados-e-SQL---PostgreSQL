--Avaliação prática – Banco de Dados


--1. Crie um banco de dados chamado BIBLIOTECA.

create database Biblioteca;

--2. Crie uma tabela chamada EDITORA, de acordo com os dados abaixo:

\c biblioteca;

create table Editora(
	IdEditora integer not null,
	Nome varchar (50) not null,

	constraint pk_edt_ideditora primary key (ideditora),
	constraint un_edt_nome unique (nome));

select max(ideditora) +1 from editora;
create sequence ideditora_id_seq minvalue 1;
alter table editora alter ideditora set default nextval('ideditora_id_seq');
alter sequence ideditora_id_seq owned by editora.ideditora;

select * from editora;

--3. Insira os dados abaixo na tabela EDITORA.

insert into editora (nome)
	values 
('Bookman'),
('Edgard Blusher'),
('Nova Terra'),
('Brasport');

--4. Crie uma tabela chamada CATEGORIA, de acordo com os dados abaixo:
Create table Categoria (
	IdCategoria integer not null,
	Nome varchar (50) not null,

	constraint pk_ctg_idcategoria primary key (idcategoria),
	constraint un_ctg_nome unique (nome)
);

create sequence idcategoria_id_seq minvalue 1;
alter table categoria alter idcategoria set default nextval('idcategoria_id_seq');
alter sequence idcategoria_id_seq owned by Categoria.idcategoria;

--5. Insira os dados abaixo na tabela CATEGORIA.

insert into categoria (nome)
	values
('Banco de Dados'),
('HTML'),
('Java'),
('PHP');

select * from categoria;

--6. Crie uma tabela chamada AUTOR, de acordo com os dados abaixo:

create table Autor (
	Idautor integer not null,
	Nome varchar (50) not null,

constraint pk_aut_idautor primary key (Idautor));

create sequence idautor_id_seq minvalue 1;
alter table autor alter idautor set default nextval('idautor_id_seq');
alter sequence idautor_id_seq owned by Autor.idautor;
	

--7. Insira os dados abaixo na tabela AUTOR.
insert into autor (nome)
	values
('Waldemar Setzer'),
('Flávio Soares'),
('John Watson'),
('Rui Rossi dos Santos'),
('Antonio Pereira de Resende'),
('Claudiney Calixto Lima'),
('Evandro Carlos Teruel'),
('Ian Graham'),
('Fabrício Xavier'),
('Pablo Dalloglio');

select * from autor;

--8. Crie uma tabela chamada LIVRO, de acordo com os dados abaixo:

select * from livro;
create table Livro (
	Idlivro integer not null,
	Ideditora integer not null,
	Idcategoria integer not null,
	Nome varchar (50) not null,

	constraint pk_lvr_idlivro primary key (idlivro),
	constraint fk_lvr_ideditora foreign key (ideditora) references editora (ideditora),
	constraint fk_lvr_idcategoria foreign key (idcategoria) references categoria (idcategoria),
	constraint un_lvr_nome unique (nome)
);

create sequence idlivro_id_seq minvalue 1;
alter table livro alter idlivro set default nextval('idlivro_id_seq');
alter sequence idlivro_id_seq owned by livro.idlivro;


--9. Insira os dados abaixo na tabela LIVRO.
select * from livro;
insert into livro (ideditora, idcategoria, nome)
	values
(2,1,'Banco de Dados – 1 Edição'),
(1,1,'Oracle DataBase 11G Administração'),
(3,3,'Programação de Computadores em Java'),
(4,3,'Programação Orientada a Aspectos em Java'),
(4,2,'HTML5 – Guia Prático'),
(3,2,'XHTML: Guia de Referência para Desenvolvimento na Web'),
(1,4,'PHP para Desenvolvimento Profissional'),
(2,4,'PHP com Programação Orientada a Objetos');

--10. Crie uma tabela chamada LIVRO_AUTOR, de acordo com os dados abaixo:
create table Livro_autor (
	Idlivro integer not null,
	Idautor integer not null,

	constraint pk_lva_idlivroautor primary key (idlivro, idautor),
	constraint fk_lva_idlivro foreign key (idlivro) references livro(idlivro),
	constraint fk_lva_idautor foreign key (idautor) references autor(idautor));

--11. Insira os dados abaixo na tabela LIVRO_AUTOR.

select * from livro_autor;

insert into Livro_autor (Idlivro,idautor)
	values
(1,1),
(1,2),
(2,3),
(3,4),
(4,5),
(4,6),
(5,7),
(6,8),
(7,9),
(8,10);

--12. Crie uma tabela chamada ALUNO, de acordo com os dados abaixo:

create table aluno (
	Idaluno integer not null,
	Nome varchar (50) not null,

	constraint pk_aln_idaluno primary key (idaluno));

create sequence idaluno_id_seq minvalue 1;
Alter table aluno alter idaluno set default nextval('idaluno_id_seq');
Alter sequence idaluno_id_seq owned by aluno.idaluno;

select * from aluno;

--13. Insira os dados abaixo na tabela ALUNO.

insert into aluno (Nome)
	values
('Mario'),
('João'),
('Paulo'),
('Pedro'),
('Maria');

update aluno set nome = 'Mario' where idaluno = 1; --Tinha errado o nome para Maria
--14. Crie uma tabela chamada EMPRESTIMO, de acordo com os dados abaixo:

create table Emprestimo (
	Idemprestimo integer not null,
	Idaluno integer not null,
	Data_emprestimo date not null default current_date,
	Data_devolucao date not null,
	Valor decimal not null,
	Devolvido varchar (1) not null,

	constraint pk_emp_idemprestimo primary key (idemprestimo),
	constraint fk_emp_idaluno foreign key (idaluno) references aluno(idaluno));

create sequence idemprestimo_id_seq minvalue 1;
alter table emprestimo alter idemprestimo set default nextval('idemprestimo_id_seq');
alter sequence idemprestimo_id_seq owned by emprestimo.idemprestimo;

Select * from emprestimo;

--15. Insira os dados abaixo na tabela EMPRESTIMO.
select * from aluno;

insert into emprestimo (
	Idaluno, Data_emprestimo,data_devolucao, valor, Devolvido
)
	values
(1,'2012-05-02','2012-05-12',10,'S'),
(1,'2012-04-23','2012-05-03',5,'N'),
(2,'2012-05-10','2012-05-20',12,'N'),
(3,'2012-05-10','2012-05-20',8,'S'),
(4,'2012-05-05','2012-05-15',15,'N'),
(4,'2012-05-07','2012-05-17',20,'S'),
(4,'2012-05-08','2012-05-18',5,'S');

update emprestimo set idemprestimo = 1 where idemprestimo = 8; --Tinha errado o nome para Maria

--16. Crie uma tabela chamada EMPRESTIMO_LIVRO, de acordo com os dados abaixo:

create table Emprestimo_livro (
	idemprestimo integer not null,
	idlivro integer not null,

	constraint pk_eml_idemprestimolivro primary key (idemprestimo,idlivro),
	constraint fk_eml_idemprestimo foreign key (idemprestimo) references emprestimo(idemprestimo),
	constraint fk_eml_idlivro foreign key (idlivro) references livro(idlivro)
);

select * from emprestimo_livro;

--17. Insira os dados abaixo na tabela EMPRESTIMO_LIVRO.
select * from livro;
select * from emprestimo;
select * from aluno;

insert into emprestimo_livro (
	idemprestimo, idlivro
)
	values
(1,1), --1mario
(2,4), --1mario
(2,3), --1mario
(3,2), --2joão
(3,7), --2joão
(4,5), --3paulo
(5,4), --4pedro
(6,6), --4pedro
(6,1), --4pedro
(7,8);--4pedro

--18. Crie os seguintes índices:

create index idx_emp_emprestimo on emprestimo (data_emprestimo);
create index idx_emp_devolucao on emprestimo (data_devolucao);

--CONSULTAS SIMPLES

--19. O nome dos autores em ordem alfabética.

select nome from autor order by nome asc;

--20. O nome dos alunos que começam com a letra P.

select nome from aluno where nome like 'P%';

--21. O nome dos livros da categoria Banco de Dados ou Java.

select nome from livro where idcategoria in (1,3);

--22. O nome dos livros da editora Bookman.

select * from editora;
select nome from livro where ideditora = 1;

--23. Os empréstimos realizados entre 05/05/2012 e 10/05/2012.

select * from emprestimo where data_emprestimo between '2012-05-05' and '2012-05-10'

--24. Os empréstimos que não foram feitos entre 05/05/2012 e 10/05/2012.

select * from emprestimo where data_emprestimo not between '2012-05-05' and '2012-05-10'

--25. Os empréstimos que os livros já foram devolvidos.

select * from emprestimo where devolvido = 'S'

--CONSULTAS COM AGRUPAMENTO SIMPLES

--26. A quantidade de livros.

select count(idlivro) as "Qtd. de livros" from livro;

--27. O somatório do valor dos empréstimos.

Select 
	sum(valor) as Valor
from emprestimo;

--28. A média do valor dos empréstimos.

SELECT 
    CAST(AVG(valor) AS FLOAT) AS media_valor
FROM emprestimo;

--29. O maior valor dos empréstimos.

select 
	max(valor) as "Maior Valor"
from emprestimo;

--30. O menor valor dos empréstimos.

select 
	min (valor) as "Menor Valor"
from emprestimo;

--31. O somatório do valor do empréstimo que estão entre 05/05/2012 e 10/05/2012.

select * from emprestimo

select 
	sum(valor) as "Valor"
from emprestimo
	where data_emprestimo between '2012-05-05' and '2012-05-10';

--32. A quantidade de empréstimos que estão entre 01/05/2012 e 05/05/2012.

select 
	count(idemprestimo) as "Qtd. de Empréstimos"
from emprestimo
	where data_emprestimo between '2012-05-01' and '2012-05-05';

--CONSULTAS COM JOIN

--33. O nome do livro, a categoria e a editora (LIVRO) – fazer uma view

select * from livro;

create view LIVRO_Editorial as
select
	lvr.nome as Livro,
	cat.nome as Categoria,
	edt.nome as Editora
from
	livro as lvr
left outer join
	categoria cat on lvr.idcategoria = cat.idcategoria
left outer join
	editora edt on lvr.ideditora = edt.ideditora;
	
select * from LIVRO_Editorial;

--34. O nome do livro e o nome do autor (LIVRO_AUTOR) – fazer uma view.

Select * from livro_autor;

Create view Autor_livros as 

select 
	lvr.nome as livro,
	aut.nome as Autor
from
	Livro_autor as lva
left outer join
	livro lvr on lva.idlivro = lvr.idlivro
left outer join
	autor aut on lva.idautor = aut.idautor;

--35. O nome dos livros do autor Ian Graham (LIVRO_AUTOR).

select * from Livro_autor
	
Create view Livros_Ian_Graham as
select	
	lvr.nome as livros
from
	livro_autor as lva
left outer join
	livro lvr on lva.idlivro = lvr.idlivro
where
	idautor = 8;

--36. O nome do aluno, a data do empréstimo e a data de devolução (EMPRESTIMO).

create view Aluno_Emprestimo_Devolvido as 
select 
	aln.nome,
	data_emprestimo,
	data_devolucao
from
	emprestimo as emp
left outer join
	aluno aln on emp.idaluno = aln.idaluno;

select * from Aluno_Emprestimo_Devolvido;

--37. O nome de todos os livros que foram emprestados (EMPRESTIMO_LIVRO).

select * from livro;

create view Livros_emprestados as
select
	lvr.nome as livros
from
	emprestimo_livro as eml
left outer join
	livro lvr on eml.idlivro = lvr.idlivro;
	
select * from Livros_emprestados;

--CONSULTAS COM AGRUPAMENTO + JOIN

--38. O nome da editora e a quantidade de livros de cada editora (LIVRO).

select * from livro order by ideditora asc;

select
	edt.nome as Editora,
	count(lvr.nome) as Qtd_livros
from
	livro as lvr
left outer join
	editora edt on lvr.ideditora = edt.ideditora
group by (edt.nome);

--39. O nome da categoria e a quantidade de livros de cada categoria (LIVRO).

select * from livro;

select
	ctg.nome,
	count(lvr.nome) as "Qtd._de_livros"
from
	livro as lvr
left outer join
	categoria ctg on lvr.idcategoria = ctg.idcategoria
group by (ctg.nome);

--40. O nome do autor e a quantidade de livros de cada autor (LIVRO_AUTOR).

select * from livro_autor

select 
	aut.nome as Autor,
	count(lva.idlivro) as "Qtd._de_livros"
from
	livro_autor as lva
left outer join
	autor aut on lva.idautor = aut.idautor
group by (aut.nome);

--41. O nome do aluno e a quantidade de empréstimo de cada aluno (EMPRESTIMO_LIVRO).

select * from emprestimo_livro ;

select 
	aln.nome,
	count(eml.idemprestimo) as "Qtd._de_emprestimo"
from
	emprestimo_livro as eml
left outer join
	emprestimo emp on eml.idemprestimo = emp.idemprestimo
left outer join
	aluno aln on emp.idaluno = aln.idaluno
group by (aln.nome)

--42. O nome do aluno e o somatório do valor total dos empréstimos de cada aluno (EMPRESTIMO).

select * from emprestimo;
	
select
	aln.nome,
	sum(emp.valor) as Valor_Emprestimo
from
	Emprestimo as emp
left outer join
	aluno aln on emp.idaluno = aln.idaluno
group by (aln.nome);

--43. O nome do aluno e o somatório do valor total dos empréstimos de cada aluno somente daqueles que o somatório for maior do que 7,00 (EMPRESTIMO).

select
	aln.nome,
	sum(emp.valor::numeric) as Valor_Emprestimo
from
	Emprestimo as emp
left outer join
	aluno aln on emp.idaluno = aln.idaluno
group by 
	aln.nome
having 
	sum(emp.valor::numeric) > 7;

--CONSULTAS COMANDOS DIVERSOS
--44. O nome de todos os alunos em ordem decrescente e em letra maiúscula.

select
	 upper (nome) as "Alunos"
from
	aluno
order by nome desc;

--45. Os empréstimos que foram feitos no mês 04 de 2012.

select * from emprestimo;

SELECT
    *
FROM
    emprestimo
WHERE
    EXTRACT(YEAR FROM data_emprestimo) = 2012
    AND EXTRACT(MONTH FROM data_emprestimo) = 4;


--46. Todos os campos do empréstimo. Caso já tenha sido devolvido, mostrar a mensagem “Devolução completa”, 
--senão “Em atraso”.

select * from emprestimo;

select 
	idemprestimo,
	case
	when devolvido = 'S' then 'Devolução completa'
	else 'Em atraso'
end as Status
	from
		emprestimo;

--47. Somente o caractere 5 até o caractere 10 do nome dos autores.

select * from autor;

select 
	nome, 
	substring(nome from 5 for 10)
from
	autor;

--48. O valor do empréstimo e somente o mês da data de empréstimo. Escreva “Janeiro”, “Fevereiro”, etc

select * from emprestimo;

select 
	valor as "Valor",
	coalesce(TO_CHAR(data_emprestimo, 'TMMonth')) as "Mês"
from
	emprestimo;

--O formato 'TMMonth' converte a data em uma string contendo o nome completo do mês com a primeira letra maiúscula e o restante em minúsculas (por exemplo, "Janeiro", "Fevereiro").
--Ex.:

SELECT 
    valor,
    TO_CHAR(data_emprestimo, 'TMMonth') AS "Mês"
FROM 
    emprestimo;


--SUBCONSULTAS
--49. A data do empréstimo e o valor dos empréstimos que o valor seja maior que a média de todos os empréstimos.

select * from emprestimo;

Select
	data_emprestimo,
	Valor
from emprestimo
	where 
		valor::numeric > (select avg(valor::numeric) from emprestimo); 
	

--50. A data do empréstimo e o valor dos empréstimos que possuem mais de um livro.

select * from emprestimo_livro;

SELECT
    emp.data_emprestimo,
    emp.valor
FROM
    emprestimo AS emp
WHERE
    (SELECT COUNT(eml.idlivro)
     FROM emprestimo_livro AS eml
     WHERE eml.idemprestimo = emp.idemprestimo) > 1;

--51. A data do empréstimo e o valor dos empréstimos que o valor seja menor que a soma de todos os empréstimos.

select * from emprestimo;

Select 
	data_emprestimo,
	valor
	from
		emprestimo
where
	valor::numeric < (select Sum(valor::numeric) from emprestimo);