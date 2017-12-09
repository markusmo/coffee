--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: issues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE issues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: issues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE issues (
    id integer DEFAULT nextval('issues_id_seq'::regclass) NOT NULL,
    title character(100),
    state integer
);


--
-- Name: state_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: states; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE states (
    id integer DEFAULT nextval('state_id_seq'::regclass) NOT NULL,
    state character(10)
);


--
-- Name: transitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE transitions (
    id integer DEFAULT nextval('transitions_id_seq'::regclass) NOT NULL,
    from_state integer,
    to_state integer
);


--
-- Data for Name: issues; Type: TABLE DATA; Schema: public; Owner: -
--

COPY issues (id, title, state) FROM stdin;
1	get new coffee machine                                                                              	4
2	(re)fill beans                                                                                      	3
3	fill water tank                                                                                     	1
4	make coffee                                                                                         	2
5	turn old coffee machine of and on again                                                             	5
6	make more coffee                                                                                    	1
7	repair old coffee machine                                                                           	5
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: -
--

COPY states (id, state) FROM stdin;
1	to do     
2	on hold   
3	doing     
4	done      
5	failed    
\.


--
-- Data for Name: transitions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY transitions (id, from_state, to_state) FROM stdin;
1	1	3
2	1	2
3	3	4
4	3	5
5	3	2
6	2	3
\.


--
-- Name: issues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('issues_id_seq', 7, true);


--
-- Name: state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('state_id_seq', 5, true);


--
-- Name: transitions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('transitions_id_seq', 6, true);


--
-- Name: issues issues_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY issues
    ADD CONSTRAINT issues_id_key UNIQUE (id);


--
-- Name: issues issues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (id);


--
-- Name: states states_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY states
    ADD CONSTRAINT states_id_key UNIQUE (id);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: states states_state_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY states
    ADD CONSTRAINT states_state_key UNIQUE (state);


--
-- Name: transitions transitions_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transitions
    ADD CONSTRAINT transitions_id_key UNIQUE (id);


--
-- Name: transitions transitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transitions
    ADD CONSTRAINT transitions_pkey PRIMARY KEY (id);


--
-- Name: transitions fk_from_state; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transitions
    ADD CONSTRAINT fk_from_state FOREIGN KEY (to_state) REFERENCES states(id);


--
-- Name: issues fk_from_state; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY issues
    ADD CONSTRAINT fk_from_state FOREIGN KEY (state) REFERENCES states(id);


--
-- Name: transitions fk_to_state; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transitions
    ADD CONSTRAINT fk_to_state FOREIGN KEY (from_state) REFERENCES states(id);


--
-- PostgreSQL database dump complete
--

