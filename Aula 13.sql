--Triggers

Create table bairro_auditoria (
	idbairro integer not null,
	data_criacao timestamp not null
)

select * from bairro_auditoria


create or replace function bairro_log() returns trigger language plpgsql as 
$$
	begin
	--old 4 --> new 6
		insert into bairro_auditoria (idbairro ,data_criacao) values (new.idbairro, current_timestamp);
	return new;
	end;
$$

create or replace trigger log_bairro_trigger after insert on bairro for each row execute procedure bairro_log();

call insere_bairro ('Teste 10');
call insere_bairro ('Teste 20');
call insere_bairro ('Teste 30');

select * from bairro;


--EXERCÍCIOS
--Exercícios triggers

--1. Crie uma tabela chamada PEDIDOS_APAGADOS.

Create table PEDIDOS_APAGADOS(
	idpedido integer not null,
	idcliente integer not null,
	idtransportadora integer not null,
	idvendedor integer not null,
	data_pedido date not null,
	valor float not null,
	data_apagada timestamp not null 
);

select * from pedidos_apagados;

--2. Faça uma trigger que quando um pedido for apagado, todos os seus dados devem ser copiados para a tabela PEDIDOS_APAGADOS

create or replace function pedidos_log() returns trigger language plpgsql as 
$$
	begin
	--old 4 --> new 6
		insert into pedidos_apagados (idpedido ,idcliente, idtransportadora, idvendedor, data_pedido, valor, data_apagada) values (old.idpedido ,old.idcliente,old.idtransportadora,old.idvendedor, old.data_pedido, old.valor, current_timestamp);
	return old;
	end;
$$;

create or replace trigger log_pedido_trigger before delete on pedido for each row execute procedure pedidos_log();

select idpedido from pedido where idpedido not in (select idpedido from pedido_produto);

delete from pedido where idpedido = 17;

select * from pedidos_apagados;


-- Domínios:
-- Dominio é um tipo de dado definido por usuário para criar uma referência da tabela e padronizar as tabelas.
-- IDs, tipos que há de Domínios:
create domain idcurto as smallint;
create domain idmedio as integer;
create domain idlongo as bigint;

-- Regra dos Caracteres em dominios:
create domain sigla as char(3);
create domain codigo as varchar(10);
create domain nome_curto as varchar(15);
create domain nome_longo as varchar(70);
create domain nome_medio as varchar(50);

-- Data e hora de domínios:
create domain data as date;
create domain hora as time;
create domain data_hora timestamp;

-- Númericos de domínios:
create domain moeda as numeric(10,2);
create domain float_curto as numeric(6,2);
create domain float_medio as numeric(10,2);
create domain float_longo as numeric(15,2);

alter table bairro alter column nome type nome_medio;

--Exercícios:
create domain documento as varchar(15);
create domain tipo as char(1);
create domain texto as text;
create domain quantidade as smallint;

alter table bairro_auditoria alter column data_criacao type data_hora;

select * from cliente;

alter table cliente alter column nome type nome_longo;
alter table cliente alter column cpf type documento;
alter table cliente alter column rg type documento;
alter table cliente alter column data_nascimento type date;
alter table cliente alter column genero type tipo;
alter table cliente alter column logradouro type nome_longo;
alter table cliente alter column numero type nome_curto;
alter table cliente alter column observacoes type nome_longo;
alter table cliente alter column idprofissao type idmedio;
alter table cliente alter column idnacionalidade type idmedio;
alter table cliente alter column idbairro type idmedio;
alter table cliente alter column idmunicipio type idmedio;
alter table cliente alter column idcomplemento type idmedio;


select * from complemento

alter table complemento alter column nome type nome_medio;

select * from exemplo;

alter table exemplo alter column nome type nome_medio;

select * from fornecedor;

alter table fornecedor alter column nome type nome_medio;

select * from municipio;

alter table municipio alter column nome type nome_medio;
alter table municipio alter column iduf type idmedio;

drop view dados_municipio
drop view dado_transportadora 

select * from nacionalidade;

alter table nacionalidade alter column nome type nome_medio;

select * from pedido;

alter table pedido alter column idpedido type idlongo;
alter table pedido alter column idcliente type idmedio;
alter table pedido alter column idtransportadora type idmedio;
alter table pedido alter column idvendedor type idmedio;
alter table pedido alter column data_pedido type data;
alter table pedido alter column valor type moeda;

select * from pedido_produto;

alter table pedido_produto alter column idpedido type idlongo;
alter table pedido_produto alter column idproduto type idmedio;
alter table pedido_produto alter column quantidade type quantidade;
alter table pedido_produto alter column valor_unitario type moeda;

drop view produto_pedido

select * from pedidos_apagados;

alter table pedidos_apagados alter column idpedido type idlongo;
alter table pedidos_apagados alter column idcliente type idmedio;
alter table pedidos_apagados alter column idtransportadora type idmedio;
alter table pedidos_apagados alter column idvendedor type idmedio;
alter table pedidos_apagados alter column data_pedido type data;
alter table pedidos_apagados alter column valor type moeda;
alter table pedidos_apagados alter column data_apagada type data_hora;

select * from produto;

alter table produto alter column nome type nome_medio;
alter table produto alter column valor type moeda;

select * from profissao;
alter table profissao alter column nome type nome_medio;

select * from transportadora;
alter table transportadora alter column idmunicipio type idmedio;
alter table transportadora alter column nome type nome_medio;
alter table transportadora alter column logradouro type nome_longo;
alter table transportadora alter column numero type nome_curto;

select * from uf;
alter table uf alter column nome type nome_medio;
alter table uf alter column sigla type sigla;

select * from vendedor;
alter table vendedor alter column nome type nome_medio;




--Usuários e permissões:
Create role gerente;--role = papel
Create role estagiario;--role = papel
--Criando a regras do que o usuario pode acessar.
grant select, insert, delete, update on bairro, bairro_auditoria, cliente, complemento, exemplo, fornecedor, municipio, nacionalidade, pedido, pedido_produto, pedidos_apagados, produto, profissao, transportadora, uf, vendedor to gerente with grant option;
grant all on all sequences in schema public to gerente; --Liberamos o acesso nas sequencias para o gerente.
grant select on dados_dos_clientes, produto_pedido to estagiario with grant option;

create role maria login password '123' in role gerente;
create role pedro login password '321' in role estagiario;

-- Teste (gerente);
select * from cliente;
insert into cliente (nome) values ('Teste permissão');
delete from cliente where idcliente = 18;

select * from produto_pedido; -- Não funciona, pois não liberado o acesso. Teria que liberar conforme foi ao estagiario;

-- Teste (estagiario);

select * from cliente; -- Não tem acesso;
select * from dados_dos_clientes; -- Tem acesso;

--Exercícios usuários e permissões

--1. Crie um novo papel chamado “atendente”

create role atendente;

--2. Defina somente permissões para o novo papel poder selecionar e incluir novos pedidos (tabelas pedido e pedido_produto). O restante do acesso deve estar bloqueado

grant select , insert on pedido, pedido_produto to atendente with grant option;
grant all on pedido_id_seq to atendente with grant option;

--3. Crie um novo usuário associado ao novo papel

create role gustavo login password '123' in role atendente;

--4. Realize testes para verificar se as permissões foram aplicadas corre

select * from pedido;

insert into pedido (idpedido,idcliente,idtransportadora,idvendedor) values (19,1,1,2);


--Transações:
--Isso garante a existência dos dados;

create table conta(
	idconta serial not null,
	cliente nome_medio not null,
	saldo moeda not null default 0,

	constraint pk_cnt_idconta primary key (idconta)
);

insert into conta (cliente, saldo) values ('Cliente 1', 1000);
insert into conta (cliente, saldo) values ('Cliente 2', 500);

select * from conta;

update conta set saldo = saldo -100 where idconta = 1;
update conta set saldo = saldo +100 where idconta = 2;

begin;
update conta set saldo = saldo -100 where idconta = 1;
update conta set saldo = saldo +100 where idconta = 2;
rollback; --cancela o comando que está entre begin e rollback;

begin;
update conta set saldo = saldo -100 where idconta = 1;
update conta set saldo = saldo +100 where idconta = 2;
commit; --commit confirma se foi feito as alterações;
