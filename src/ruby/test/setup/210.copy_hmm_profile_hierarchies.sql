--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: hmm_profile_hierarchies; Type: TABLE DATA; Schema: public; Owner: dl
--

COPY hmm_profile_hierarchies (hmm_profile_id, superfamily, family, class, subclass, "group", version) FROM stdin;
1	NrdGRE	\N	\N	\N	\N	0.5
2	NrdGRE	GRE	\N	\N	\N	0.5
3	NrdGRE	NrdJA	\N	\N	\N	0.5
4	NrdGRE	GRE	NrdD	\N	\N	0.5
5	NrdGRE	NrdJA	NrdJ	\N	\N	0.5
6	NrdGRE	NrdJA	NrdA	\N	\N	0.5
7	NrdGRE	NrdJA	NrdA	NrdAe	\N	0.5
8	NrdGRE	NrdJA	NrdA	NrdAg	\N	0.5
9	NrdGRE	NrdJA	NrdA	NrdAz	\N	0.5
100	Ferritin-like	\N	\N	\N	\N	0.5
101	Ferritin-like	\N	\N	\N	\N	0.5
102	Ferritin-like	NrdBR2lox	\N	\N	\N	0.5
103	Ferritin-like	NrdBR2lox	NrdB	\N	\N	0.5
104	Ferritin-like	NrdBR2lox	R2lox	\N	\N	0.5
200	Flavodoxins	\N	\N	\N	\N	0.5
201	Flavodoxins	\N	Flvd1	\N	\N	0.5
202	Flavodoxins	\N	Flvd2	\N	\N	0.5
203	Flavodoxins	\N	Flvd3	\N	\N	0.5
204	Flavodoxins	\N	Flvd4	\N	\N	0.5
205	Flavodoxins	\N	Flvd5	\N	\N	0.5
206	Flavodoxins	\N	FmnRed	\N	\N	0.5
207	Flavodoxins	\N	NrdI	\N	\N	0.5
\.


--
-- PostgreSQL database dump complete
--

