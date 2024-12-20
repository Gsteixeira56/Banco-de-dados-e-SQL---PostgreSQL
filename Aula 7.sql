--Relacionamento com join
select 
	cln.nome as cliente,
	prf.nome as profissao
from 
	cliente as cln --o 'as' usado para renomear.
left outer join --informa que a tabela base que está no lado esquerdo 'left' vai se relacionar com outra tabela(profissao).
	profissao as prf on cln.idprofissao = prf.idprofissao;--Para vincular precisa inserir nesse formato.
---------------------------------------------------------

select 
	cln.nome as cliente,
	prf.nome as profissao
from 
	cliente as cln 
inner join --informa que a tabela base que está no lado vai se relacionar com outra tabela(profissao), porém é obrigado que exista um relacionamento entre os 2 id's, dados preenchidos, se não estiver, não irá aparecer.
	profissao as prf on cln.idprofissao = prf.idprofissao;--Para vincular precisa inserir nesse formato.

----------------------------------------------------------
select 
	cln.nome as cliente,
	prf.nome as profissao
from 
	cliente as cln --o 'as' usado para renomear.
right outer join --informa que a tabela base que está no lado direito 'right' vai se relacionar com outra tabela(profissao), menos usado.
	profissao as prf on cln.idprofissao = prf.idprofissao;--Para vincular precisa inserir nesse formato.


--Exercício
--1. O nome do cliente, a profissão, a nacionalidade, o logradouro, o número, o complemento, o bairro, o município e a unidade de federação.
select 
	cln.nome as cliente,
    prf.idprofissao as profissao, 
    ncn.idnacionalidade as nacionalidade,
	cln.logradouro,
	cln.numero,
	cmp.nome as complemento,
	bir.nome as bairro,
	mcp.nome as municipio,
	uf.nome as UF
from
	cliente as cln --o 'as' usado para renomear.
left outer join --informa que a tabela base que está no lado esquerdo 'left' vai se relacionar com outra tabela(profissao).
	profissao as prf on cln.idprofissao = prf.idprofissao--Para vincular precisa inserir nesse formato.
left outer join	
	nacionalidade as ncn on cln.idnacionalidade = ncn.idnacionalidade
left outer join
	complemento as cmp on cln.idcomplemento = cmp.idcomplemento
left outer join
	bairro as bir on cln.idbairro = bir.idbairro
left outer join
	municipio as mcp on cln.idmunicipio = mcp.idmunicipio
left outer join
	uf on mcp.iduf = uf.iduf

--2. O nome do produto, o valor e o nome do fornecedor.

select
	pdt.nome as produto,
	pdt.valor,
	fnc.nome as fornecedor
from
	produto as pdt
left outer join
	fornecedor as fnc on pdt.idfornecedor = fnc.idfornecedor

--3. O nome da transportadora e o município.
select * from transportadora
select
	trp.nome as transportadora,
	mnp.nome as municipio
from
	transportadora as trp
left outer join
	municipio as mnp on trp.idmunicipio = mnp.idmunicipio

--4. A data do pedido, o valor, o nome do cliente, o nome da transportadora e o nome do vendedor.

select * from vendedor
select 
	pdd.data_pedido,
	pdd.valor,
	cln.nome as Cliente,
	trp.nome as Transportadora,
	vdd.nome as Vendedor
from
	pedido as pdd
left outer join
	cliente as cln on pdd.idcliente = cln.idcliente
left outer join
	transportadora as trp on pdd.idtransportadora = trp.idtransportadora
left outer join
	vendedor as vdd on pdd.idvendedor = vdd.idvendedor
order by data_pedido asc

--5. O nome do produto, a quantidade e o valor unitário dos produtos do pedido.

select * from produto

select
	pdt.nome as produto,
	ppt.quantidade,
	ppt.valor_unitario
from
	produto as pdt
left outer join
	pedido_produto as ppt on pdt.idproduto = ppt.idproduto

--6. O nome dos clientes e a data do pedido dos clientes que fizeram algum pedido (ordenado pelo nome do cliente).

select * from cliente

select 
	cln.nome as cliente,
	pdd.data_pedido
from
	cliente as cln
inner join
	pedido as pdd on cln.idcliente = pdd.idcliente
order by nome asc

--7. O nome dos clientes e a data do pedido de todos os clientes, independente se tenham feito pedido (ordenado pelo nome do cliente).

select * from cliente

select
	cln.nome as cliente,
	pdd.data_pedido
from 
	cliente as cln
left outer join
	pedido as pdd on cln.idcliente = pdd.idcliente
order by nome asc

--8. O nome da cidade e a quantidade de clientes que moram naquela cidade.

select * from municipio;

select 
	mcp.nome as cidade,
	count(cln.nome) as "qtd. cliente"
from
	municipio as mcp
inner join
	cliente as cln on mcp.idmunicipio = cln.idmunicipio
group by cidade;


--9. O nome do fornecedor e a quantidade de produtos de cada fornecedor.

select * from produto

select
	fnc.nome as fornecedor,
	count(ppt.idproduto) as "qtd. produto"
from
	fornecedor as fnc
inner join
	produto as pdt on fnc.idfornecedor = pdt.idfornecedor
inner join
	pedido_produto as ppt on pdt.idproduto = ppt.idproduto
group by fnc.nome;

--10.O nome do cliente e o somatório do valor do pedido (agrupado por cliente).

select * from cliente order by idcliente asc

select 
	cln.nome as cliente,
	sum(pdd.valor) as pedido
from
	cliente as cln
left outer join
	pedido as pdd on cln.idcliente = pdd.idcliente
group by cln.nome order by nome asc;

--11.O nome do vendedor e o somatório do valor do pedido (agrupado por vendedor).
select * from pedido

select 
	vdd.nome as vendedor,
	sum(pdd.valor) as "valor do pedido"
from
	vendedor as vdd
left outer join
	pedido as pdd on vdd.idvendedor = pdd.idvendedor
group by nome order by nome asc
	

--12.O nome da transportadora e o somatório do valor do pedido (agrupado por transportadora).
select * from transportadora

select 
	trp.nome as transportadora,
	sum(pdd.valor) as "Valor do pedido"
from
	transportadora as trp
left outer join
	pedido as pdd on trp.idtransportadora = pdd.idtransportadora
group by nome;

--13.O nome do cliente e a quantidade de pedidos de cada um (agrupado por cliente).

select * from pedido;

select
	cln.nome as cliente,
	count(pdd.idpedido) as "qtd. pedido"
from
	cliente as cln
left outer join
	pedido as pdd on cln.idcliente = pdd.idcliente
group by nome order by nome asc;

--14.O nome do produto e a quantidade vendida (agrupado por produto).

select * from pedido_produto;

select 
	pdt.nome as produto,
	count(ppt.quantidade) as "Qtd. vendida"
from
	produto as pdt
left outer join
	pedido_produto as ppt on pdt.idproduto = ppt.idproduto
group by nome;

--15.A data do pedido e o somatório do valor dos produtos do pedido (agrupado pela data do pedido).
select * from pedido;

select 
	pdd.data_pedido,
	sum(pdt.valor_unitario) as "valor produto"
from
	pedido as pdd
left outer join
	pedido_produto as pdt on pdd.idpedido = pdt.idpedido
group by data_pedido order by data_pedido asc;
	
--16.A data do pedido e a quantidade de produtos do pedido (agrupado pela data do pedido).

select * from pedido_produto;

select
	pdd.data_pedido,
	count(ppt.idproduto) as "Qtd. de produto"
from
	pedido as pdd
left outer join
	pedido_produto as ppt on pdd.idpedido = ppt.idpedido
group by data_pedido;

--Comandos adicionais:

--EXTRACT: Extrai os dados conforme deseja

--Ex.: 

select 
	data_pedido,
	extract(day from data_pedido) as "Dia",
	extract(month from data_pedido) as "Mês",
	extract(year from data_pedido) as "Ano"
from 
	pedido;

--Substring: Filtra os caracteres que deseja.

--Ex.:

select 
	nome,
	substring(nome from 1 for 5),
	substring(nome from 2)
from 
	cliente;

--Upper: Deixa em maiúsculo os dados.

--Ex.:

select
	nome,
	upper(nome)
from
	cliente;

--Coalesce: Consegue incluir uma informação não havia(no nulo), mas não permanente. Caso, for data, precisa colocar em texto conforme o exercício 1.

--Ex.:

select
	nome,
	cpf,
	coalesce(cpf, 'Não informado')
from
	Cliente;

--Case ...when ... then: Uma condicional, caso haver o dado "Y" colocar "X", se não segue em outra condição.

--Ex.:

select * from uf
select 
	case sigla
		when 'PR' then nome
		when 'SC' then nome
	else'Outros'
	end as "UF"
from
	uf;	

--Exercícios – comandos adicionais:

--1. O nome do cliente e somente o mês de nascimento. Caso a data de nascimento não esteja preenchida mostrar a mensagem “Não informado”.

select * from cliente

SELECT
    nome,
    COALESCE(TO_CHAR(data_nascimento, 'DD/MM/YYYY'), 'Não informado') AS data_nascimento
FROM
    cliente;


--2. O nome do cliente e somente o nome do mês de nascimento (Janeiro, Fevereiro etc). Caso a data de nascimento não esteja preenchida mostrar a mensagem “Não informado”.

select * from cliente;

SELECT 
    nome,
    CASE 
        WHEN data_nascimento IS NULL THEN 'Não informado'
        ELSE TO_CHAR(data_nascimento, 'Month') -- Para PostgreSQL
        -- Para MySQL você pode usar: DATE_FORMAT(data_nascimento, '%M')
        -- Para SQL Server: DATENAME(month, data_nascimento)
    END AS mes_nascimento
FROM 
    cliente;

--3. O nome do cliente e somente o ano de nascimento. Caso a data de nascimento não esteja preenchida mostrar a mensagem “Não informado”.

select 
	nome,
	case
		when data_nascimento is null then 'Não informado'
		else (data_nascimento, 'YYYY')
	end as ano
from
	cliente;

--4. O caractere 5 até o caractere 10 de todos os municípios.

select
	substring(nome from 5 for 10)
from
	municipio;

--5. O nome de todos os municípios em letras maiúsculas.

select
	upper (nome) as "Municipio"
from
	municipio;

--6. O nome do cliente e o gênero. Caso seja M mostrar “Masculino”, senão mostrar “Feminino”.

select * from cliente;

SELECT
    nome,
    CASE
        WHEN genero = 'M' THEN 'Masculino'
        WHEN genero = 'F' THEN 'Feminino'
        ELSE 'Desconhecido' -- Caso o valor seja diferente de 'M' ou 'F'
    END AS Genero
FROM
    cliente;


--7. O nome do produto e o valor. Caso o valor seja maior do que R$ 500,00 mostrar a mensagem “Acima de 500”, caso contrário, mostrar a mensagem “Abaixo de 500”.

select * from produto;

select
	nome,
	case
		when valor > 500 then 'Acima de 500'
	else 'Abaixo de 500'
	end as valor
from 
	produto;


