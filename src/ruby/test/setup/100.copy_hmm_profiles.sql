--
-- Data for Name: hmm_profiles; Type: TABLE DATA; Schema: public; Owner: dl
--

COPY hmm_profiles (id, name, version, rank, parent_id) FROM stdin;
1	NrdGRE	0.5	superfamily	\N
2	GRE	0.5	family	1
3	NrdJA	0.5	family	1
4	NrdD	0.5	class	2
5	NrdJ	0.5	class	3
6	NrdA	0.5	class	3
7	NrdAe	0.5	subclass	6
8	NrdAg	0.5	subclass	6
9	NrdAz	0.5	subclass	6
100	Ferritin-like	0.5	superfamily	\N
101	Ferritin-like-enzymes	0.5	\N	100
102	NrdBR2lox	0.5	family	101
103	NrdB	0.5	class	102
104	R2lox	0.5	class	102
200	Flavodoxins	0.5	superfamily	\N
201	Flvd1	0.5	class	200
202	Flvd2	0.5	class	200
203	Flvd3	0.5	class	200
204	Flvd4	0.5	class	200
205	Flvd5	0.5	class	200
206	FmnRed	0.5	class	200
207	NrdI	0.5	class	200
208	ATP cone	0.5	domain	\N
\.


--
-- Name: hmm_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dl
--

SELECT pg_catalog.setval('hmm_profiles_id_seq', 1, false);

