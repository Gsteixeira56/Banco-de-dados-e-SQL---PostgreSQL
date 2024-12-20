--Função agregado
--média usa 'Avg()'
select avg(valor) from pedido;

--contar usa 'Count()'
select count(idmunicipio) from municipio;
--quando usa 'Count(*)' conta todas as linhas idenpedente se está nulo ou não;
select count(*) from municipio
--filtrar você usar o 'Where'
select count(idmunicipio) from municipio where iduf =2;

--saber o máximo é 'Max' e mínimo é 'MIN'
select max(valor) from pedido;
select min(valor) from pedido;

--agrupamento é 'group by', pode ser usado somente quando tem uma função agregado.
select idpedido, sum(valor) from pedido group by (idpedido);

--quando quiser criar uma condição ou filtro no agrupamento é necessário usar o 'having (função agregada usada)()'
select idpedido, sum(valor) from pedido group by (idpedido) having sum(valor) > 500;

_____________________________________

--Exercício de função agragado

select * from pedido;
--1. A média dos valores de vendas dos vendedores que venderam mais que R$ 200,00.
select avg(valor) from pedido where valor > 200;

--2. Os vendedores que venderam mais que R$ 1500,00.
select idvendedor, sum(valor) from pedido group by idvendedor having sum(valor) > 1500;

--3. O somatório das vendas de cada vendedor.
select idvendedor, sum(valor) from pedido group by idvendedor;

--4. A quantidade de municípios.
select count(nome)from municipio;

--5. A quantidade de municípios que são do Paraná ou de Santa Catarina.
select count(*) from municipio where iduf = 1 or iduf = 2 group by iduf;

--6. A quantidade de municípios por estado.
select iduf, count(nome) from municipio group by iduf;

--7. A quantidade de clientes que informaram o logradouro.
select count(idcliente) from cliente where logradouro is not null and logradouro <> '';

--8. A quantidade de clientes por município.
select idmunicipio, count(idcliente) from cliente group by idmunicipio;

--9. A quantidade de fornecedores.
select count(*) from fornecedor;

--10. A quantidade de produtos por fornecedor.
select idfornecedor,count(idproduto) from produto group by idfornecedor; 

--11. A média de preços dos produtos do fornecedor Cap. Computadores.
select avg(valor) from produto where idfornecedor = 1;

--12. O somatório dos preços de todos os produtos.
select sum(valor) from produto;

--13. O nome do produto e o preço somente do produto mais caro.
SELECT nome,valor
FROM produto
WHERE valor = (SELECT MAX(valor) FROM produto);

--14. O nome do produto e o preço somente do produto mais barato.
select nome, valor from produto where valor = (select min(valor) from produto);

--15. A média de preço de todos os produtos.
select avg(valor) from produto;

--16. A quantidade de transportadoras.
select count(idtransportadora) from transportadora;

--17. A média do valor de todos os pedidos.
select avg(valor) from pedido;

--18. O somatório do valor do pedido agrupado por cliente.
select idcliente, sum(valor) from pedido group by idcliente;

--19. O somatório do valor do pedido agrupado por vendedor.
select idvendedor, sum(valor) from pedido group by idvendedor;

--20. O somatório do valor do pedido agrupado por transportadora.
select idtransportadora, sum(valor) from pedido group by idtransportadora;

--21. O somatório do valor do pedido agrupado pela data.
select data_pedido, sum(valor) from pedido group by data_pedido;

--22. O somatório do valor do pedido agrupado por cliente, vendedor e transportadora.
select idcliente, idvendedor, idtransportadora, sum(valor) from pedido group by idcliente, idvendedor, idtransportadora;

--23. O somatório do valor do pedido que esteja entre 01/04/2008 e 10/12/2009 e que seja maior que R$ 200,00.
select sum(valor) from pedido where data_pedido between ('2008-04-01') and ('2009-12-10') and valor > 200;

--24. A média do valor do pedido do vendedor André.
select avg(valor) from pedido where idvendedor = 1;

--25. A média do valor do pedido da cliente Jéssica.
select avg(valor) from pedido where idcliente = 1;

--26. A quantidade de pedidos transportados pela transportadora BS. Transportes.
select count(idpedido) from pedido where idtransportadora = 1;

--27. A quantidade de pedidos agrupados por vendedor.
select idvendedor, count(idpedido) from pedido group by idvendedor order by idvendedor asc;

--28. A quantidade de pedidos agrupados por cliente.
select idcliente, count(idpedido) from pedido group by idcliente;

--29. A quantidade de pedidos entre 15/04/2008 e 25/04/2008.
select count(idpedido) from pedido where data_pedido between ('2008-04-15') and ('2008-04-25');

--30. A quantidade de pedidos que o valor seja maior que R$ 1.000,00.
select count(valor) from pedido where valor > 1000;

select * from pedido_produto;
--31. A quantidade de microcomputadores vendida.
select sum(quantidade) from pedido_produto where idproduto = 1;

--32. A quantidade de produtos vendida agrupado por produto.
select idproduto, sum(quantidade) from pedido_produto group by (idproduto) order by idproduto asc;

--33. O somatório do valor dos produtos dos pedidos, agrupado por pedido.
select idpedido, sum(valor_unitario) from pedido_produto group by (idpedido) order by idpedido asc;

--34. A quantidade de produtos agrupados por pedido.
select idpedido,count(idproduto) from pedido_produto group by (idpedido);

--35. O somatório do valor total de todos os produtos do pedido.
select sum(valor) from pedido;

--36. A média dos produtos do pedido 6.
select idpedido, avg(quantidade) from pedido_produto where idpedido = 6 group by (idpedido);

--37. O valor do maior produto do pedido.
select idpedido, max(valor_unitario) from pedido_produto group by (idpedido);

--38. O valor do menor produto do pedido.
select idpedido, min(valor_unitario) from pedido_produto group by (idpedido);

--39. O somatório da quantidade de produtos por pedido.
select idpedido, sum(quantidade) from pedido_produto group by idpedido;


select * from pedido_produto;
--40. O somatório da quantidade de todos os produtos do pedido.
select idpedido, sum(quantidade) from pedido_produto group by idpedido;