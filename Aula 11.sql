-- Exemplo 1: Usando funções básicas no SQL
-- O objetivo é formatar o valor dos pedidos em moeda brasileira (R$).

SELECT 
    valor, 
    CONCAT('R$ ', ROUND(CAST(valor AS numeric), 2)) AS valor_formatado
FROM 
    pedido;

-- Explicações:
-- ROUND: Arredonda o número para o número de casas decimais especificado (2 neste caso).
-- CAST(valor AS numeric): Converte o campo 'valor' para o tipo numérico.
-- CONCAT('R$ ', ...): Concatena o símbolo "R$" com o valor arredondado para exibir em formato de moeda.


-- Exemplo 2: Criando uma função de formatação de moeda
-- Função 'formata_moeda' para simplificar o processo de formatação do valor em "R$".
CREATE FUNCTION formata_moeda(valor FLOAT) 
RETURNS VARCHAR(20) 
LANGUAGE plpgsql  -- Define que a função será escrita em PL/pgSQL.
AS $$
BEGIN
    RETURN CONCAT('R$ ', ROUND(CAST(valor AS numeric), 2));  -- Retorna o valor formatado como moeda.
END;
$$;

-- Uso da função 'formata_moeda' para simplificar a formatação do valor de 'pedido' e 'produto'.
SELECT 
    valor, 
    formata_moeda(valor) 
FROM 
    pedido;

SELECT 
    valor, 
    formata_moeda(valor) 
FROM 
    produto;


-- Exemplo 3: Criando uma função que busca o nome do cliente pelo ID
-- A função 'get_nome_by_id' recebe um 'idcliente' e retorna o nome correspondente.

CREATE FUNCTION get_nome_by_id(idc INTEGER) 
RETURNS VARCHAR(50) 
LANGUAGE plpgsql  -- Especifica a linguagem procedural do PostgreSQL (PL/pgSQL).
AS $$
DECLARE 
    r VARCHAR(50);  -- Declara uma variável 'r' do tipo VARCHAR(50) para armazenar o nome do cliente.
BEGIN
    SELECT nome INTO r  -- Armazena o resultado da consulta (nome do cliente) na variável 'r'.
    FROM cliente 
    WHERE idcliente = idc;  -- Busca o nome do cliente com base no 'idcliente' fornecido.
    
    RETURN r;  -- Retorna o valor armazenado na variável 'r'.
END;
$$;

-- CREATE FUNCTION: Define uma nova função no PostgreSQL para encapsular lógica que pode ser reutilizada em várias consultas.

-- LANGUAGE plpgsql: Especifica a linguagem procedural do PostgreSQL (PL/pgSQL), que permite criar funções complexas.

-- DECLARE: Dentro da função, declara variáveis que podem ser usadas para armazenar dados temporários; neste caso, r armazena o nome do cliente.

-- INTO: Armazena o resultado de uma consulta em uma variável. Aqui, SELECT nome INTO r armazena o nome do cliente na variável r.


-- Teste da função 'get_nome_by_id' para exibir o nome do cliente a partir do ID no pedido.
SELECT 
    data_pedido, 
    valor, 
    idcliente, 
    get_nome_by_id(idcliente) AS nome_cliente 
FROM 
    pedido;


--Exercícios funções

--1. Crie uma função que receba como parâmetro o ID do pedido e retorne o valor total deste pedido;

select * from pedido;

CREATE FUNCTION get_valor_total(idp INTEGER)
RETURNS numeric(10,2)
LANGUAGE plpgsql
AS $$
DECLARE
    total_valor NUMERIC(10,2);  -- Declara a variável que armazena o valor total do pedido
BEGIN
    -- Calcula e armazena o valor total do pedido com o ID fornecido em total_valor
    SELECT SUM(valor)
    INTO total_valor
    FROM pedido
    WHERE idpedido = idp;  -- Filtra pelo ID do pedido passado como parâmetro

    RETURN total_valor;  -- Retorna o valor total do pedido
END;
$$;

SELECT 
    idpedido, 
    get_valor_total(idpedido) AS valor_total
FROM 
    pedido
order by idpedido asc;

--2. Crie uma função chamada “maior”, que quando executada retorne o pedido com o maior valor;

create FUNCTION get_pedido_maximo()
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN (SELECT IDPEDIDO FROM PEDIDO WHERE VALOR = (SELECT (MAX(VALOR)) FROM PEDIDO));
END;
$$;

select
	get_pedido_maximo() --Nesse caso não há necessidade de colocar o from, pois, aparecia muitas vezes.