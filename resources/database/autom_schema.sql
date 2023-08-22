--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9
-- Dumped by pg_dump version 14.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: at_auth; Type: TABLE; Schema: public; Owner: autom
--

CREATE TABLE public.at_auth (
    id integer NOT NULL,
    descricao text NOT NULL
);


ALTER TABLE public.at_auth OWNER TO autom;

--
-- Name: at_auth_id_seq; Type: SEQUENCE; Schema: public; Owner: autom
--

CREATE SEQUENCE public.at_auth_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.at_auth_id_seq OWNER TO autom;

--
-- Name: at_auth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: autom
--

ALTER SEQUENCE public.at_auth_id_seq OWNED BY public.at_auth.id;


--
-- Name: at_cidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.at_cidade (
    id integer NOT NULL,
    nome text NOT NULL,
    cod_ibge text NOT NULL,
    ref_estado integer NOT NULL
);


ALTER TABLE public.at_cidade OWNER TO postgres;

--
-- Name: at_cidade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.at_cidade_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.at_cidade_id_seq OWNER TO postgres;

--
-- Name: at_cidade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.at_cidade_id_seq OWNED BY public.at_cidade.id;


--
-- Name: at_estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.at_estado (
    id integer NOT NULL,
    nome text NOT NULL,
    sigla text,
    cod_ibge integer
);


ALTER TABLE public.at_estado OWNER TO postgres;

--
-- Name: at_estado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.at_estado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.at_estado_id_seq OWNER TO postgres;

--
-- Name: at_estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.at_estado_id_seq OWNED BY public.at_estado.id;


--
-- Name: at_marcas; Type: TABLE; Schema: public; Owner: autom
--

CREATE TABLE public.at_marcas (
    id integer NOT NULL,
    nome text NOT NULL
);


ALTER TABLE public.at_marcas OWNER TO autom;

--
-- Name: at_marcas_id_seq; Type: SEQUENCE; Schema: public; Owner: autom
--

CREATE SEQUENCE public.at_marcas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.at_marcas_id_seq OWNER TO autom;

--
-- Name: at_marcas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: autom
--

ALTER SEQUENCE public.at_marcas_id_seq OWNED BY public.at_marcas.id;


--
-- Name: at_pecas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.at_pecas (
    id integer NOT NULL,
    nome text NOT NULL,
    descricao text,
    valor_compra numeric(6,2) NOT NULL,
    valor_revenda numeric(6,2) NOT NULL,
    ref_marca integer NOT NULL
);


ALTER TABLE public.at_pecas OWNER TO postgres;

--
-- Name: at_pecas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.at_pecas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.at_pecas_id_seq OWNER TO postgres;

--
-- Name: at_pecas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.at_pecas_id_seq OWNED BY public.at_pecas.id;


--
-- Name: at_pedidos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.at_pedidos (
    id integer NOT NULL,
    total numeric(10,2),
    status integer,
    dt_abertura date DEFAULT now(),
    dt_encerramento date,
    dt_reabertura date,
    dt_cancelamento date,
    cep text,
    rua text,
    bairro text,
    numero_endereco text,
    ref_cidade integer,
    fl_usar_endereco_cliente boolean DEFAULT false
);


ALTER TABLE public.at_pedidos OWNER TO postgres;

--
-- Name: at_pedidos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.at_pedidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.at_pedidos_id_seq OWNER TO postgres;

--
-- Name: at_pedidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.at_pedidos_id_seq OWNED BY public.at_pedidos.id;


--
-- Name: at_pedidos_pecas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.at_pedidos_pecas (
    ref_pedido integer NOT NULL,
    ref_peca integer NOT NULL,
    quantidade integer NOT NULL
);


ALTER TABLE public.at_pedidos_pecas OWNER TO postgres;

--
-- Name: at_pedidos_pessoa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.at_pedidos_pessoa (
    ref_pessoa integer NOT NULL,
    ref_pedido integer NOT NULL
);


ALTER TABLE public.at_pedidos_pessoa OWNER TO postgres;

--
-- Name: at_pessoa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.at_pessoa (
    id integer NOT NULL,
    nome text NOT NULL,
    email text NOT NULL,
    senha text,
    telefone text NOT NULL,
    sys_auth integer NOT NULL,
    cep text NOT NULL,
    rua text NOT NULL,
    bairro text NOT NULL,
    numero_endereco integer NOT NULL,
    ref_cidade integer,
    tipo_pessoa integer NOT NULL,
    complemento text
);


ALTER TABLE public.at_pessoa OWNER TO postgres;

--
-- Name: at_pessoa_fisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.at_pessoa_fisica (
    ref_pessoa integer NOT NULL,
    cpf text NOT NULL,
    rg text NOT NULL,
    dt_nascimento date NOT NULL
);


ALTER TABLE public.at_pessoa_fisica OWNER TO postgres;

--
-- Name: at_pessoa_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.at_pessoa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.at_pessoa_id_seq OWNER TO postgres;

--
-- Name: at_pessoa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.at_pessoa_id_seq OWNED BY public.at_pessoa.id;


--
-- Name: at_pessoa_juridica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.at_pessoa_juridica (
    ref_pessoa integer NOT NULL,
    razao_social text NOT NULL,
    nome_fantasia text NOT NULL,
    cnpj text NOT NULL,
    dt_registro date NOT NULL
);


ALTER TABLE public.at_pessoa_juridica OWNER TO postgres;

--
-- Name: at_auth id; Type: DEFAULT; Schema: public; Owner: autom
--

ALTER TABLE ONLY public.at_auth ALTER COLUMN id SET DEFAULT nextval('public.at_auth_id_seq'::regclass);


--
-- Name: at_cidade id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_cidade ALTER COLUMN id SET DEFAULT nextval('public.at_cidade_id_seq'::regclass);


--
-- Name: at_estado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_estado ALTER COLUMN id SET DEFAULT nextval('public.at_estado_id_seq'::regclass);


--
-- Name: at_marcas id; Type: DEFAULT; Schema: public; Owner: autom
--

ALTER TABLE ONLY public.at_marcas ALTER COLUMN id SET DEFAULT nextval('public.at_marcas_id_seq'::regclass);


--
-- Name: at_pecas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pecas ALTER COLUMN id SET DEFAULT nextval('public.at_pecas_id_seq'::regclass);


--
-- Name: at_pedidos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pedidos ALTER COLUMN id SET DEFAULT nextval('public.at_pedidos_id_seq'::regclass);


--
-- Name: at_pessoa id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pessoa ALTER COLUMN id SET DEFAULT nextval('public.at_pessoa_id_seq'::regclass);


--
-- Name: at_auth at_auth_descricao_key; Type: CONSTRAINT; Schema: public; Owner: autom
--

ALTER TABLE ONLY public.at_auth
    ADD CONSTRAINT at_auth_descricao_key UNIQUE (descricao);


--
-- Name: at_auth at_auth_pk; Type: CONSTRAINT; Schema: public; Owner: autom
--

ALTER TABLE ONLY public.at_auth
    ADD CONSTRAINT at_auth_pk PRIMARY KEY (id);


--
-- Name: at_cidade at_cidade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_cidade
    ADD CONSTRAINT at_cidade_pkey PRIMARY KEY (id);


--
-- Name: at_estado at_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_estado
    ADD CONSTRAINT at_estado_pkey PRIMARY KEY (id);


--
-- Name: at_marcas at_marcas_nome_key; Type: CONSTRAINT; Schema: public; Owner: autom
--

ALTER TABLE ONLY public.at_marcas
    ADD CONSTRAINT at_marcas_nome_key UNIQUE (nome);


--
-- Name: at_marcas at_marcas_pkey; Type: CONSTRAINT; Schema: public; Owner: autom
--

ALTER TABLE ONLY public.at_marcas
    ADD CONSTRAINT at_marcas_pkey PRIMARY KEY (id);


--
-- Name: at_pecas at_pecas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pecas
    ADD CONSTRAINT at_pecas_pkey PRIMARY KEY (id);


--
-- Name: at_pedidos at_pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pedidos
    ADD CONSTRAINT at_pedidos_pkey PRIMARY KEY (id);


--
-- Name: at_pessoa at_pessoa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pessoa
    ADD CONSTRAINT at_pessoa_pkey PRIMARY KEY (id);


--
-- Name: at_cidade at_cidade_ref_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_cidade
    ADD CONSTRAINT at_cidade_ref_estado_fkey FOREIGN KEY (ref_estado) REFERENCES public.at_estado(id);


--
-- Name: at_pecas at_pecas_ref_marcas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pecas
    ADD CONSTRAINT at_pecas_ref_marcas FOREIGN KEY (ref_marca) REFERENCES public.at_marcas(id);


--
-- Name: at_pedidos_pecas at_pedidos_pecas_ref_peca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pedidos_pecas
    ADD CONSTRAINT at_pedidos_pecas_ref_peca_fk FOREIGN KEY (ref_peca) REFERENCES public.at_pecas(id);


--
-- Name: at_pedidos_pecas at_pedidos_pecas_ref_pedido_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pedidos_pecas
    ADD CONSTRAINT at_pedidos_pecas_ref_pedido_fk FOREIGN KEY (ref_pedido) REFERENCES public.at_pedidos(id);


--
-- Name: at_pedidos_pessoa at_pedidos_pessoa_ref_pedido_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pedidos_pessoa
    ADD CONSTRAINT at_pedidos_pessoa_ref_pedido_fk FOREIGN KEY (ref_pedido) REFERENCES public.at_pedidos(id);


--
-- Name: at_pedidos_pessoa at_pedidos_pessoa_ref_pessoa_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pedidos_pessoa
    ADD CONSTRAINT at_pedidos_pessoa_ref_pessoa_fk FOREIGN KEY (ref_pessoa) REFERENCES public.at_pessoa(id);


--
-- Name: at_pedidos at_pedidos_ref_cidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pedidos
    ADD CONSTRAINT at_pedidos_ref_cidade_fkey FOREIGN KEY (ref_cidade) REFERENCES public.at_cidade(id);


--
-- Name: at_pessoa at_pessoa_ref_cidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pessoa
    ADD CONSTRAINT at_pessoa_ref_cidade_fkey FOREIGN KEY (ref_cidade) REFERENCES public.at_cidade(id);


--
-- Name: at_pessoa fk_at_auth; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pessoa
    ADD CONSTRAINT fk_at_auth FOREIGN KEY (sys_auth) REFERENCES public.at_auth(id);


--
-- Name: at_pessoa_fisica ref_pessoa_fisica_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pessoa_fisica
    ADD CONSTRAINT ref_pessoa_fisica_fk FOREIGN KEY (ref_pessoa) REFERENCES public.at_pessoa(id);


--
-- Name: at_pessoa_juridica ref_pessoa_juridica_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.at_pessoa_juridica
    ADD CONSTRAINT ref_pessoa_juridica_fk FOREIGN KEY (ref_pessoa) REFERENCES public.at_pessoa(id);


--
-- Name: TABLE at_cidade; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.at_cidade TO autom;


--
-- Name: SEQUENCE at_cidade_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.at_cidade_id_seq TO autom;


--
-- Name: TABLE at_estado; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.at_estado TO autom;


--
-- Name: SEQUENCE at_estado_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.at_estado_id_seq TO autom;


--
-- Name: TABLE at_pecas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.at_pecas TO autom;


--
-- Name: SEQUENCE at_pecas_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.at_pecas_id_seq TO autom;


--
-- Name: TABLE at_pedidos; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.at_pedidos TO autom;


--
-- Name: SEQUENCE at_pedidos_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.at_pedidos_id_seq TO autom;


--
-- Name: TABLE at_pedidos_pecas; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.at_pedidos_pecas TO autom;


--
-- Name: TABLE at_pedidos_pessoa; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.at_pedidos_pessoa TO autom;


--
-- Name: TABLE at_pessoa; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.at_pessoa TO autom;


--
-- Name: TABLE at_pessoa_fisica; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.at_pessoa_fisica TO autom;


--
-- Name: SEQUENCE at_pessoa_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.at_pessoa_id_seq TO autom;


--
-- Name: TABLE at_pessoa_juridica; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.at_pessoa_juridica TO autom;


--
-- PostgreSQL database dump complete
--

