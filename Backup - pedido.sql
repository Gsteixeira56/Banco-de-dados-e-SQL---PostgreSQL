PGDMP      /        
    
    |            pedido    16.3    16.3 �               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16420    pedido    DATABASE     }   CREATE DATABASE pedido WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE pedido;
                postgres    false            �           1247    16859    codigo    DOMAIN     6   CREATE DOMAIN public.codigo AS character varying(10);
    DROP DOMAIN public.codigo;
       public          postgres    false            �           1247    16865    data    DOMAIN     #   CREATE DOMAIN public.data AS date;
    DROP DOMAIN public.data;
       public          postgres    false            �           1247    16869 	   data_hora    DOMAIN     ?   CREATE DOMAIN public.data_hora AS timestamp without time zone;
    DROP DOMAIN public.data_hora;
       public          postgres    false            �           1247    16890 	   documento    DOMAIN     9   CREATE DOMAIN public.documento AS character varying(15);
    DROP DOMAIN public.documento;
       public          postgres    false            �           1247    16873    float_curto    DOMAIN     2   CREATE DOMAIN public.float_curto AS numeric(6,2);
     DROP DOMAIN public.float_curto;
       public          postgres    false            �           1247    16877    float_longo    DOMAIN     3   CREATE DOMAIN public.float_longo AS numeric(15,2);
     DROP DOMAIN public.float_longo;
       public          postgres    false            �           1247    16875    float_medio    DOMAIN     3   CREATE DOMAIN public.float_medio AS numeric(10,2);
     DROP DOMAIN public.float_medio;
       public          postgres    false            �           1247    16867    hora    DOMAIN     5   CREATE DOMAIN public.hora AS time without time zone;
    DROP DOMAIN public.hora;
       public          postgres    false            �           1247    16851    idcurto    DOMAIN     *   CREATE DOMAIN public.idcurto AS smallint;
    DROP DOMAIN public.idcurto;
       public          postgres    false            �           1247    16855    idlongo    DOMAIN     (   CREATE DOMAIN public.idlongo AS bigint;
    DROP DOMAIN public.idlongo;
       public          postgres    false            �           1247    16853    idmedio    DOMAIN     )   CREATE DOMAIN public.idmedio AS integer;
    DROP DOMAIN public.idmedio;
       public          postgres    false            �           1247    16871    moeda    DOMAIN     -   CREATE DOMAIN public.moeda AS numeric(10,2);
    DROP DOMAIN public.moeda;
       public          postgres    false            �           1247    16861 
   nome_curto    DOMAIN     :   CREATE DOMAIN public.nome_curto AS character varying(15);
    DROP DOMAIN public.nome_curto;
       public          postgres    false            �           1247    16863 
   nome_longo    DOMAIN     :   CREATE DOMAIN public.nome_longo AS character varying(70);
    DROP DOMAIN public.nome_longo;
       public          postgres    false            �           1247    16879 
   nome_medio    DOMAIN     :   CREATE DOMAIN public.nome_medio AS character varying(50);
    DROP DOMAIN public.nome_medio;
       public          postgres    false            �           1247    16896 
   quantidade    DOMAIN     -   CREATE DOMAIN public.quantidade AS smallint;
    DROP DOMAIN public.quantidade;
       public          postgres    false            �           1247    16857    sigla    DOMAIN     ,   CREATE DOMAIN public.sigla AS character(3);
    DROP DOMAIN public.sigla;
       public          postgres    false            �           1247    16894    texto    DOMAIN     $   CREATE DOMAIN public.texto AS text;
    DROP DOMAIN public.texto;
       public          postgres    false            �           1247    16892    tipo    DOMAIN     +   CREATE DOMAIN public.tipo AS character(1);
    DROP DOMAIN public.tipo;
       public          postgres    false                       1255    16840    bairro_log()    FUNCTION     �   CREATE FUNCTION public.bairro_log() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
	--old 4 --> new 6
		insert into bairro_auditoria (idbairro ,data_criacao) values (new.idbairro, current_timestamp);
	return new;
	end;
$$;
 #   DROP FUNCTION public.bairro_log();
       public          postgres    false                       1255    16836    exclua_dados_produto(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.exclua_dados_produto(IN idp integer)
    LANGUAGE sql
    AS $$
	delete from produto where idproduto = idp;
$$;
 <   DROP PROCEDURE public.exclua_dados_produto(IN idp integer);
       public          postgres    false            �            1255    16825    formata_moeda(double precision)    FUNCTION     <  CREATE FUNCTION public.formata_moeda(valor double precision) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
begin --begin: começo do bloco
	return concat('R$ ', round(cast(valor as numeric),2)); --; colocar final desse comando.
end; --; colocamos para finalizar esse bloco. E END: final do comando.
$_$;
 <   DROP FUNCTION public.formata_moeda(valor double precision);
       public          postgres    false            �            1255    16826    get_nome_by_id(integer)    FUNCTION     �   CREATE FUNCTION public.get_nome_by_id(idc integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare r varchar(50);
begin
	select nome into r from cliente where idcliente = idc;
	return r;
end;
$$;
 2   DROP FUNCTION public.get_nome_by_id(idc integer);
       public          postgres    false            �            1255    16832    get_pedido_maximo()    FUNCTION     �   CREATE FUNCTION public.get_pedido_maximo() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (SELECT IDPEDIDO FROM PEDIDO WHERE VALOR = (SELECT (MAX(VALOR)) FROM PEDIDO));
END;
$$;
 *   DROP FUNCTION public.get_pedido_maximo();
       public          postgres    false            �            1255    16827    get_valor_total(integer)    FUNCTION     �  CREATE FUNCTION public.get_valor_total(idp integer) RETURNS numeric
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
 3   DROP FUNCTION public.get_valor_total(idp integer);
       public          postgres    false                        1255    16833     insere_bairro(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.insere_bairro(IN nome_bairro character varying)
    LANGUAGE sql
    AS $$
	insert into bairro (nome) values (nome_bairro);
$$;
 G   DROP PROCEDURE public.insere_bairro(IN nome_bairro character varying);
       public          postgres    false                       1255    16845    pedidos_log()    FUNCTION     s  CREATE FUNCTION public.pedidos_log() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
	--old 4 --> new 6
		insert into pedidos_apagados (idpedido ,idcliente, idtransportadora, idvendedor, data_pedido, valor, data_apagada) values (old.idpedido ,old.idcliente,old.idtransportadora,old.idvendedor, old.data_pedido, old.valor, current_timestamp);
	return old;
	end;
$$;
 $   DROP FUNCTION public.pedidos_log();
       public          postgres    false                       1255    16834 +   reajuste_produto(integer, double precision) 	   PROCEDURE     �   CREATE PROCEDURE public.reajuste_produto(IN idp integer, IN percentual double precision)
    LANGUAGE sql
    AS $$
	update produto set valor = valor + ((valor * percentual) / 100) where idproduto = idp;
$$;
 X   DROP PROCEDURE public.reajuste_produto(IN idp integer, IN percentual double precision);
       public          postgres    false            �            1259    16452    bairro    TABLE     c   CREATE TABLE public.bairro (
    idbairro integer NOT NULL,
    nome public.nome_medio NOT NULL
);
    DROP TABLE public.bairro;
       public         heap    postgres    false    975            	           0    0    TABLE bairro    ACL     W   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bairro TO gerente WITH GRANT OPTION;
          public          postgres    false    219            �            1259    16837    bairro_auditoria    TABLE     t   CREATE TABLE public.bairro_auditoria (
    idbairro integer NOT NULL,
    data_criacao public.data_hora NOT NULL
);
 $   DROP TABLE public.bairro_auditoria;
       public         heap    postgres    false    960            
           0    0    TABLE bairro_auditoria    ACL     a   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bairro_auditoria TO gerente WITH GRANT OPTION;
          public          postgres    false    242            �            1259    16621    bairro_id_seq    SEQUENCE     u   CREATE SEQUENCE public.bairro_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.bairro_id_seq;
       public          postgres    false    219                       0    0    bairro_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.bairro_id_seq OWNED BY public.bairro.idbairro;
          public          postgres    false    230                       0    0    SEQUENCE bairro_id_seq    ACL     7   GRANT ALL ON SEQUENCE public.bairro_id_seq TO gerente;
          public          postgres    false    230            �            1259    16421    cliente    TABLE     �  CREATE TABLE public.cliente (
    idcliente integer NOT NULL,
    nome public.nome_longo NOT NULL,
    cpf public.documento,
    rg public.documento,
    data_nascimento date,
    genero public.tipo,
    logradouro public.nome_longo,
    numero public.nome_curto,
    observacoes public.nome_longo,
    idprofissao public.idmedio,
    idnacionalidade public.idmedio,
    idcomplemento public.idmedio,
    idbairro public.idmedio,
    idmunicipio public.idmedio
);
    DROP TABLE public.cliente;
       public         heap    postgres    false    981    936    936    951    948    936    951    951    936    936    978    978                       0    0    TABLE cliente    ACL     X   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cliente TO gerente WITH GRANT OPTION;
          public          postgres    false    215            �            1259    16623    cliente_id_seq    SEQUENCE     x   CREATE SEQUENCE public.cliente_id_seq
    START WITH 18
    INCREMENT BY 1
    MINVALUE 18
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.cliente_id_seq;
       public          postgres    false    215                       0    0    cliente_id_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.idcliente;
          public          postgres    false    231                       0    0    SEQUENCE cliente_id_seq    ACL     8   GRANT ALL ON SEQUENCE public.cliente_id_seq TO gerente;
          public          postgres    false    231            �            1259    16445    complemento    TABLE     m   CREATE TABLE public.complemento (
    idcomplemento integer NOT NULL,
    nome public.nome_medio NOT NULL
);
    DROP TABLE public.complemento;
       public         heap    postgres    false    975                       0    0    TABLE complemento    ACL     \   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.complemento TO gerente WITH GRANT OPTION;
          public          postgres    false    218            �            1259    16625    complemento_id_seq    SEQUENCE     z   CREATE SEQUENCE public.complemento_id_seq
    START WITH 3
    INCREMENT BY 1
    MINVALUE 3
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.complemento_id_seq;
       public          postgres    false    218                       0    0    complemento_id_seq    SEQUENCE OWNED BY     T   ALTER SEQUENCE public.complemento_id_seq OWNED BY public.complemento.idcomplemento;
          public          postgres    false    232                       0    0    SEQUENCE complemento_id_seq    ACL     <   GRANT ALL ON SEQUENCE public.complemento_id_seq TO gerente;
          public          postgres    false    232            �            1259    17187    conta    TABLE     �   CREATE TABLE public.conta (
    idconta integer NOT NULL,
    cliente public.nome_medio NOT NULL,
    saldo public.moeda DEFAULT 0 NOT NULL
);
    DROP TABLE public.conta;
       public         heap    postgres    false    963    963    975            �            1259    17186    conta_idconta_seq    SEQUENCE     �   CREATE SEQUENCE public.conta_idconta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.conta_idconta_seq;
       public          postgres    false    251                       0    0    conta_idconta_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.conta_idconta_seq OWNED BY public.conta.idconta;
          public          postgres    false    250            �            1259    16541    pedido    TABLE       CREATE TABLE public.pedido (
    idpedido public.idlongo NOT NULL,
    idcliente public.idmedio NOT NULL,
    idtransportadora public.idmedio,
    idvendedor public.idmedio NOT NULL,
    data_pedido public.data DEFAULT CURRENT_DATE NOT NULL,
    valor public.moeda DEFAULT 0 NOT NULL
);
    DROP TABLE public.pedido;
       public         heap    postgres    false    954    963    936    954    963    939    936    936                       0    0    TABLE pedido    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pedido TO gerente WITH GRANT OPTION;
GRANT SELECT,INSERT ON TABLE public.pedido TO atendente WITH GRANT OPTION;
          public          postgres    false    226            �            1259    16519    transportadora    TABLE     �   CREATE TABLE public.transportadora (
    idtransportadora integer NOT NULL,
    idmunicipio public.idmedio NOT NULL,
    nome public.nome_medio NOT NULL,
    logradouro public.nome_longo NOT NULL,
    numero public.nome_curto NOT NULL
);
 "   DROP TABLE public.transportadora;
       public         heap    postgres    false    936    948    951    975                       0    0    TABLE transportadora    ACL     _   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.transportadora TO gerente WITH GRANT OPTION;
          public          postgres    false    224            �            1259    16512    vendedor    TABLE     g   CREATE TABLE public.vendedor (
    idvendedor integer NOT NULL,
    nome public.nome_medio NOT NULL
);
    DROP TABLE public.vendedor;
       public         heap    postgres    false    975                       0    0    TABLE vendedor    ACL     Y   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.vendedor TO gerente WITH GRANT OPTION;
          public          postgres    false    223            �            1259    17168    dado_dos_vendedor    VIEW     �  CREATE VIEW public.dado_dos_vendedor AS
 SELECT pdd.data_pedido,
    pdd.valor,
    trp.nome AS transportadora,
    cln.nome AS cliente,
    vdd.nome AS vendedor
   FROM (((public.pedido pdd
     LEFT JOIN public.transportadora trp ON (((pdd.idtransportadora)::integer = trp.idtransportadora)))
     LEFT JOIN public.cliente cln ON (((pdd.idcliente)::integer = cln.idcliente)))
     LEFT JOIN public.vendedor vdd ON (((pdd.idvendedor)::integer = vdd.idvendedor)));
 $   DROP VIEW public.dado_dos_vendedor;
       public          postgres    false    223    215    226    226    226    226    226    224    224    223    215    951    954    975    975    963            �            1259    16505 
   fornecedor    TABLE     k   CREATE TABLE public.fornecedor (
    idfornecedor integer NOT NULL,
    nome public.nome_medio NOT NULL
);
    DROP TABLE public.fornecedor;
       public         heap    postgres    false    975                       0    0    TABLE fornecedor    ACL     [   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.fornecedor TO gerente WITH GRANT OPTION;
          public          postgres    false    222            �            1259    16531    produto    TABLE     �   CREATE TABLE public.produto (
    idproduto public.idmedio NOT NULL,
    idfornecedor integer NOT NULL,
    nome public.nome_medio NOT NULL,
    valor public.moeda DEFAULT 0 NOT NULL
);
    DROP TABLE public.produto;
       public         heap    postgres    false    963    963    975    936                       0    0    TABLE produto    ACL     X   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.produto TO gerente WITH GRANT OPTION;
          public          postgres    false    225            �            1259    17160    dado_produto    VIEW     �   CREATE VIEW public.dado_produto AS
 SELECT pdt.nome AS produto,
    pdt.valor,
    fnc.nome AS fornecedor
   FROM (public.produto pdt
     LEFT JOIN public.fornecedor fnc ON ((pdt.idfornecedor = fnc.idfornecedor)));
    DROP VIEW public.dado_produto;
       public          postgres    false    225    225    222    222    225    975    963    975            �            1259    16488 	   municipio    TABLE     �   CREATE TABLE public.municipio (
    idmunicipio integer NOT NULL,
    nome public.nome_medio NOT NULL,
    iduf public.idmedio NOT NULL
);
    DROP TABLE public.municipio;
       public         heap    postgres    false    936    975                       0    0    TABLE municipio    ACL     Z   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.municipio TO gerente WITH GRANT OPTION;
          public          postgres    false    221            �            1259    16479    uf    TABLE     |   CREATE TABLE public.uf (
    iduf integer NOT NULL,
    nome public.nome_medio NOT NULL,
    sigla public.sigla NOT NULL
);
    DROP TABLE public.uf;
       public         heap    postgres    false    942    975                       0    0    TABLE uf    ACL     S   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.uf TO gerente WITH GRANT OPTION;
          public          postgres    false    220            �            1259    17164    dado_transportadora    VIEW     \  CREATE VIEW public.dado_transportadora AS
 SELECT trp.nome AS transportadora,
    trp.logradouro,
    trp.numero AS "número",
    uf.nome AS uf,
    uf.sigla
   FROM ((public.transportadora trp
     LEFT JOIN public.municipio mnc ON (((trp.idmunicipio)::integer = mnc.idmunicipio)))
     LEFT JOIN public.uf ON (((mnc.iduf)::integer = uf.iduf)));
 &   DROP VIEW public.dado_transportadora;
       public          postgres    false    220    220    224    224    221    221    224    224    220    951    975    948    975    942            �            1259    16435    nacionalidade    TABLE     q   CREATE TABLE public.nacionalidade (
    idnacionalidade integer NOT NULL,
    nome public.nome_medio NOT NULL
);
 !   DROP TABLE public.nacionalidade;
       public         heap    postgres    false    975                       0    0    TABLE nacionalidade    ACL     ^   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.nacionalidade TO gerente WITH GRANT OPTION;
          public          postgres    false    217            �            1259    16428 	   profissao    TABLE     i   CREATE TABLE public.profissao (
    idprofissao integer NOT NULL,
    nome public.nome_medio NOT NULL
);
    DROP TABLE public.profissao;
       public         heap    postgres    false    975                       0    0    TABLE profissao    ACL     Z   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.profissao TO gerente WITH GRANT OPTION;
          public          postgres    false    216            �            1259    17151    dados_dos_clientes    VIEW     Z  CREATE VIEW public.dados_dos_clientes AS
 SELECT cln.nome AS cliente,
    prf.nome AS "profissão",
    ncm.nome AS nacionalidade,
    cpl.nome AS complemento,
    mnc.nome AS municipio,
    uf.nome AS uf,
    brr.nome AS bairro,
    cln.cpf,
    cln.rg,
    cln.data_nascimento,
        CASE
            WHEN ((cln.genero)::bpchar = 'M'::bpchar) THEN 'Masculino'::text
            WHEN ((cln.genero)::bpchar = 'F'::bpchar) THEN 'Feminino'::text
            ELSE 'Desconhecido'::text
        END AS genero,
    cln.logradouro,
    cln.numero,
    cln.observacoes
   FROM ((((((public.cliente cln
     LEFT JOIN public.profissao prf ON (((cln.idprofissao)::integer = prf.idprofissao)))
     LEFT JOIN public.nacionalidade ncm ON (((cln.idnacionalidade)::integer = ncm.idnacionalidade)))
     LEFT JOIN public.complemento cpl ON (((cln.idcomplemento)::integer = cpl.idcomplemento)))
     LEFT JOIN public.municipio mnc ON (((cln.idmunicipio)::integer = mnc.idmunicipio)))
     LEFT JOIN public.uf ON (((mnc.iduf)::integer = uf.iduf)))
     LEFT JOIN public.bairro brr ON (((cln.idbairro)::integer = brr.idbairro)));
 %   DROP VIEW public.dados_dos_clientes;
       public          postgres    false    220    221    221    221    220    219    219    218    218    217    217    216    216    215    215    215    215    215    215    215    215    215    215    215    215    215    978    975    978    951    975    975    975    948    951    975    975    951                       0    0    TABLE dados_dos_clientes    ACL     Q   GRANT SELECT ON TABLE public.dados_dos_clientes TO estagiario WITH GRANT OPTION;
          public          postgres    false    244            �            1259    17156    dados_municipio    VIEW     �   CREATE VIEW public.dados_municipio AS
 SELECT mnc.nome AS municipio,
    uf.nome AS uf,
    uf.sigla
   FROM (public.municipio mnc
     LEFT JOIN public.uf ON (((mnc.iduf)::integer = uf.iduf)));
 "   DROP VIEW public.dados_municipio;
       public          postgres    false    221    220    220    220    221    942    975    975            �            1259    16615    exemplo    TABLE     e   CREATE TABLE public.exemplo (
    idexemplo integer NOT NULL,
    nome public.nome_medio NOT NULL
);
    DROP TABLE public.exemplo;
       public         heap    postgres    false    975                       0    0    TABLE exemplo    ACL     X   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.exemplo TO gerente WITH GRANT OPTION;
          public          postgres    false    229            �            1259    16614    exemplo_idexemplo_seq    SEQUENCE     �   CREATE SEQUENCE public.exemplo_idexemplo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.exemplo_idexemplo_seq;
       public          postgres    false    229                       0    0    exemplo_idexemplo_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.exemplo_idexemplo_seq OWNED BY public.exemplo.idexemplo;
          public          postgres    false    228                        0    0    SEQUENCE exemplo_idexemplo_seq    ACL     ?   GRANT ALL ON SEQUENCE public.exemplo_idexemplo_seq TO gerente;
          public          postgres    false    228            �            1259    16627    fornecedor_id_seq    SEQUENCE     y   CREATE SEQUENCE public.fornecedor_id_seq
    START WITH 4
    INCREMENT BY 1
    MINVALUE 4
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.fornecedor_id_seq;
       public          postgres    false    222            !           0    0    fornecedor_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.fornecedor_id_seq OWNED BY public.fornecedor.idfornecedor;
          public          postgres    false    233            "           0    0    SEQUENCE fornecedor_id_seq    ACL     ;   GRANT ALL ON SEQUENCE public.fornecedor_id_seq TO gerente;
          public          postgres    false    233            �            1259    16629    municipio_id_seq    SEQUENCE     z   CREATE SEQUENCE public.municipio_id_seq
    START WITH 10
    INCREMENT BY 1
    MINVALUE 10
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.municipio_id_seq;
       public          postgres    false    221            #           0    0    municipio_id_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public.municipio_id_seq OWNED BY public.municipio.idmunicipio;
          public          postgres    false    234            $           0    0    SEQUENCE municipio_id_seq    ACL     :   GRANT ALL ON SEQUENCE public.municipio_id_seq TO gerente;
          public          postgres    false    234            �            1259    16631    nacionalidade_id_seq    SEQUENCE     |   CREATE SEQUENCE public.nacionalidade_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.nacionalidade_id_seq;
       public          postgres    false    217            %           0    0    nacionalidade_id_seq    SEQUENCE OWNED BY     Z   ALTER SEQUENCE public.nacionalidade_id_seq OWNED BY public.nacionalidade.idnacionalidade;
          public          postgres    false    235            &           0    0    SEQUENCE nacionalidade_id_seq    ACL     >   GRANT ALL ON SEQUENCE public.nacionalidade_id_seq TO gerente;
          public          postgres    false    235            �            1259    16633    pedido_id_seq    SEQUENCE     w   CREATE SEQUENCE public.pedido_id_seq
    START WITH 16
    INCREMENT BY 1
    MINVALUE 16
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.pedido_id_seq;
       public          postgres    false    226            '           0    0    pedido_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.pedido_id_seq OWNED BY public.pedido.idpedido;
          public          postgres    false    236            (           0    0    SEQUENCE pedido_id_seq    ACL     �   GRANT ALL ON SEQUENCE public.pedido_id_seq TO gerente;
GRANT ALL ON SEQUENCE public.pedido_id_seq TO atendente WITH GRANT OPTION;
          public          postgres    false    236            �            1259    16565    pedido_produto    TABLE     �   CREATE TABLE public.pedido_produto (
    idpedido public.idlongo NOT NULL,
    idproduto public.idmedio NOT NULL,
    quantidade public.quantidade DEFAULT 1 NOT NULL,
    valor_unitario public.moeda DEFAULT 0 NOT NULL
);
 "   DROP TABLE public.pedido_produto;
       public         heap    postgres    false    987    963    987    963    939    936            )           0    0    TABLE pedido_produto    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pedido_produto TO gerente WITH GRANT OPTION;
GRANT SELECT,INSERT ON TABLE public.pedido_produto TO atendente WITH GRANT OPTION;
          public          postgres    false    227            �            1259    16847    pedidos_apagados    TABLE     ?  CREATE TABLE public.pedidos_apagados (
    idpedido public.idlongo NOT NULL,
    idcliente public.idmedio NOT NULL,
    idtransportadora public.idmedio NOT NULL,
    idvendedor public.idmedio NOT NULL,
    data_pedido public.data NOT NULL,
    valor public.moeda NOT NULL,
    data_apagada public.data_hora NOT NULL
);
 $   DROP TABLE public.pedidos_apagados;
       public         heap    postgres    false    936    939    954    960    936    936    963            *           0    0    TABLE pedidos_apagados    ACL     a   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pedidos_apagados TO gerente WITH GRANT OPTION;
          public          postgres    false    243            �            1259    16649    produto_id_seq    SEQUENCE     v   CREATE SEQUENCE public.produto_id_seq
    START WITH 9
    INCREMENT BY 1
    MINVALUE 9
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.produto_id_seq;
       public          postgres    false    225            +           0    0    produto_id_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.produto_id_seq OWNED BY public.produto.idproduto;
          public          postgres    false    241            ,           0    0    SEQUENCE produto_id_seq    ACL     8   GRANT ALL ON SEQUENCE public.produto_id_seq TO gerente;
          public          postgres    false    241            �            1259    17173    produto_pedido    VIEW     =  CREATE VIEW public.produto_pedido AS
 SELECT pdt.nome AS produto,
    sum((ppt.valor_unitario)::numeric) AS valor_unitario,
    sum((ppt.quantidade)::smallint) AS qtd
   FROM (public.produto pdt
     LEFT JOIN public.pedido_produto ppt ON (((pdt.idproduto)::integer = (ppt.idproduto)::integer)))
  GROUP BY pdt.nome;
 !   DROP VIEW public.produto_pedido;
       public          postgres    false    227    227    227    225    225    975            -           0    0    TABLE produto_pedido    ACL     M   GRANT SELECT ON TABLE public.produto_pedido TO estagiario WITH GRANT OPTION;
          public          postgres    false    249            �            1259    16635    profissao_id_seq    SEQUENCE     x   CREATE SEQUENCE public.profissao_id_seq
    START WITH 6
    INCREMENT BY 1
    MINVALUE 6
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.profissao_id_seq;
       public          postgres    false    216            .           0    0    profissao_id_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public.profissao_id_seq OWNED BY public.profissao.idprofissao;
          public          postgres    false    237            /           0    0    SEQUENCE profissao_id_seq    ACL     :   GRANT ALL ON SEQUENCE public.profissao_id_seq TO gerente;
          public          postgres    false    237            �            1259    16637    transportadora_id_seq    SEQUENCE     }   CREATE SEQUENCE public.transportadora_id_seq
    START WITH 3
    INCREMENT BY 1
    MINVALUE 3
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.transportadora_id_seq;
       public          postgres    false    224            0           0    0    transportadora_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.transportadora_id_seq OWNED BY public.transportadora.idtransportadora;
          public          postgres    false    238            1           0    0    SEQUENCE transportadora_id_seq    ACL     ?   GRANT ALL ON SEQUENCE public.transportadora_id_seq TO gerente;
          public          postgres    false    238            �            1259    16640 	   uf_id_seq    SEQUENCE     q   CREATE SEQUENCE public.uf_id_seq
    START WITH 7
    INCREMENT BY 1
    MINVALUE 7
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.uf_id_seq;
       public          postgres    false    220            2           0    0 	   uf_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE public.uf_id_seq OWNED BY public.uf.iduf;
          public          postgres    false    239            3           0    0    SEQUENCE uf_id_seq    ACL     3   GRANT ALL ON SEQUENCE public.uf_id_seq TO gerente;
          public          postgres    false    239            �            1259    16642    vendedor_id_seq    SEQUENCE     w   CREATE SEQUENCE public.vendedor_id_seq
    START WITH 9
    INCREMENT BY 1
    MINVALUE 9
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.vendedor_id_seq;
       public          postgres    false    223            4           0    0    vendedor_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.vendedor_id_seq OWNED BY public.vendedor.idvendedor;
          public          postgres    false    240            5           0    0    SEQUENCE vendedor_id_seq    ACL     9   GRANT ALL ON SEQUENCE public.vendedor_id_seq TO gerente;
          public          postgres    false    240            �           2604    16622    bairro idbairro    DEFAULT     l   ALTER TABLE ONLY public.bairro ALTER COLUMN idbairro SET DEFAULT nextval('public.bairro_id_seq'::regclass);
 >   ALTER TABLE public.bairro ALTER COLUMN idbairro DROP DEFAULT;
       public          postgres    false    230    219            �           2604    16624    cliente idcliente    DEFAULT     o   ALTER TABLE ONLY public.cliente ALTER COLUMN idcliente SET DEFAULT nextval('public.cliente_id_seq'::regclass);
 @   ALTER TABLE public.cliente ALTER COLUMN idcliente DROP DEFAULT;
       public          postgres    false    231    215            �           2604    16626    complemento idcomplemento    DEFAULT     {   ALTER TABLE ONLY public.complemento ALTER COLUMN idcomplemento SET DEFAULT nextval('public.complemento_id_seq'::regclass);
 H   ALTER TABLE public.complemento ALTER COLUMN idcomplemento DROP DEFAULT;
       public          postgres    false    232    218            	           2604    17190    conta idconta    DEFAULT     n   ALTER TABLE ONLY public.conta ALTER COLUMN idconta SET DEFAULT nextval('public.conta_idconta_seq'::regclass);
 <   ALTER TABLE public.conta ALTER COLUMN idconta DROP DEFAULT;
       public          postgres    false    251    250    251                       2604    16618    exemplo idexemplo    DEFAULT     v   ALTER TABLE ONLY public.exemplo ALTER COLUMN idexemplo SET DEFAULT nextval('public.exemplo_idexemplo_seq'::regclass);
 @   ALTER TABLE public.exemplo ALTER COLUMN idexemplo DROP DEFAULT;
       public          postgres    false    229    228    229            �           2604    16628    fornecedor idfornecedor    DEFAULT     x   ALTER TABLE ONLY public.fornecedor ALTER COLUMN idfornecedor SET DEFAULT nextval('public.fornecedor_id_seq'::regclass);
 F   ALTER TABLE public.fornecedor ALTER COLUMN idfornecedor DROP DEFAULT;
       public          postgres    false    233    222            �           2604    16630    municipio idmunicipio    DEFAULT     u   ALTER TABLE ONLY public.municipio ALTER COLUMN idmunicipio SET DEFAULT nextval('public.municipio_id_seq'::regclass);
 D   ALTER TABLE public.municipio ALTER COLUMN idmunicipio DROP DEFAULT;
       public          postgres    false    234    221            �           2604    16632    nacionalidade idnacionalidade    DEFAULT     �   ALTER TABLE ONLY public.nacionalidade ALTER COLUMN idnacionalidade SET DEFAULT nextval('public.nacionalidade_id_seq'::regclass);
 L   ALTER TABLE public.nacionalidade ALTER COLUMN idnacionalidade DROP DEFAULT;
       public          postgres    false    235    217                       2604    17039    pedido idpedido    DEFAULT     l   ALTER TABLE ONLY public.pedido ALTER COLUMN idpedido SET DEFAULT nextval('public.pedido_id_seq'::regclass);
 >   ALTER TABLE public.pedido ALTER COLUMN idpedido DROP DEFAULT;
       public          postgres    false    236    939    226                       2604    17108    produto idproduto    DEFAULT     o   ALTER TABLE ONLY public.produto ALTER COLUMN idproduto SET DEFAULT nextval('public.produto_id_seq'::regclass);
 @   ALTER TABLE public.produto ALTER COLUMN idproduto DROP DEFAULT;
       public          postgres    false    936    241    225            �           2604    16636    profissao idprofissao    DEFAULT     u   ALTER TABLE ONLY public.profissao ALTER COLUMN idprofissao SET DEFAULT nextval('public.profissao_id_seq'::regclass);
 D   ALTER TABLE public.profissao ALTER COLUMN idprofissao DROP DEFAULT;
       public          postgres    false    237    216                        2604    16638    transportadora idtransportadora    DEFAULT     �   ALTER TABLE ONLY public.transportadora ALTER COLUMN idtransportadora SET DEFAULT nextval('public.transportadora_id_seq'::regclass);
 N   ALTER TABLE public.transportadora ALTER COLUMN idtransportadora DROP DEFAULT;
       public          postgres    false    238    224            �           2604    16641    uf iduf    DEFAULT     `   ALTER TABLE ONLY public.uf ALTER COLUMN iduf SET DEFAULT nextval('public.uf_id_seq'::regclass);
 6   ALTER TABLE public.uf ALTER COLUMN iduf DROP DEFAULT;
       public          postgres    false    239    220            �           2604    16643    vendedor idvendedor    DEFAULT     r   ALTER TABLE ONLY public.vendedor ALTER COLUMN idvendedor SET DEFAULT nextval('public.vendedor_id_seq'::regclass);
 B   ALTER TABLE public.vendedor ALTER COLUMN idvendedor DROP DEFAULT;
       public          postgres    false    240    223            �          0    16452    bairro 
   TABLE DATA           0   COPY public.bairro (idbairro, nome) FROM stdin;
    public          postgres    false    219   �       �          0    16837    bairro_auditoria 
   TABLE DATA           B   COPY public.bairro_auditoria (idbairro, data_criacao) FROM stdin;
    public          postgres    false    242   }�       �          0    16421    cliente 
   TABLE DATA           �   COPY public.cliente (idcliente, nome, cpf, rg, data_nascimento, genero, logradouro, numero, observacoes, idprofissao, idnacionalidade, idcomplemento, idbairro, idmunicipio) FROM stdin;
    public          postgres    false    215   ��       �          0    16445    complemento 
   TABLE DATA           :   COPY public.complemento (idcomplemento, nome) FROM stdin;
    public          postgres    false    218   !�                 0    17187    conta 
   TABLE DATA           8   COPY public.conta (idconta, cliente, saldo) FROM stdin;
    public          postgres    false    251   S�       �          0    16615    exemplo 
   TABLE DATA           2   COPY public.exemplo (idexemplo, nome) FROM stdin;
    public          postgres    false    229   ��       �          0    16505 
   fornecedor 
   TABLE DATA           8   COPY public.fornecedor (idfornecedor, nome) FROM stdin;
    public          postgres    false    222   ��       �          0    16488 	   municipio 
   TABLE DATA           <   COPY public.municipio (idmunicipio, nome, iduf) FROM stdin;
    public          postgres    false    221   �       �          0    16435    nacionalidade 
   TABLE DATA           >   COPY public.nacionalidade (idnacionalidade, nome) FROM stdin;
    public          postgres    false    217   ��       �          0    16541    pedido 
   TABLE DATA           g   COPY public.pedido (idpedido, idcliente, idtransportadora, idvendedor, data_pedido, valor) FROM stdin;
    public          postgres    false    226   ��       �          0    16565    pedido_produto 
   TABLE DATA           Y   COPY public.pedido_produto (idpedido, idproduto, quantidade, valor_unitario) FROM stdin;
    public          postgres    false    227   ��                  0    16847    pedidos_apagados 
   TABLE DATA              COPY public.pedidos_apagados (idpedido, idcliente, idtransportadora, idvendedor, data_pedido, valor, data_apagada) FROM stdin;
    public          postgres    false    243   L�       �          0    16531    produto 
   TABLE DATA           G   COPY public.produto (idproduto, idfornecedor, nome, valor) FROM stdin;
    public          postgres    false    225   ��       �          0    16428 	   profissao 
   TABLE DATA           6   COPY public.profissao (idprofissao, nome) FROM stdin;
    public          postgres    false    216   &�       �          0    16519    transportadora 
   TABLE DATA           a   COPY public.transportadora (idtransportadora, idmunicipio, nome, logradouro, numero) FROM stdin;
    public          postgres    false    224   }�       �          0    16479    uf 
   TABLE DATA           /   COPY public.uf (iduf, nome, sigla) FROM stdin;
    public          postgres    false    220   ��       �          0    16512    vendedor 
   TABLE DATA           4   COPY public.vendedor (idvendedor, nome) FROM stdin;
    public          postgres    false    223   L�       6           0    0    bairro_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.bairro_id_seq', 11, true);
          public          postgres    false    230            7           0    0    cliente_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.cliente_id_seq', 18, true);
          public          postgres    false    231            8           0    0    complemento_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.complemento_id_seq', 3, false);
          public          postgres    false    232            9           0    0    conta_idconta_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.conta_idconta_seq', 2, true);
          public          postgres    false    250            :           0    0    exemplo_idexemplo_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.exemplo_idexemplo_seq', 5, true);
          public          postgres    false    228            ;           0    0    fornecedor_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.fornecedor_id_seq', 4, false);
          public          postgres    false    233            <           0    0    municipio_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.municipio_id_seq', 10, false);
          public          postgres    false    234            =           0    0    nacionalidade_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.nacionalidade_id_seq', 5, false);
          public          postgres    false    235            >           0    0    pedido_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.pedido_id_seq', 17, true);
          public          postgres    false    236            ?           0    0    produto_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.produto_id_seq', 9, false);
          public          postgres    false    241            @           0    0    profissao_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.profissao_id_seq', 6, false);
          public          postgres    false    237            A           0    0    transportadora_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.transportadora_id_seq', 3, false);
          public          postgres    false    238            B           0    0 	   uf_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.uf_id_seq', 7, false);
          public          postgres    false    239            C           0    0    vendedor_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.vendedor_id_seq', 9, false);
          public          postgres    false    240                       2606    16456    bairro pk_brr_idbairro 
   CONSTRAINT     Z   ALTER TABLE ONLY public.bairro
    ADD CONSTRAINT pk_brr_idbairro PRIMARY KEY (idbairro);
 @   ALTER TABLE ONLY public.bairro DROP CONSTRAINT pk_brr_idbairro;
       public            postgres    false    219                       2606    16881    bairro pk_brr_nome 
   CONSTRAINT     M   ALTER TABLE ONLY public.bairro
    ADD CONSTRAINT pk_brr_nome UNIQUE (nome);
 <   ALTER TABLE ONLY public.bairro DROP CONSTRAINT pk_brr_nome;
       public            postgres    false    219                       2606    16427    cliente pk_cln_idcliente 
   CONSTRAINT     ]   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT pk_cln_idcliente PRIMARY KEY (idcliente);
 B   ALTER TABLE ONLY public.cliente DROP CONSTRAINT pk_cln_idcliente;
       public            postgres    false    215            ?           2606    17195    conta pk_cnt_idconta 
   CONSTRAINT     W   ALTER TABLE ONLY public.conta
    ADD CONSTRAINT pk_cnt_idconta PRIMARY KEY (idconta);
 >   ALTER TABLE ONLY public.conta DROP CONSTRAINT pk_cnt_idconta;
       public            postgres    false    251                       2606    16449     complemento pk_cpl_idcomplemento 
   CONSTRAINT     i   ALTER TABLE ONLY public.complemento
    ADD CONSTRAINT pk_cpl_idcomplemento PRIMARY KEY (idcomplemento);
 J   ALTER TABLE ONLY public.complemento DROP CONSTRAINT pk_cpl_idcomplemento;
       public            postgres    false    218            =           2606    16620    exemplo pk_exemplo_idexemplo 
   CONSTRAINT     a   ALTER TABLE ONLY public.exemplo
    ADD CONSTRAINT pk_exemplo_idexemplo PRIMARY KEY (idexemplo);
 F   ALTER TABLE ONLY public.exemplo DROP CONSTRAINT pk_exemplo_idexemplo;
       public            postgres    false    229            )           2606    16509    fornecedor pk_fnd_idfornecedor 
   CONSTRAINT     f   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT pk_fnd_idfornecedor PRIMARY KEY (idfornecedor);
 H   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT pk_fnd_idfornecedor;
       public            postgres    false    222            %           2606    16492    municipio pk_mnc_idmunicipio 
   CONSTRAINT     c   ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT pk_mnc_idmunicipio PRIMARY KEY (idmunicipio);
 F   ALTER TABLE ONLY public.municipio DROP CONSTRAINT pk_mnc_idmunicipio;
       public            postgres    false    221                       2606    16439 $   nacionalidade pk_ncn_idnacionalidade 
   CONSTRAINT     o   ALTER TABLE ONLY public.nacionalidade
    ADD CONSTRAINT pk_ncn_idnacionalidade PRIMARY KEY (idnacionalidade);
 N   ALTER TABLE ONLY public.nacionalidade DROP CONSTRAINT pk_ncn_idnacionalidade;
       public            postgres    false    217            9           2606    17041    pedido pk_pdd_idpedido 
   CONSTRAINT     Z   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pk_pdd_idpedido PRIMARY KEY (idpedido);
 @   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pk_pdd_idpedido;
       public            postgres    false    226            ;           2606    17077 %   pedido_produto pk_pdp_idpedidoproduto 
   CONSTRAINT     t   ALTER TABLE ONLY public.pedido_produto
    ADD CONSTRAINT pk_pdp_idpedidoproduto PRIMARY KEY (idpedido, idproduto);
 O   ALTER TABLE ONLY public.pedido_produto DROP CONSTRAINT pk_pdp_idpedidoproduto;
       public            postgres    false    227    227            6           2606    17110    produto pk_pdt_idproduto 
   CONSTRAINT     ]   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT pk_pdt_idproduto PRIMARY KEY (idproduto);
 B   ALTER TABLE ONLY public.produto DROP CONSTRAINT pk_pdt_idproduto;
       public            postgres    false    225                       2606    16432    profissao pk_prf_idprofissao 
   CONSTRAINT     c   ALTER TABLE ONLY public.profissao
    ADD CONSTRAINT pk_prf_idprofissao PRIMARY KEY (idprofissao);
 F   ALTER TABLE ONLY public.profissao DROP CONSTRAINT pk_prf_idprofissao;
       public            postgres    false    216            1           2606    16523 &   transportadora pk_tpd_idtransportadora 
   CONSTRAINT     r   ALTER TABLE ONLY public.transportadora
    ADD CONSTRAINT pk_tpd_idtransportadora PRIMARY KEY (idtransportadora);
 P   ALTER TABLE ONLY public.transportadora DROP CONSTRAINT pk_tpd_idtransportadora;
       public            postgres    false    224                       2606    16483    uf pk_ufd_idunidade_federacao 
   CONSTRAINT     ]   ALTER TABLE ONLY public.uf
    ADD CONSTRAINT pk_ufd_idunidade_federacao PRIMARY KEY (iduf);
 G   ALTER TABLE ONLY public.uf DROP CONSTRAINT pk_ufd_idunidade_federacao;
       public            postgres    false    220            -           2606    16516    vendedor pk_vnd_idvendedor 
   CONSTRAINT     `   ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT pk_vnd_idvendedor PRIMARY KEY (idvendedor);
 D   ALTER TABLE ONLY public.vendedor DROP CONSTRAINT pk_vnd_idvendedor;
       public            postgres    false    223                       2606    16953    complemento un_cpl_nome 
   CONSTRAINT     R   ALTER TABLE ONLY public.complemento
    ADD CONSTRAINT un_cpl_nome UNIQUE (nome);
 A   ALTER TABLE ONLY public.complemento DROP CONSTRAINT un_cpl_nome;
       public            postgres    false    218            +           2606    16964    fornecedor un_fnd_nome 
   CONSTRAINT     Q   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT un_fnd_nome UNIQUE (nome);
 @   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT un_fnd_nome;
       public            postgres    false    222            '           2606    16977    municipio un_mnc_nome 
   CONSTRAINT     P   ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT un_mnc_nome UNIQUE (nome);
 ?   ALTER TABLE ONLY public.municipio DROP CONSTRAINT un_mnc_nome;
       public            postgres    false    221                       2606    16990    nacionalidade un_ncn_nome 
   CONSTRAINT     T   ALTER TABLE ONLY public.nacionalidade
    ADD CONSTRAINT un_ncn_nome UNIQUE (nome);
 C   ALTER TABLE ONLY public.nacionalidade DROP CONSTRAINT un_ncn_nome;
       public            postgres    false    217                       2606    17121    profissao un_prf_nome 
   CONSTRAINT     P   ALTER TABLE ONLY public.profissao
    ADD CONSTRAINT un_prf_nome UNIQUE (nome);
 ?   ALTER TABLE ONLY public.profissao DROP CONSTRAINT un_prf_nome;
       public            postgres    false    216            3           2606    17130    transportadora un_tpd_nome 
   CONSTRAINT     U   ALTER TABLE ONLY public.transportadora
    ADD CONSTRAINT un_tpd_nome UNIQUE (nome);
 D   ALTER TABLE ONLY public.transportadora DROP CONSTRAINT un_tpd_nome;
       public            postgres    false    224            !           2606    17134    uf un_ufd_nome 
   CONSTRAINT     I   ALTER TABLE ONLY public.uf
    ADD CONSTRAINT un_ufd_nome UNIQUE (nome);
 8   ALTER TABLE ONLY public.uf DROP CONSTRAINT un_ufd_nome;
       public            postgres    false    220            #           2606    17138    uf un_ufd_sigla 
   CONSTRAINT     K   ALTER TABLE ONLY public.uf
    ADD CONSTRAINT un_ufd_sigla UNIQUE (sigla);
 9   ALTER TABLE ONLY public.uf DROP CONSTRAINT un_ufd_sigla;
       public            postgres    false    220            /           2606    17148    vendedor un_vnd_nome 
   CONSTRAINT     O   ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT un_vnd_nome UNIQUE (nome);
 >   ALTER TABLE ONLY public.vendedor DROP CONSTRAINT un_vnd_nome;
       public            postgres    false    223                       1259    16905    idx_cln_nome    INDEX     @   CREATE INDEX idx_cln_nome ON public.cliente USING btree (nome);
     DROP INDEX public.idx_cln_nome;
       public            postgres    false    215            7           1259    17030    idx_pdd_data_pedido    INDEX     M   CREATE INDEX idx_pdd_data_pedido ON public.pedido USING btree (data_pedido);
 '   DROP INDEX public.idx_pdd_data_pedido;
       public            postgres    false    226            4           1259    17116    idx_pdt_nome    INDEX     @   CREATE INDEX idx_pdt_nome ON public.produto USING btree (nome);
     DROP INDEX public.idx_pdt_nome;
       public            postgres    false    225            M           2620    16841    bairro log_bairro_trigger    TRIGGER     s   CREATE TRIGGER log_bairro_trigger AFTER INSERT ON public.bairro FOR EACH ROW EXECUTE FUNCTION public.bairro_log();
 2   DROP TRIGGER log_bairro_trigger ON public.bairro;
       public          postgres    false    259    219            N           2620    16846    pedido log_pedido_trigger    TRIGGER     u   CREATE TRIGGER log_pedido_trigger BEFORE DELETE ON public.pedido FOR EACH ROW EXECUTE FUNCTION public.pedidos_log();
 2   DROP TRIGGER log_pedido_trigger ON public.pedido;
       public          postgres    false    226    260            @           2606    16930    cliente fk_cln_idbairro    FK CONSTRAINT     ~   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cln_idbairro FOREIGN KEY (idbairro) REFERENCES public.bairro(idbairro);
 A   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_cln_idbairro;
       public          postgres    false    4891    219    215            A           2606    16967    cliente fk_cln_idcomplemento    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cln_idcomplemento FOREIGN KEY (idcomplemento) REFERENCES public.complemento(idcomplemento);
 F   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_cln_idcomplemento;
       public          postgres    false    4887    218    215            B           2606    16925    cliente fk_cln_idnacionalidade    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cln_idnacionalidade FOREIGN KEY (idnacionalidade) REFERENCES public.nacionalidade(idnacionalidade);
 H   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_cln_idnacionalidade;
       public          postgres    false    4883    215    217            C           2606    16920    cliente fk_cln_idprofissao    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_cln_idprofissao FOREIGN KEY (idprofissao) REFERENCES public.profissao(idprofissao);
 D   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_cln_idprofissao;
       public          postgres    false    4879    215    216            D           2606    16935    cliente fk_clt_idmunicipio    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT fk_clt_idmunicipio FOREIGN KEY (idmunicipio) REFERENCES public.municipio(idmunicipio);
 D   ALTER TABLE ONLY public.cliente DROP CONSTRAINT fk_clt_idmunicipio;
       public          postgres    false    215    221    4901            E           2606    16980    municipio fk_mnc_iduf    FK CONSTRAINT     p   ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT fk_mnc_iduf FOREIGN KEY (iduf) REFERENCES public.uf(iduf);
 ?   ALTER TABLE ONLY public.municipio DROP CONSTRAINT fk_mnc_iduf;
       public          postgres    false    220    4895    221            H           2606    17014    pedido fk_pdd_idcliente    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pdd_idcliente FOREIGN KEY (idcliente) REFERENCES public.cliente(idcliente);
 A   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_pdd_idcliente;
       public          postgres    false    4877    215    226            I           2606    17019    pedido fk_pdd_idtransportadora    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pdd_idtransportadora FOREIGN KEY (idtransportadora) REFERENCES public.transportadora(idtransportadora);
 H   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_pdd_idtransportadora;
       public          postgres    false    4913    224    226            J           2606    17024    pedido fk_pdd_idvendedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pdd_idvendedor FOREIGN KEY (idvendedor) REFERENCES public.vendedor(idvendedor);
 B   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_pdd_idvendedor;
       public          postgres    false    4909    226    223            K           2606    17067    pedido_produto fk_pdp_idpedido    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido_produto
    ADD CONSTRAINT fk_pdp_idpedido FOREIGN KEY (idpedido) REFERENCES public.pedido(idpedido);
 H   ALTER TABLE ONLY public.pedido_produto DROP CONSTRAINT fk_pdp_idpedido;
       public          postgres    false    4921    227    226            L           2606    17111    pedido_produto fk_pdp_idproduto    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido_produto
    ADD CONSTRAINT fk_pdp_idproduto FOREIGN KEY (idproduto) REFERENCES public.produto(idproduto);
 I   ALTER TABLE ONLY public.pedido_produto DROP CONSTRAINT fk_pdp_idproduto;
       public          postgres    false    4918    225    227            G           2606    16536    produto fk_pdt_iffornecedor    FK CONSTRAINT     �   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT fk_pdt_iffornecedor FOREIGN KEY (idfornecedor) REFERENCES public.fornecedor(idfornecedor);
 E   ALTER TABLE ONLY public.produto DROP CONSTRAINT fk_pdt_iffornecedor;
       public          postgres    false    222    225    4905            F           2606    17124 !   transportadora fk_tpd_idmunicipio    FK CONSTRAINT     �   ALTER TABLE ONLY public.transportadora
    ADD CONSTRAINT fk_tpd_idmunicipio FOREIGN KEY (idmunicipio) REFERENCES public.municipio(idmunicipio);
 K   ALTER TABLE ONLY public.transportadora DROP CONSTRAINT fk_tpd_idmunicipio;
       public          postgres    false    221    4901    224            �   i   x�3�t�LILIU��/K�2�tN�+)��2�>�8_! 5�1�N�+IT�/N�2�I-.IU0�2����̡�����ԔҢT.K�*.C�: ��66������ �$F      �   1   x���4202�54�52W02�25�21�362�4��24�+k�O6F��� <5      �   S  x�m�Kn�0EǏ��T�+�C'mRI`�fBDj�@J� ��]B��X/%G��@�ѽ�=J�4)�>�6�qS9�$	a*)�	�\�])+����/�<^/>Ǵk�B�IjA	<�`��;ѯ�R
�yƩ��R�#���6���Cd�y�� A��o��d�;N�KnKY/���$��@UUфxGQN�DB*팫�D`���ǂ��K��|;�4�%�bx��K��8��8W���0���ؼ�=�MD����ÈX�۴��LH�jS��� E`�k����>�Č��0鷊�iڜ9_8���s�ń����uA�3�m��ޅ��l��HS�R�Qbqw�?�)D�����(Ҭ���/A鬼�,U
sh�]��<N���d�P��W�?���`��,+���ϘU]�ّ��f�&~�19��kn!H���@�!���D�9��b5����\��5�6X&��I�/Ø�����a�9zO>5�P���'[
��zW�-�>�a�<	��z��1���6�v"��'���4��C@(܀Յq�������ɪ*k!Ur�׺��?|�|�!��-���v<��º���8.��oP�]���|GJ�y���={��� w      �   "   x�3�tN,N�2�t,H,*I�M�+������ c�&         '   x�3�t��L�+IU0�00�30�2�q�C�b���� �	�      �   ,   x�3�t�H�-��W0�2������lc.8ۄ��6����� i��      �   7   x�3�tN,�Sp��-(-IL�/J-�2�ttD2�tr�S�=���43/��+F��� C�      �   �   x�MN;
�@�gN1'�UKI�
J�lF2��2c���#��\H
���Ѩ!}
,�c��~fT��%��끡�zqQ�Ա��L6p�q�*l��&�#/��0��cz�kjܭ͇(whp����A�rv4�      �   >   x�3�t*J,��I�,J�2��,I��L�K�2���/*I�M�M-�L��p:��^����� a�      �   �   x�e���0C��]�YvL�%:A���
H��'+�7���\�f%e���'l�.!���,0& �F��MQzHo��A��$��IT�����N�l�&�K7CXd�7���g�\m�O!��@��j�hӞM�(<��~��Ѵ��8~��+��b�ퟱ��6�	g'�u9wlq|l�`�l�����[K)ЩO�      �   q   x�]�K�@C��a`Իx�s�|4հ��)���j�Ԅ�PL�cp��XB����ɞh1u�Ո��;'i�e9yqr3(�?�%�����¸<}��>_a$���VJ�c�.�          8   x�%��  ��L���A����0��U���P�:�w(k�;rgY�(���	�      �   �   x�3�4�����,�/�450�30�2�4��ILNT�=�8��"j�p�44�L�jRR�2SR�a��8�9}Sso.�LTr��4���-rOL��K-I�46	���L.�O��-(-IL����:F��� �|&�      �   G   x�3�t-.)MI�+I�2�t�KO��H�,��2�HM)3M8���s2�K�L9���R����b���� ��?      �   ?   x�3��t
V)J�+.�/*I-�*MTHI,V���M,�40�2�4���<�8E'W� ���      �   p   x�˻	�0���)��|p!0�^��U��=QF�b�Ϲÿ�ƨsk�H{"���U�̵���iW��!N:�K|��5����cͪ��4�X�rWٱ��bf?m�"      �   P   x�3�t�K):��ˈ�1'��8?�˘�+�(b�阙S0��M,�L�2�.M�I��2��K����)K�K����� ���     