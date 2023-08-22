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

--
-- Data for Name: at_auth; Type: TABLE DATA; Schema: public; Owner: autom
--

COPY public.at_auth (id, descricao) FROM stdin;
1	Administrador
2	Usu├írio
3	Cliente
4	test
\.


--
-- Data for Name: at_estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.at_estado (id, nome, sigla, cod_ibge) FROM stdin;
1	Rio Grande do Sul	RS	43
18	Estado teste4	ST	545455
19	Acre	AC	12
20	Alagoas	AL	27
21	Amap├í	AP	16
22	Amazonas	AM	13
23	Bahia	BA	29
24	Cear├í	CE	23
25	Distrito Federal	DF	53
26	Esp├¡rito Santo	ES	32
27	Goi├ís	GO	52
28	Maranh├úo	MA	21
29	Mato Grosso	MT	51
30	Mato Grosso do Sul	MS	50
31	Minas Gerais	MG	31
32	Par├í	PA	15
33	Para├¡ba	PB	25
34	Paran├í	PR	41
\.


--
-- Data for Name: at_cidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.at_cidade (id, nome, cod_ibge, ref_estado) FROM stdin;
1	Lajeado	4311403	1
4	Estrela	4307807	1
5	Arroio do Meio	4301008	1
\.


--
-- Data for Name: at_marcas; Type: TABLE DATA; Schema: public; Owner: autom
--

COPY public.at_marcas (id, nome) FROM stdin;
1	Nakata
2	3M
3	Bosch
4	SKF
5	Hipper Freios
6	Magnet Marelli
7	Cofap
\.


--
-- Data for Name: at_pecas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.at_pecas (id, nome, descricao, valor_compra, valor_revenda, ref_marca) FROM stdin;
8	Pastilha de freio	Ajuda a freiar.	100.00	250.00	5
9	Palheta Dianteira 	Palheta dianteira para limpador de para-brisa	10.00	40.00	3
10	Teste	1	0.50	2.50	1
6	Disco de freio	Freai	250.00	750.00	1
11	teste1	\N	200.00	500.00	5
12	teste2	\N	200.00	500.00	5
13	teste3	\N	200.00	500.00	5
14	teste4	\N	200.00	500.00	5
15	teste5	\N	200.00	500.00	5
16	teste6	\N	200.00	500.00	5
17	teste7	\N	200.00	500.00	5
18	teste8	\N	200.00	500.00	5
19	teste9	\N	200.00	500.00	5
20	teste10	\N	200.00	500.00	5
21	teste11	\N	200.00	500.00	5
22	teste12	\N	200.00	500.00	5
23	teste13	\N	200.00	500.00	5
24	teste14	\N	200.00	500.00	5
25	teste15	\N	200.00	500.00	5
26	teste16	\N	200.00	500.00	5
27	teste17	\N	200.00	500.00	5
28	teste18	\N	200.00	500.00	5
29	teste19	\N	200.00	500.00	5
30	teste20	\N	200.00	500.00	5
31	teste21	\N	200.00	500.00	5
32	teste22	\N	200.00	500.00	5
33	teste23	\N	200.00	500.00	5
34	teste24	\N	200.00	500.00	5
35	teste25	\N	200.00	500.00	5
37	teste27	\N	200.00	500.00	5
38	teste28	\N	200.00	500.00	5
39	teste29	\N	200.00	500.00	5
40	teste30	\N	200.00	500.00	5
41	teste31	\N	200.00	500.00	5
42	teste32	\N	200.00	500.00	5
\.


--
-- Data for Name: at_pedidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.at_pedidos (id, total, status, dt_abertura, dt_encerramento, dt_reabertura, dt_cancelamento, cep, rua, bairro, numero_endereco, ref_cidade, fl_usar_endereco_cliente) FROM stdin;
17	750.00	3	2023-05-18	2023-05-25	2023-05-25	\N	\N	\N	\N	\N	\N	f
13	8250.00	3	2023-05-18	2023-05-27	\N	\N	\N	\N	\N	\N	\N	f
15	4007.50	3	2023-05-18	2023-05-27	\N	\N	\N	\N	\N	\N	\N	f
14	9045.00	1	2023-05-18	\N	\N	2023-05-27	\N	\N	\N	\N	\N	f
18	560.00	2	2023-06-22	\N	\N	\N	\N	\N	\N	\N	\N	t
19	520.00	2	2023-06-22	\N	\N	\N	95914104	Rua Wilma Ruwer	Universit├írio	29	1	f
16	18080.00	1	2023-05-18	\N	\N	2023-06-28	\N	\N	\N	\N	\N	f
20	480.00	2	2023-06-28	\N	\N	\N	\N	\N	\N	\N	\N	t
21	830.00	3	2023-06-29	2023-06-29	2023-06-29	\N	\N	\N	\N	\N	\N	t
\.


--
-- Data for Name: at_pedidos_pecas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.at_pedidos_pecas (ref_pedido, ref_peca, quantidade) FROM stdin;
13	6	11
15	6	4
15	8	4
15	10	3
16	6	23
16	9	2
16	8	3
17	6	1
14	6	12
14	10	2
14	9	1
18	9	14
19	9	13
20	9	12
21	9	2
21	6	1
\.


--
-- Data for Name: at_pessoa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.at_pessoa (id, nome, email, senha, telefone, sys_auth, cep, rua, bairro, numero_endereco, ref_cidade, tipo_pessoa, complemento) FROM stdin;
67	Gabrielli Sartori	gabi_rainhadopacinho@gmail.com	4cd3b12838ed50ab53afe3e6ca7b28846c8c4a0ba576f1e830574993031823f1	981376717	1	95914-014	Avenida Avelino Talini	Universit├írio	171	1	1	DA Engenharia de Software
68	Fabricio	pretto@gmail.com	ecbcf21cef972fb34c4311c4eefbd34486a9c27eaf02ad564090485f7a00bd64	981376717	1	95914014	Avenida Avelino Talini	Universit├írio	171	1	1	Universidade do Vale do Taquari
64	Teste JWT	gabriel.ramoaaaaas@univates.br	0016d5b910f63146824003d3f0a2d66a89d1e3792f96c5865e674103a3ba7cf7	51981376717	1	95914-104	Rua	Bairro	2203	4	1	\N
65	Teste	gabriel.ramoaaaaas@univates.br	0016d5b910f63146824003d3f0a2d66a89d1e3792f96c5865e674103a3ba7cf7	51981376717	1	95914-104	Rua	Bairro	2203	4	1	\N
59	Gabriel Lange Ramos	gabriel.ramos@univates.br	0016d5b910f63146824003d3f0a2d66a89d1e3792f96c5865e674103a3ba7cf7	51981376717	1	95914-104	Rua Wilma Ruwer	Universit├írio	2203	1	1	Casa
66	juca bala	juba@bal22a.com.br	4cd3b12838ed50ab53afe3e6ca7b28846c8c4a0ba576f1e830574993031823f1	51981376717	2	95914-104	Wilma Ruwer	Universit├írio	128	1	1	DA Engenharia de Software
\.


--
-- Data for Name: at_pedidos_pessoa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.at_pedidos_pessoa (ref_pessoa, ref_pedido) FROM stdin;
64	13
64	14
66	15
66	16
59	17
59	18
66	19
67	20
68	21
\.


--
-- Data for Name: at_pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.at_pessoa_fisica (ref_pessoa, cpf, rg, dt_nascimento) FROM stdin;
\.


--
-- Data for Name: at_pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.at_pessoa_juridica (ref_pessoa, razao_social, nome_fantasia, cnpj, dt_registro) FROM stdin;
\.


--
-- Name: at_auth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: autom
--

SELECT pg_catalog.setval('public.at_auth_id_seq', 4, true);


--
-- Name: at_cidade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.at_cidade_id_seq', 5, true);


--
-- Name: at_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.at_estado_id_seq', 34, true);


--
-- Name: at_marcas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: autom
--

SELECT pg_catalog.setval('public.at_marcas_id_seq', 7, true);


--
-- Name: at_pecas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.at_pecas_id_seq', 44, true);


--
-- Name: at_pedidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.at_pedidos_id_seq', 21, true);


--
-- Name: at_pessoa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.at_pessoa_id_seq', 68, true);


--
-- PostgreSQL database dump complete
--

