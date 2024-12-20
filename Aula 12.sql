-- Stored procedures;

--Uma stored procedure é um conjunto de comandos SQL armazenado no banco de dados para facilitar operações repetitivas. 
--Em vez de reescrever o mesmo código, você executa a procedure sempre que precisar.

Create procedure insere_bairro(nome_bairro varchar(30)) language sql as 
$$
	insert into bairro (nome) values (nome_bairro);
$$;

call insere_bairro('Teste procedure')
select * from bairro;

--Exercícios procedures

--1. Crie uma stored procedure que receba como parâmetro o ID do produto e o percentual de aumento, 
--e reajuste o preço somente deste produto de acordo com o valor passado como parâmetro

Create or replace procedure reajuste_produto(idp integer, percentual float) language sql as
$$
	update produto set valor = valor + ((valor * percentual) / 100) where idproduto = idp;
$$;

select * from produto;
call reajuste_produto(1,10)

--2. Crie uma stored procedure que receba como parâmetro o ID do produto e exclua da base de dados 
--somente o produto com o ID correspondente.

Create procedure exclua_dados_produto(idp integer) language sql as
$$
	delete from produto where idproduto = idp;
$$;

select * from produto;
call exclua_dados_produto(8)