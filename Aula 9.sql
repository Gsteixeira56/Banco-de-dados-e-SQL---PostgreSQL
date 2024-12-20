-- Views

--é usada para visualizar a tabela, onde não precisará usar todas as vezes "left outer join"

--EX.:
create view cliente_profissao as 
select 
	cln.nome as cliente,
	prf.nome as profissao
from
	cliente cln
left outer join
	profissao prf on cln.idprofissao = prf.idprofissao

--criamos uma view, após criar, pode selecionar como se fosse uma tabela normal e consultar.
--Obs.: Quando selecionar a coluna deseja na view, precisa ser o nome que você renomeou, conforme exemplo abaixo;

select 
	cliente
from 
	cliente_profissao
where 
	profissao = 'Estudante';

--Obs.: Caso, queria atualizar a consulta, precisa remover e criar de novo, conforme exemplo abaixo.

Drop view cliente_profissao; 

create view cliente_profissao as 
select 
	cln.nome as cliente,
	cln.cpf,
	prf.nome as profissao
from
	cliente cln
left outer join
	profissao prf on cln.idprofissao = prf.idprofissao;

select 
	*
from 
	cliente_profissao;

--Exercícios views

--1. O nome, a profissão, a nacionalidade, o complemento, o município, a unidade de federação, o bairro, o CPF,o RG, a data de nascimento, o gênero (mostrar “Masculino” ou “Feminino”), o logradouro, o número e as observações dos clientes.
drop view dados_dos_clientes;
select * from profissao;
create view dados_dos_clientes as 
Select 
	cln.nome as Cliente,
	prf.nome as Profissão,
	ncm.nome as Nacionalidade,
	cpl.nome as Complemento,
	mnc.nome as Municipio,
	uf.nome as UF,
	brr.nome as Bairro,
	cpf,
	rg,
	data_nascimento,
	case
		when genero = 'M' then 'Masculino'
		when genero = 'F' then 'Feminino'
	else 'Desconhecido'
	end as Genero,
	logradouro,
	numero,
	observacoes
from
	cliente cln
left outer join
	profissao prf on cln.idprofissao = prf.idprofissao
left outer join
	nacionalidade ncm on cln.idnacionalidade = ncm.idnacionalidade
left outer join
	complemento cpl on cln.idcomplemento = cpl.idcomplemento
left outer join
	municipio mnc on cln.idmunicipio = mnc.idmunicipio
left outer join
	uf on mnc.iduf = uf.iduf
left outer join
	bairro brr on cln.idbairro = brr.idbairro;

select * from dados_dos_clientes;

--2. O nome do município e o nome e a sigla da unidade da federação.

select * from uf;

create view dados_municipio as
select 
	mnc.nome as municipio,
	uf.nome as UF,
	uf.sigla as Sigla
from
	municipio mnc
left outer join
	uf on mnc.iduf = uf.iduf;

select * from dados_municipio;

--3. O nome do produto, o valor e o nome do fornecedor dos produtos.
select * from produto;

create view dado_produto as 
select
	pdt.nome as Produto,
	pdt.valor as Valor,
	fnc.nome as Fornecedor
from
	produto pdt
left outer join
	fornecedor fnc on pdt.idfornecedor = fnc.idfornecedor;

select * from dado_produto;

--4. O nome da transportadora, o logradouro, o número, o nome da unidade de federação e a sigla da unidade de federação das transportadoras.

select * from uf;

create view dado_transportadora as
select
	trp.nome as Transportadora,
	trp.logradouro as Logradouro,
	trp.numero as Número,
	uf.nome as Uf,
	uf.sigla as Sigla
from
	transportadora trp
left outer join
	municipio mnc on trp.idmunicipio = mnc.idmunicipio
left outer join
	uf on mnc.iduf = uf.iduf;

select * from dado_transportadora;
	

--5. A data do pedido, o valor, o nome da transportadora, o nome do cliente e o nome do vendedor dos pedidos.

select * from vendedor;

create view dado_dos_vendedor as 
select
	pdd.data_pedido,
	pdd.valor,
	trp.nome as Transportadora,
	cln.nome as Cliente,
	vdd.nome as Vendedor
from
	pedido as pdd
left outer join
	transportadora trp on pdd.idtransportadora = trp.idtransportadora
left outer join
	cliente cln on pdd.idcliente = cln.idcliente
left outer join
	vendedor vdd on pdd.idvendedor = vdd.idvendedor;

select * from dado_dos_vendedor;


--6. O nome do produto, a quantidade, o valor unitário e o valor total dos produtos do pedido.

select * from pedido_produto;

create view produto_pedido as
select 
	pdt.nome as Produto,
	sum(ppt.valor_unitario) as Valor_unitario,
	sum(ppt.quantidade) as Qtd
from
	produto pdt
left outer join
	pedido_produto ppt on pdt.idproduto = ppt.idproduto
group by pdt.nome;

select * from produto_pedido;


--Campo Autoincremento
--Adiciona sem precisar incluir a chave primaria toda vez, esse recurso é automático, após criar a tebela e colocar a condicional "serial" ao inves de "integer"
--ex.:
create table exemplo (
	idexemplo serial not null,
	nome varchar(50) not null,

	constraint pk_exemplo_idexemplo primary key (idexemplo)
)

insert into exemplo (nome) values ('Exemplo 1');
insert into exemplo (nome) values ('Exemplo 2');
insert into exemplo (nome) values ('Exemplo 3');
insert into exemplo (nome) values ('Exemplo 4');
insert into exemplo (nome) values ('Exemplo 5');

select * from exemplo;

--Para alterar a chave primaria, vamos precisar relacionar o id com o serial, conforme exemplo abaixo:

select max(idbairro) +1 from bairro; -- Ver a qtd. de ids e adicionamos + 1 para incluir um novo dado no serial
create sequence bairro_id_seq minvalue 5; --Cria uma sequência(serial), coloca a função do Postgrees e coloca qtd. total de id's.
alter table bairro alter idbairro set default nextval('bairro_id_seq');--Alteramos a tabela e vincula o serial no default do id, usando 'Nextval' e colocando nome da chave.
alter sequence bairro_id_seq owned by bairro.idbairro;--Incluimos o dono dessa tabela em código, usando 'Owned by'(pode ser feito sem código, indo na propiedade da tabela).

--Agora, incluímos testes na tabela:

--Ex.: 
insert into bairro (nome) values ('Teste 1');
insert into bairro (nome) values ('Teste 2');

select * from bairro;


--Exercício:

--1. Criar sequências para todas as outras tabelas da base de dados

--a. Cliente

select max(idcliente) + 1 from cliente;
create sequence cliente_id_seq minvalue 18;
alter table cliente alter idcliente set default nextval('cliente_id_seq');
alter sequence cliente_id_seq owned by cliente.idcliente;

select * from cliente;

--b. Complemento

select max(idcomplemento) + 1 from complemento;
create sequence complemento_id_seq minvalue 3;
alter table complemento alter idcomplemento set default nextval('complemento_id_seq');
alter sequence complemento_id_seq owned by complemento.idcomplemento;

select * from complemento;

--c. Fornecedor
select * from fornecedor;

select max(idfornecedor) +1 from fornecedor;
create sequence fornecedor_id_seq minvalue 4;
alter table fornecedor alter idfornecedor set default nextval ('fornecedor_id_seq');
alter sequence fornecedor_id_seq owned by fornecedor.idfornecedor;

--d. Município

select max(idmunicipio) +1 from municipio;
create sequence municipio_id_seq minvalue 10;
alter table municipio alter idmunicipio set default nextval('municipio_id_seq');
alter sequence municipio_id_seq owned by municipio.idmunicipio;

--e. Nacionalidade

select * from nacionalidade;

select max(idnacionalidade) +1 from nacionalidade;
create sequence nacionalidade_id_seq minvalue 5;
alter table nacionalidade alter idnacionalidade set default nextval('nacionalidade_id_seq');
alter sequence nacionalidade_id_seq owned by nacionalidade.idnacionalidade;

--f. Pedido

select max(idpedido) +1 from pedido;
create sequence pedido_id_seq minvalue 16;
alter table pedido alter idpedido set default nextval('pedido_id_seq');
alter sequence pedido_id_seq owned by pedido.idpedido;


--g. Pedido produto (verificar se é necessário)

--Não precisa pois a chaves primárias são das outras tabelas ela recebe automática do 'Idpedido' e 'Idproduto'.

--h. Profissão

select * from profissao;

select max(idprofissao) +1 from profissao;
create sequence profissao_id_seq minvalue 6;
alter table profissao alter idprofissao set default nextval('profissao_id_seq');
alter sequence profissao_id_seq owned by profissao.idprofissao;

--i. Transportadora

select * from Transportadora;

select max(idtransportadora) +1 from transportadora;
create sequence transportadora_id_seq minvalue 3;
alter table transportadora alter idtransportadora set default nextval('transportadora_id_seq');
alter sequence transportadora_id_seq owned by transportadora.idtransportadora;

--j. UF

select max (iduf) +1 from uf;
create sequence uf_id_seq minvalue 7;
alter table uf alter iduf set default nextval('uf_id_seq');
alter sequence uf_id_seq owned by uf.iduf;

--k. Vendedor

select max (idvendedor) +1 from vendedor;
create sequence vendedor_id_seq minvalue 9;
alter table vendedor alter idvendedor set default nextval('vendedor_id_seq');
alter sequence vendedor_id_seq owned by vendedor.idvendedor;

--L. Produto

select max(idproduto) +1 from produto;
create sequence produto_id_seq minvalue 9;
alter table produto alter idproduto set default nextval('produto_id_seq');
alter sequence produto_id_seq owned by produto.idproduto;

--Campos default:
--No campo default codificamos as regras dos valores nulos que precisa ser preenchido, como data do pedido na tabela pedido. Isso é importante pois esses dados nulos pode afetar os cálculos, como: média e somatório;
--EX.:

alter table pedido alter column data_pedido set default current_date; -- Current date= data atual
alter table pedido alter column valor set default 0;
insert into pedido (idcliente, idvendedor) values (1,1) --inserimos valores testes
insert into pedido (idcliente, idvendedor, data_pedido, valor)
values (1,1,'2022-10-10',234) --Dados testes também, porém colocamos a 'Data_pedido' e 'Valor' manualmente.

select * from pedido order by idpedido; 

--Exercícios valores default:

--1. Adicione valores default na tabela de produtos do pedido

--a. Quantidade com o valor 1

alter table pedido_produto alter column quantidade set default 1;

--b. Valor unitário com o valor 0

alter table pedido_produto alter column valor_unitario set default 0;

select * from pedido_produto;

insert into pedido_produto (idpedido, idproduto)
	values (16,1);

--2. Adicione valor default na tabela de produtos

--a. Valor com o valor 0

select * from produto;

alter table produto alter column valor set default 0;

insert into produto (idproduto, idfornecedor, nome) values (8,1,'Teste');

--Índices
--Um índice é utilizado para acelerar as pesquisas na base de dados, ela é muito importante em big data, pois, o desempenho é melhor.
--Obs.: Quanto mais índices mais os dados ficam pesados, importante colocar nos essenciais.
Create index idx_cln_nome on cliente (nome);

--Exercícios índices



--1. Adicione índices nas seguintes tabelas e campos

--a. Pedido – data do pedido

create index idx_pdd_data_pedido on pedido(data_pedido);

--b. Produto – nome

create index idx_pdt_nome on produto(nome);
