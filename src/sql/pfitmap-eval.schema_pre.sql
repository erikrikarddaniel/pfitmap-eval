--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: constrain_taxon(); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION constrain_taxon() RETURNS integer
    LANGUAGE sql STRICT SECURITY DEFINER
    AS $$
CREATE RULE rule_taxon_i
       AS ON INSERT TO taxon
       WHERE (
             SELECT taxon_id FROM taxon 
             WHERE ncbi_taxon_id = new.ncbi_taxon_id
             )
       	     IS NOT NULL
       DO INSTEAD NOTHING
;
SELECT 1;
$$;


ALTER FUNCTION public.constrain_taxon() OWNER TO dl;

--
-- Name: insert_hmm_result(text, text, text, text); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION insert_hmm_result(v_hp_name text, v_ss_source text, v_ss_name text, v_ss_version text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_hp_id int;
      v_ss_id int;
      v_return int;

    BEGIN
      -- Find the ids of sequence_sources and hmm_profiles
      SELECT id INTO v_hp_id
      FROM hmm_profiles
      WHERE 
	name = v_hp_name
      ;
      IF NOT FOUND THEN
	RAISE EXCEPTION 'Could not find hmm_profile %.', v_hp_name;
      END IF;

      v_ss_id := insert_sequence_source(v_ss_source, v_ss_name, v_ss_version);

      -- See if we already have a row, otherwise insert
      SELECT id INTO v_return
      FROM hmm_results
      WHERE hmm_profile_id = v_hp_id AND sequence_source_id = v_ss_id
      ;

      IF NOT FOUND THEN
	INSERT INTO hmm_results(hmm_profile_id, sequence_source_id)
	  VALUES(v_hp_id, v_ss_id)
	;
	v_return = currval('hmm_results_id_seq');
      END IF;

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.insert_hmm_result(v_hp_name text, v_ss_source text, v_ss_name text, v_ss_version text) OWNER TO dl;

--
-- Name: insert_hmm_result_domain(integer, integer, integer, integer, integer, double precision, double precision, double precision, double precision, integer, integer, integer, integer, integer, integer, double precision); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION insert_hmm_result_domain(v_hmm_result_row_id integer, v_tlen integer, v_qlen integer, v_i integer, v_n integer, v_c_e_value double precision, v_i_e_value double precision, v_score double precision, v_bias double precision, v_hmm_from integer, v_hmm_to integer, v_ali_from integer, v_ali_to integer, v_env_from integer, v_env_to integer, v_acc double precision) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_return int;

    BEGIN
      SELECT id INTO v_return
      FROM hmm_result_domains
      WHERE 
        hmm_result_row_id = v_hmm_result_row_id AND
	i = v_i
      ;
      IF NOT FOUND THEN
	INSERT INTO hmm_result_domains(
	    hmm_result_row_id, tlen, qlen, i, n,
	    c_e_value, i_e_value, score, bias,
	    hmm_from, hmm_to, ali_from, ali_to, env_from, env_to, acc
	  )
	  VALUES (
	    v_hmm_result_row_id, v_tlen, v_qlen, v_i, v_n,
	    v_c_e_value, v_i_e_value, v_score, v_bias,
	    v_hmm_from, v_hmm_to, v_ali_from, v_ali_to, v_env_from, v_env_to, v_acc
	  )
	;
	v_return := currval('hmm_result_domains_id_seq');
      END IF;

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.insert_hmm_result_domain(v_hmm_result_row_id integer, v_tlen integer, v_qlen integer, v_i integer, v_n integer, v_c_e_value double precision, v_i_e_value double precision, v_score double precision, v_bias double precision, v_hmm_from integer, v_hmm_to integer, v_ali_from integer, v_ali_to integer, v_env_from integer, v_env_to integer, v_acc double precision) OWNER TO dl;

--
-- Name: insert_hmm_result_domain(integer, text, text, integer, integer, integer, integer, double precision, double precision, double precision, double precision, integer, integer, integer, integer, integer, integer, double precision); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION insert_hmm_result_domain(v_hmm_result_row_id integer, v_tname text, v_qname text, v_tlen integer, v_qlen integer, v_i integer, v_n integer, v_c_e_value double precision, v_i_e_value double precision, v_score double precision, v_bias double precision, v_hmm_from integer, v_hmm_to integer, v_ali_from integer, v_ali_to integer, v_env_from integer, v_env_to integer, v_acc double precision) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_return int;

    BEGIN
      SELECT id INTO v_return
      FROM hmm_result_domains
      WHERE 
        hmm_result_row_id = v_hmm_result_row_id AND
	i = v_id
      ;
      IF NOT FOUND THEN
	INSERT INTO hmm_result_domains(
	    hmm_result_row_id, tname, qname, tlen, qlen, i, n,
	    c_e_value, i_e_value, score, bias,
	    hmm_from, hmm_to, ali_from, ali_to, enfrom, ento, acc
	  )
	  VALUES (
	    v_hmm_result_row_id, v_tname, v_qname, v_tlen, v_qlen, v_i, v_n,
	    v_c_e_value, v_i_e_value, v_score, v_bias,
	    v_hmm_from, v_hmm_to, v_ali_from, v_ali_to, v_env_from, v_env_to, v_acc
	  )
	;
	v_return := currval('hmm_result_domains_id_seq');
      END IF;

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.insert_hmm_result_domain(v_hmm_result_row_id integer, v_tname text, v_qname text, v_tlen integer, v_qlen integer, v_i integer, v_n integer, v_c_e_value double precision, v_i_e_value double precision, v_score double precision, v_bias double precision, v_hmm_from integer, v_hmm_to integer, v_ali_from integer, v_ali_to integer, v_env_from integer, v_env_to integer, v_acc double precision) OWNER TO dl;

--
-- Name: insert_hmm_result_row(integer, text, text, double precision, double precision, double precision, double precision, integer, integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION insert_hmm_result_row(v_hmm_result_id integer, v_tname text, v_qname text, v_e_value double precision, v_score double precision, v_bias double precision, v_dom_n_exp double precision, v_dom_n_reg integer, v_dom_n_clu integer, v_dom_n_ov integer, v_dom_n_env integer, v_dom_n_dom integer, v_dom_n_rep integer, v_dom_n_inc integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_return int;

    BEGIN
      INSERT INTO hmm_result_rows(
	hmm_result_id,
	tname, qname, e_value, score, bias,
	dom_n_exp, dom_n_reg, dom_n_clu, dom_n_ov, 
	dom_n_env, dom_n_dom, dom_n_rep, dom_n_inc
      )
	VALUES(
	  v_hmm_result_id,
	  v_tname, v_qname, v_e_value, v_score, v_bias,
	  v_dom_n_exp, v_dom_n_reg, v_dom_n_clu, v_dom_n_ov, 
	  v_dom_n_env, v_dom_n_dom, v_dom_n_rep, v_dom_n_inc
	)
      ;
      v_return = currval('hmm_result_rows_id_seq');

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.insert_hmm_result_row(v_hmm_result_id integer, v_tname text, v_qname text, v_e_value double precision, v_score double precision, v_bias double precision, v_dom_n_exp double precision, v_dom_n_reg integer, v_dom_n_clu integer, v_dom_n_ov integer, v_dom_n_env integer, v_dom_n_dom integer, v_dom_n_rep integer, v_dom_n_inc integer) OWNER TO dl;

--
-- Name: insert_hmm_result_row_sequence(integer, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION insert_hmm_result_row_sequence(v_hmm_result_row_id integer, v_seq_src text, v_db text, v_gi text, v_accno text, v_name text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_return int;
      v_sequence_id int;

    BEGIN
      v_sequence_id := insert_sequence(v_seq_src, v_db, v_gi, v_accno, v_name);

      INSERT INTO hmm_result_row_sequences(hmm_result_row_id, sequence_id)
        VALUES(v_hmm_result_row_id, v_sequence_id)
      ;

      SELECT currval('hmm_result_row_sequences_id_seq') INTO v_return;

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.insert_hmm_result_row_sequence(v_hmm_result_row_id integer, v_seq_src text, v_db text, v_gi text, v_accno text, v_name text) OWNER TO dl;

--
-- Name: insert_sequence(text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION insert_sequence(v_seq_src text, v_db text, v_gi text, v_accno text, v_name text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_return int
    ;

    BEGIN
      SELECT id INTO v_return
      FROM sequences
      WHERE 
        v_seq_src = seq_src AND
	v_accno = accno
      ;
      IF NOT FOUND THEN
	INSERT INTO sequences(seq_src, db, gi, accno, name)
	  VALUES(v_seq_src, v_db, v_gi, v_accno, v_name)
	;
	v_return := currval('sequences_id_seq');
      ELSE
	UPDATE sequences SET
	  db = v_db, gi = v_gi, name = v_name
	WHERE
	  id = v_return
	;
      END IF;

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.insert_sequence(v_seq_src text, v_db text, v_gi text, v_accno text, v_name text) OWNER TO dl;

--
-- Name: insert_sequence(text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION insert_sequence(v_seq_src text, v_db text, v_gi text, v_accno text, v_name text, v_sequence text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_return int
    ;

    BEGIN
      v_return := insert_sequence(v_seq_src, v_db, v_gi, v_accno, v_name);

      UPDATE sequences SET sequence = v_sequence WHERE id = v_return;

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.insert_sequence(v_seq_src text, v_db text, v_gi text, v_accno text, v_name text, v_sequence text) OWNER TO dl;

--
-- Name: insert_sequence_source(text, text, text); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION insert_sequence_source(v_source text, v_name text, v_version text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_return int
    ;

    BEGIN
      SELECT id INTO v_return
      FROM sequence_sources
      WHERE 
	source = v_source AND
	name = v_name AND
	version = v_version
      ;
      IF NOT FOUND THEN
	INSERT INTO sequence_sources(source, name, version)
	  VALUES(v_source, v_name, v_version)
	;
	SELECT currval('sequence_sources_id_seq') INTO v_return;
      END IF;

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.insert_sequence_source(v_source text, v_name text, v_version text) OWNER TO dl;

--
-- Name: unconstrain_taxon(); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION unconstrain_taxon() RETURNS integer
    LANGUAGE sql STRICT SECURITY DEFINER
    AS $$
DROP RULE rule_taxon_i ON taxon;
SELECT 1;
$$;


ALTER FUNCTION public.unconstrain_taxon() OWNER TO dl;

--
-- Name: biodatabase_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE biodatabase_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE biodatabase_pk_seq OWNER TO dl;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: biodatabase; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE biodatabase (
    biodatabase_id integer DEFAULT nextval('biodatabase_pk_seq'::regclass) NOT NULL,
    name character varying(128) NOT NULL,
    authority character varying(128),
    description text
);


ALTER TABLE biodatabase OWNER TO dl;

--
-- Name: bioentry_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE bioentry_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bioentry_pk_seq OWNER TO dl;

--
-- Name: bioentry; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE bioentry (
    bioentry_id integer DEFAULT nextval('bioentry_pk_seq'::regclass) NOT NULL,
    biodatabase_id integer NOT NULL,
    taxon_id integer,
    name character varying(40) NOT NULL,
    accession character varying(128) NOT NULL,
    identifier character varying(40),
    division character varying(6),
    description text,
    version integer NOT NULL
);


ALTER TABLE bioentry OWNER TO dl;

--
-- Name: bioentry_dbxref; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE bioentry_dbxref (
    bioentry_id integer NOT NULL,
    dbxref_id integer NOT NULL,
    rank integer
);


ALTER TABLE bioentry_dbxref OWNER TO dl;

--
-- Name: bioentry_path; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE bioentry_path (
    object_bioentry_id integer NOT NULL,
    subject_bioentry_id integer NOT NULL,
    term_id integer NOT NULL,
    distance integer
);


ALTER TABLE bioentry_path OWNER TO dl;

--
-- Name: bioentry_qualifier_value; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE bioentry_qualifier_value (
    bioentry_id integer NOT NULL,
    term_id integer NOT NULL,
    value text,
    rank integer DEFAULT 0 NOT NULL
);


ALTER TABLE bioentry_qualifier_value OWNER TO dl;

--
-- Name: bioentry_reference; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE bioentry_reference (
    bioentry_id integer NOT NULL,
    reference_id integer NOT NULL,
    start_pos integer,
    end_pos integer,
    rank integer DEFAULT 0 NOT NULL
);


ALTER TABLE bioentry_reference OWNER TO dl;

--
-- Name: bioentry_relationship_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE bioentry_relationship_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bioentry_relationship_pk_seq OWNER TO dl;

--
-- Name: bioentry_relationship; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE bioentry_relationship (
    bioentry_relationship_id integer DEFAULT nextval('bioentry_relationship_pk_seq'::regclass) NOT NULL,
    object_bioentry_id integer NOT NULL,
    subject_bioentry_id integer NOT NULL,
    term_id integer NOT NULL,
    rank integer
);


ALTER TABLE bioentry_relationship OWNER TO dl;

--
-- Name: biosequence; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE biosequence (
    bioentry_id integer NOT NULL,
    version integer,
    length integer,
    alphabet character varying(10),
    seq text
);


ALTER TABLE biosequence OWNER TO dl;

--
-- Name: comment_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE comment_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comment_pk_seq OWNER TO dl;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE comment (
    comment_id integer DEFAULT nextval('comment_pk_seq'::regclass) NOT NULL,
    bioentry_id integer NOT NULL,
    comment_text text NOT NULL,
    rank integer DEFAULT 0 NOT NULL
);


ALTER TABLE comment OWNER TO dl;

--
-- Name: dbxref_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE dbxref_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbxref_pk_seq OWNER TO dl;

--
-- Name: dbxref; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE dbxref (
    dbxref_id integer DEFAULT nextval('dbxref_pk_seq'::regclass) NOT NULL,
    dbname character varying(40) NOT NULL,
    accession character varying(128) NOT NULL,
    version integer NOT NULL
);


ALTER TABLE dbxref OWNER TO dl;

--
-- Name: dbxref_qualifier_value; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE dbxref_qualifier_value (
    dbxref_id integer NOT NULL,
    term_id integer NOT NULL,
    rank integer DEFAULT 0 NOT NULL,
    value text
);


ALTER TABLE dbxref_qualifier_value OWNER TO dl;

--
-- Name: hmm_profiles; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE hmm_profiles (
    id integer NOT NULL,
    name text NOT NULL,
    version text NOT NULL,
    rank text,
    parent_id integer
);


ALTER TABLE hmm_profiles OWNER TO dl;

--
-- Name: hmm_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE hmm_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hmm_profiles_id_seq OWNER TO dl;

--
-- Name: hmm_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE hmm_profiles_id_seq OWNED BY hmm_profiles.id;


--
-- Name: hmm_result_domains; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE hmm_result_domains (
    id integer NOT NULL,
    hmm_result_row_id integer,
    tlen integer NOT NULL,
    qlen integer NOT NULL,
    i integer NOT NULL,
    n integer NOT NULL,
    c_e_value double precision NOT NULL,
    i_e_value double precision NOT NULL,
    score double precision NOT NULL,
    bias double precision NOT NULL,
    hmm_from integer NOT NULL,
    hmm_to integer NOT NULL,
    ali_from integer NOT NULL,
    ali_to integer NOT NULL,
    env_from integer NOT NULL,
    env_to integer NOT NULL,
    acc double precision NOT NULL,
    qali text,
    cali text,
    tali text,
    sali text
);


ALTER TABLE hmm_result_domains OWNER TO dl;

--
-- Name: hmm_result_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE hmm_result_domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hmm_result_domains_id_seq OWNER TO dl;

--
-- Name: hmm_result_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE hmm_result_domains_id_seq OWNED BY hmm_result_domains.id;


--
-- Name: hmm_result_row_sequences; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE hmm_result_row_sequences (
    id integer NOT NULL,
    hmm_result_row_id integer,
    sequence_id integer
);


ALTER TABLE hmm_result_row_sequences OWNER TO dl;

--
-- Name: hmm_result_row_sequences_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE hmm_result_row_sequences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hmm_result_row_sequences_id_seq OWNER TO dl;

--
-- Name: hmm_result_row_sequences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE hmm_result_row_sequences_id_seq OWNED BY hmm_result_row_sequences.id;


--
-- Name: hmm_result_rows; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE hmm_result_rows (
    id integer NOT NULL,
    hmm_result_id integer,
    tname text NOT NULL,
    qname text NOT NULL,
    e_value double precision NOT NULL,
    score double precision NOT NULL,
    bias double precision NOT NULL,
    dom_n_exp double precision NOT NULL,
    dom_n_reg integer NOT NULL,
    dom_n_clu integer NOT NULL,
    dom_n_ov integer NOT NULL,
    dom_n_env integer NOT NULL,
    dom_n_dom integer NOT NULL,
    dom_n_rep integer NOT NULL,
    dom_n_inc integer NOT NULL
);


ALTER TABLE hmm_result_rows OWNER TO dl;

--
-- Name: hmm_result_rows_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE hmm_result_rows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hmm_result_rows_id_seq OWNER TO dl;

--
-- Name: hmm_result_rows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE hmm_result_rows_id_seq OWNED BY hmm_result_rows.id;


--
-- Name: hmm_results; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE hmm_results (
    id integer NOT NULL,
    hmm_profile_id integer,
    sequence_source_id integer,
    executed timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE hmm_results OWNER TO dl;

--
-- Name: hmm_results_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE hmm_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hmm_results_id_seq OWNER TO dl;

--
-- Name: hmm_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE hmm_results_id_seq OWNED BY hmm_results.id;


--
-- Name: location_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE location_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE location_pk_seq OWNER TO dl;

--
-- Name: location; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE location (
    location_id integer DEFAULT nextval('location_pk_seq'::regclass) NOT NULL,
    seqfeature_id integer NOT NULL,
    dbxref_id integer,
    term_id integer,
    start_pos integer,
    end_pos integer,
    strand integer DEFAULT 0 NOT NULL,
    rank integer DEFAULT 0 NOT NULL
);


ALTER TABLE location OWNER TO dl;

--
-- Name: location_qualifier_value; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE location_qualifier_value (
    location_id integer NOT NULL,
    term_id integer NOT NULL,
    value character varying(255) NOT NULL,
    int_value integer
);


ALTER TABLE location_qualifier_value OWNER TO dl;

--
-- Name: ontology_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE ontology_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ontology_pk_seq OWNER TO dl;

--
-- Name: ontology; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE ontology (
    ontology_id integer DEFAULT nextval('ontology_pk_seq'::regclass) NOT NULL,
    name character varying(32) NOT NULL,
    definition text
);


ALTER TABLE ontology OWNER TO dl;

--
-- Name: reference_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE reference_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reference_pk_seq OWNER TO dl;

--
-- Name: reference; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE reference (
    reference_id integer DEFAULT nextval('reference_pk_seq'::regclass) NOT NULL,
    dbxref_id integer,
    location text NOT NULL,
    title text,
    authors text,
    crc character varying(32)
);


ALTER TABLE reference OWNER TO dl;

--
-- Name: result_row_sequences; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE result_row_sequences (
    id integer NOT NULL,
    hmm_result_row_id integer,
    sequence_id integer
);


ALTER TABLE result_row_sequences OWNER TO dl;

--
-- Name: result_row_sequences_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE result_row_sequences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE result_row_sequences_id_seq OWNER TO dl;

--
-- Name: result_row_sequences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE result_row_sequences_id_seq OWNED BY result_row_sequences.id;


--
-- Name: seqfeature_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE seqfeature_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seqfeature_pk_seq OWNER TO dl;

--
-- Name: seqfeature; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE seqfeature (
    seqfeature_id integer DEFAULT nextval('seqfeature_pk_seq'::regclass) NOT NULL,
    bioentry_id integer NOT NULL,
    type_term_id integer NOT NULL,
    source_term_id integer NOT NULL,
    display_name character varying(64),
    rank integer DEFAULT 0 NOT NULL
);


ALTER TABLE seqfeature OWNER TO dl;

--
-- Name: seqfeature_dbxref; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE seqfeature_dbxref (
    seqfeature_id integer NOT NULL,
    dbxref_id integer NOT NULL,
    rank integer
);


ALTER TABLE seqfeature_dbxref OWNER TO dl;

--
-- Name: seqfeature_path; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE seqfeature_path (
    object_seqfeature_id integer NOT NULL,
    subject_seqfeature_id integer NOT NULL,
    term_id integer NOT NULL,
    distance integer
);


ALTER TABLE seqfeature_path OWNER TO dl;

--
-- Name: seqfeature_qualifier_value; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE seqfeature_qualifier_value (
    seqfeature_id integer NOT NULL,
    term_id integer NOT NULL,
    rank integer DEFAULT 0 NOT NULL,
    value text NOT NULL
);


ALTER TABLE seqfeature_qualifier_value OWNER TO dl;

--
-- Name: seqfeature_relationship_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE seqfeature_relationship_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seqfeature_relationship_pk_seq OWNER TO dl;

--
-- Name: seqfeature_relationship; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE seqfeature_relationship (
    seqfeature_relationship_id integer DEFAULT nextval('seqfeature_relationship_pk_seq'::regclass) NOT NULL,
    object_seqfeature_id integer NOT NULL,
    subject_seqfeature_id integer NOT NULL,
    term_id integer NOT NULL,
    rank integer
);


ALTER TABLE seqfeature_relationship OWNER TO dl;

--
-- Name: sequence_sources; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE sequence_sources (
    id integer NOT NULL,
    source text NOT NULL,
    name text NOT NULL,
    version text NOT NULL
);


ALTER TABLE sequence_sources OWNER TO dl;

--
-- Name: sequence_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE sequence_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sequence_sources_id_seq OWNER TO dl;

--
-- Name: sequence_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE sequence_sources_id_seq OWNED BY sequence_sources.id;


--
-- Name: sequences; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE sequences (
    id integer NOT NULL,
    seq_src text NOT NULL,
    db text NOT NULL,
    gi text,
    accno text NOT NULL,
    name text NOT NULL,
    sequence text
);


ALTER TABLE sequences OWNER TO dl;

--
-- Name: sequences_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE sequences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sequences_id_seq OWNER TO dl;

--
-- Name: sequences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE sequences_id_seq OWNED BY sequences.id;


--
-- Name: taxon_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE taxon_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE taxon_pk_seq OWNER TO dl;

--
-- Name: taxon; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE taxon (
    taxon_id integer DEFAULT nextval('taxon_pk_seq'::regclass) NOT NULL,
    ncbi_taxon_id integer,
    parent_taxon_id integer,
    node_rank character varying(32),
    genetic_code smallint,
    mito_genetic_code smallint,
    left_value integer,
    right_value integer
);


ALTER TABLE taxon OWNER TO dl;

--
-- Name: taxon_name; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE taxon_name (
    taxon_id integer NOT NULL,
    name character varying(255) NOT NULL,
    name_class character varying(32) NOT NULL
);


ALTER TABLE taxon_name OWNER TO dl;

--
-- Name: term_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE term_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE term_pk_seq OWNER TO dl;

--
-- Name: term; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE term (
    term_id integer DEFAULT nextval('term_pk_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    definition text,
    identifier character varying(40),
    is_obsolete character(1),
    ontology_id integer NOT NULL
);


ALTER TABLE term OWNER TO dl;

--
-- Name: term_dbxref; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE term_dbxref (
    term_id integer NOT NULL,
    dbxref_id integer NOT NULL,
    rank integer
);


ALTER TABLE term_dbxref OWNER TO dl;

--
-- Name: term_path_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE term_path_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE term_path_pk_seq OWNER TO dl;

--
-- Name: term_path; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE term_path (
    term_path_id integer DEFAULT nextval('term_path_pk_seq'::regclass) NOT NULL,
    subject_term_id integer NOT NULL,
    predicate_term_id integer NOT NULL,
    object_term_id integer NOT NULL,
    ontology_id integer NOT NULL,
    distance integer
);


ALTER TABLE term_path OWNER TO dl;

--
-- Name: term_relationship_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE term_relationship_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE term_relationship_pk_seq OWNER TO dl;

--
-- Name: term_relationship; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE term_relationship (
    term_relationship_id integer DEFAULT nextval('term_relationship_pk_seq'::regclass) NOT NULL,
    subject_term_id integer NOT NULL,
    predicate_term_id integer NOT NULL,
    object_term_id integer NOT NULL,
    ontology_id integer NOT NULL
);


ALTER TABLE term_relationship OWNER TO dl;

--
-- Name: term_relationship_term; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE term_relationship_term (
    term_relationship_id integer NOT NULL,
    term_id integer NOT NULL
);


ALTER TABLE term_relationship_term OWNER TO dl;

--
-- Name: term_synonym; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE term_synonym (
    synonym character varying(255) NOT NULL,
    term_id integer NOT NULL
);


ALTER TABLE term_synonym OWNER TO dl;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dl
--

ALTER TABLE ONLY hmm_profiles ALTER COLUMN id SET DEFAULT nextval('hmm_profiles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dl
--

ALTER TABLE ONLY hmm_result_domains ALTER COLUMN id SET DEFAULT nextval('hmm_result_domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dl
--

ALTER TABLE ONLY hmm_result_row_sequences ALTER COLUMN id SET DEFAULT nextval('hmm_result_row_sequences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dl
--

ALTER TABLE ONLY hmm_result_rows ALTER COLUMN id SET DEFAULT nextval('hmm_result_rows_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dl
--

ALTER TABLE ONLY hmm_results ALTER COLUMN id SET DEFAULT nextval('hmm_results_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dl
--

ALTER TABLE ONLY result_row_sequences ALTER COLUMN id SET DEFAULT nextval('result_row_sequences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dl
--

ALTER TABLE ONLY sequence_sources ALTER COLUMN id SET DEFAULT nextval('sequence_sources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dl
--

ALTER TABLE ONLY sequences ALTER COLUMN id SET DEFAULT nextval('sequences_id_seq'::regclass);


