--Subconsultas

--Selecionar a data do pedido e o valor onde o valor seja maior que a média dos valores de todos os pedidos

select
	data_pedido,
	valor
from
	pedido
where
	valor > (select avg(valor) from pedido);

--Exemplo com count

select 
	pdd.data_pedido,
	pdd.valor,
	(select sum(quantidade) from pedido_produto pdp where pdp.idpedido = pdd.idpedido) as total
from
	pedido pdd;

--Exemplo com update

select * from pedido;

update pedido set valor = valor + ((valor * 5)/100)
where valor > (select avg(valor) from pedido);


--Exercícios - subconsultas

--1. O nome dos clientes que moram na mesma cidade do Marina. Não deve ser mostrado o Marina.

select * from cliente;

SELECT 
    nome,
	idmunicipio
FROM 
    cliente cln
where
	idmunicipio = (select idmunicipio from cliente where nome ='Marina')
and 
	idcliente <> 1;

--2. A data e o valor dos pedidos que o valor do pedido seja menor que a média de todos os pedidos.

select * from pedido;

select
	data_pedido,
	valor
from
	pedido
where 
	valor <(select avg(valor) from pedido);


--3. A data,o valor, o cliente e o vendedor dos pedidos que possuem 2 ou mais produtos.

select * from pedido_produto;

select
	ppd.data_pedido,
	ppd.valor,
	cln.nome as Cliente,
	vdd.nome as Vendedor,
	(select count(idproduto) from pedido_produto pdp where pdp.idpedido = ppd.idpedido) --checar se está correto
from
	pedido ppd
left outer join
	cliente cln on ppd.idcliente = cln.idcliente
left outer join
	vendedor vdd on ppd.idvendedor = vdd.idvendedor
where
	(select count(idproduto) from pedido_produto pdp where pdp.idpedido = ppd.idpedido) >= 2;

--4. O nome dos clientes que moram na mesma cidade da transportadora BSTransportes.

select * from transportadora;

select 
	cln.nome,
	idmunicipio
from
	cliente cln
where
	idmunicipio =(select idmunicipio from transportadora trp where idtransportadora = 1)


--5. O nome do cliente e o município dos clientes que estão localizados no mesmo município de qualquer uma das transportadoras.

select * from cliente;

select
	nome,
	idmunicipio
from
	cliente cln
where
	idmunicipio 
in(select idmunicipio from transportadora);

--6. Atualizar o valor do pedido em 5% para os pedidos que o somatório do valor total dos produtos daquele pedido seja maior que a média do valor total
--de todos os produtos de todos os pedidos.

update
	pedido
set
	valor = valor + ((valor * 5) /100)
where
	(select sum(pdp.valor_unitario) from pedido_produto pdp where pdp.idpedido = pedido.idpedido) > (select avg(valor_unitario) from pedido_produto);

select * from pedido;

--7. O nome do cliente e a quantidade de pedidos feitos pelo cliente.

select * from pedido;

select 
	cln.nome,
	(select count(idpedido) from pedido pdd where pdd.idcliente = cln.idcliente) as total
from
	cliente as cln


--8. Para revisar, refaça o exercício anterior (número 07) 
--utilizando group by e mostrando somente os clientes que fizeram pelo menos um pedido.

select * from pedido order by idcliente asc;

select
	cln.nome as cliente,
	count(pdd.idpedido) as total
from
	pedido pdd
left outer join
	cliente cln on pdd.idcliente = cln.idcliente
group by 
	cln.nome
order by cln.nome asc;