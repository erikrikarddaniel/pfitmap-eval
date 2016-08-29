--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
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
-- Name: fasta(text, text); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION fasta(name text, seq text) RETURNS text
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_return		text;

    BEGIN
      v_return := '>' || regexp_replace(regexp_replace(replace(replace(name, '[', ''), ']', ''), '[-:|.()]', '', 'g'), '  *', '_', 'g') || E'\n' || seq;

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.fasta(name text, seq text) OWNER TO dl;

--
-- Name: fasta(text, text, text, text); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION fasta(org_name text, prot_name text, accno text, seq text) RETURNS text
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_return		text;

    BEGIN
      SELECT fasta(concat_ws('_', org_name, prot_name, 'accno', accno), seq) INTO v_return;

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.fasta(org_name text, prot_name text, accno text, seq text) OWNER TO dl;

--
-- Name: fasta(text, text, text, text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION fasta(domain text, phylum text, organism text, protfamily text, protclass text, protsubclass text, protgroup text, accno text, seq text) RETURNS text
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_return		text;

    BEGIN
      SELECT 
        fasta(
	  concat_ws('_', domain, phylum, organism), 
	  concat_ws('_', protfamily, protclass, protsubclass, protgroup), 
	  accno, 
	  seq
	) INTO v_return;

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.fasta(domain text, phylum text, organism text, protfamily text, protclass text, protsubclass text, protgroup text, accno text, seq text) OWNER TO dl;

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
-- Name: insert_hmm_result_row_sequence(integer, text, text, text); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION insert_hmm_result_row_sequence(v_hmm_result_row_id integer, v_seq_src text, v_accno text, v_name text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_return int;
      v_sequence_id int;

    BEGIN
      v_sequence_id := insert_sequence(v_seq_src, v_accno, v_name);

      INSERT INTO hmm_result_row_sequences(hmm_result_row_id, sequence_id)
        VALUES(v_hmm_result_row_id, v_sequence_id)
      ;

      SELECT currval('hmm_result_row_sequences_id_seq') INTO v_return;

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.insert_hmm_result_row_sequence(v_hmm_result_row_id integer, v_seq_src text, v_accno text, v_name text) OWNER TO dl;

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
-- Name: insert_sequence(text, text, text); Type: FUNCTION; Schema: public; Owner: dl
--

CREATE FUNCTION insert_sequence(v_seq_src text, v_accno text, v_name text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
      v_return int
    ;

    BEGIN
      v_return := insert_sequence(v_seq_src, NULL, NULL, v_accno, v_name);

      RETURN v_return;
    END;
  $$;


ALTER FUNCTION public.insert_sequence(v_seq_src text, v_accno text, v_name text) OWNER TO dl;

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

SET default_tablespace = '';

SET default_with_oids = false;

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


ALTER TABLE public.hmm_result_domains OWNER TO dl;

--
-- Name: align_length; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW align_length AS
    SELECT hmm_result_domains.hmm_result_row_id, min(hmm_result_domains.hmm_from) AS min_hmm_from, max(hmm_result_domains.hmm_to) AS max_hmm_to, ((max(hmm_result_domains.hmm_to) - min(hmm_result_domains.hmm_from)) + 1) AS length FROM hmm_result_domains GROUP BY hmm_result_domains.hmm_result_row_id;


ALTER TABLE public.align_length OWNER TO dl;

--
-- Name: align_lengths; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW align_lengths AS
    SELECT hmm_result_domains.hmm_result_row_id, min(hmm_result_domains.hmm_from) AS min_hmm_from, max(hmm_result_domains.hmm_to) AS max_hmm_to, ((max(hmm_result_domains.hmm_to) - min(hmm_result_domains.hmm_from)) + 1) AS length FROM hmm_result_domains GROUP BY hmm_result_domains.hmm_result_row_id;


ALTER TABLE public.align_lengths OWNER TO dl;

--
-- Name: all_the_proteins; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE all_the_proteins (
    ss_name text,
    ss_version text,
    executed timestamp without time zone,
    db text,
    accno text,
    hmm_profile_id integer,
    psuperfamily text,
    pfamily text,
    pclass text,
    psubclass text,
    pgroup text,
    pversion text,
    ncbi_taxon_id integer,
    tdomain text,
    tkingdom text,
    tphylum text,
    tclass text,
    torder text,
    tfamily text,
    tgenus text,
    tspecies text,
    tstrain text,
    trank text,
    sequence text
);


ALTER TABLE public.all_the_proteins OWNER TO dl;

--
-- Name: best_seq_score_per_parent; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE best_seq_score_per_parent (
    sequence_source_id integer,
    ss_source text,
    ss_name text,
    ss_version text,
    hmm_profile_id integer,
    hp_name text,
    hp_version text,
    hp_rank text,
    parent_id integer,
    sequence_id integer,
    seq_src text,
    db text,
    gi text,
    accno text,
    name text,
    sequence text,
    tname text,
    qname text,
    e_value double precision,
    score double precision,
    bias double precision,
    best_score boolean
);


ALTER TABLE public.best_seq_score_per_parent OWNER TO dl;

--
-- Name: biodatabase_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE biodatabase_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.biodatabase_pk_seq OWNER TO dl;

--
-- Name: biodatabase; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE biodatabase (
    biodatabase_id integer DEFAULT nextval('biodatabase_pk_seq'::regclass) NOT NULL,
    name character varying(128) NOT NULL,
    authority character varying(128),
    description text
);


ALTER TABLE public.biodatabase OWNER TO dl;

--
-- Name: bioentry_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE bioentry_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bioentry_pk_seq OWNER TO dl;

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


ALTER TABLE public.bioentry OWNER TO dl;

--
-- Name: bioentry_dbxref; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE bioentry_dbxref (
    bioentry_id integer NOT NULL,
    dbxref_id integer NOT NULL,
    rank integer
);


ALTER TABLE public.bioentry_dbxref OWNER TO dl;

--
-- Name: bioentry_path; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE bioentry_path (
    object_bioentry_id integer NOT NULL,
    subject_bioentry_id integer NOT NULL,
    term_id integer NOT NULL,
    distance integer
);


ALTER TABLE public.bioentry_path OWNER TO dl;

--
-- Name: bioentry_qualifier_value; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE bioentry_qualifier_value (
    bioentry_id integer NOT NULL,
    term_id integer NOT NULL,
    value text,
    rank integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.bioentry_qualifier_value OWNER TO dl;

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


ALTER TABLE public.bioentry_reference OWNER TO dl;

--
-- Name: bioentry_relationship_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE bioentry_relationship_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bioentry_relationship_pk_seq OWNER TO dl;

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


ALTER TABLE public.bioentry_relationship OWNER TO dl;

--
-- Name: dbxref_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE dbxref_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dbxref_pk_seq OWNER TO dl;

--
-- Name: dbxref; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE dbxref (
    dbxref_id integer DEFAULT nextval('dbxref_pk_seq'::regclass) NOT NULL,
    dbname character varying(40) NOT NULL,
    accession character varying(128) NOT NULL,
    version integer NOT NULL
);


ALTER TABLE public.dbxref OWNER TO dl;

--
-- Name: bioprojects; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW bioprojects AS
    SELECT bedbx.bioentry_id, dbx.dbname, dbx.accession, dbx.version FROM (bioentry_dbxref bedbx JOIN dbxref dbx ON (((bedbx.dbxref_id = dbx.dbxref_id) AND ((dbx.dbname)::text = 'BioProject'::text))));


ALTER TABLE public.bioprojects OWNER TO dl;

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


ALTER TABLE public.biosequence OWNER TO dl;

--
-- Name: classified_proteins; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE classified_proteins (
    seq_src text,
    db text,
    accno text,
    bioproject character varying(128),
    gene text,
    seq text,
    tdomain text,
    tkingdom text,
    tphylum text,
    tclass text,
    torder text,
    tfamily text,
    tgenus text,
    tspecies text,
    tstrain text,
    psuperfamily text,
    pfamily text,
    pclass text,
    psubclass text,
    pgroup text,
    profile_length integer,
    align_length integer,
    align_start integer,
    align_end integer,
    prop_matching double precision,
    ss_source text,
    ss_name text,
    ss_version text,
    e_value double precision,
    score double precision,
    fasta text
);


ALTER TABLE public.classified_proteins OWNER TO dl;

--
-- Name: comment_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE comment_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_pk_seq OWNER TO dl;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE comment (
    comment_id integer DEFAULT nextval('comment_pk_seq'::regclass) NOT NULL,
    bioentry_id integer NOT NULL,
    comment_text text NOT NULL,
    rank integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.comment OWNER TO dl;

--
-- Name: hmm_profiles; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE hmm_profiles (
    id integer NOT NULL,
    name text NOT NULL,
    version text NOT NULL,
    rank text,
    parent_id integer,
    length integer
);


ALTER TABLE public.hmm_profiles OWNER TO dl;

--
-- Name: hmm_result_row_sequences; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE hmm_result_row_sequences (
    id integer NOT NULL,
    hmm_result_row_id integer,
    sequence_id integer
);


ALTER TABLE public.hmm_result_row_sequences OWNER TO dl;

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
    dom_n_inc integer NOT NULL,
    best_score boolean
);


ALTER TABLE public.hmm_result_rows OWNER TO dl;

--
-- Name: hmm_results; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE hmm_results (
    id integer NOT NULL,
    hmm_profile_id integer,
    sequence_source_id integer,
    executed timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.hmm_results OWNER TO dl;

--
-- Name: sequence_sources; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE sequence_sources (
    id integer NOT NULL,
    source text NOT NULL,
    name text NOT NULL,
    version text NOT NULL
);


ALTER TABLE public.sequence_sources OWNER TO dl;

--
-- Name: latest_hmm_results; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW latest_hmm_results AS
    SELECT hr.id, hr.hmm_profile_id, hr.sequence_source_id, hr.executed, ss.source, ss.name, ss.version FROM (hmm_results hr JOIN sequence_sources ss ON ((hr.sequence_source_id = ss.id))) WHERE (ss.version = (SELECT max(sequence_sources.version) AS max FROM sequence_sources WHERE ((sequence_sources.source = ss.source) AND (sequence_sources.name = ss.name))));


ALTER TABLE public.latest_hmm_results OWNER TO dl;

--
-- Name: sequences; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE sequences (
    id integer NOT NULL,
    seq_src text NOT NULL,
    db text,
    gi text,
    accno text NOT NULL,
    name text NOT NULL,
    sequence text
);


ALTER TABLE public.sequences OWNER TO dl;

--
-- Name: seq_scores; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW seq_scores AS
    SELECT hr.sequence_source_id, ss.source AS ss_source, ss.name AS ss_name, ss.version AS ss_version, hr.hmm_profile_id, hp.name AS hp_name, hp.version AS hp_version, hp.rank AS hp_rank, hp.parent_id, hrrs.sequence_id, s.seq_src, s.db, s.gi, s.accno, s.name, s.sequence, hrr.tname, hrr.qname, hrr.e_value, hrr.score, hrr.bias, hrr.best_score FROM (((((sequence_sources ss JOIN hmm_results hr ON ((ss.id = hr.sequence_source_id))) JOIN hmm_profiles hp ON ((hr.hmm_profile_id = hp.id))) JOIN hmm_result_rows hrr ON ((hr.id = hrr.hmm_result_id))) JOIN hmm_result_row_sequences hrrs ON ((hrr.id = hrrs.hmm_result_row_id))) JOIN sequences s ON ((hrrs.sequence_id = s.id)));


ALTER TABLE public.seq_scores OWNER TO dl;

--
-- Name: cscores; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW cscores AS
    SELECT cssc.sequence_source_id, cssc.ss_version, cssc.db, cssc.gi, cssc.accno, cssc.name, cssc.sequence, cssc.hp_name AS cname, cssc.e_value AS ce_value, cssc.score AS cscore, cssc.best_score AS cbest_score, scssc.hp_name AS scname, scssc.e_value AS sce_value, scssc.score AS scscore, scssc.best_score AS scbest_score, gssc.hp_name AS gname, gssc.e_value AS ge_value, gssc.score AS gscore, gssc.best_score AS gbest_score, CASE WHEN ((cssc.score < scssc.score) AND (scssc.score < gssc.score)) THEN 'class < subclass < group'::text WHEN ((cssc.score > scssc.score) AND (scssc.score > gssc.score)) THEN 'class > subclass > group'::text WHEN ((cssc.score > scssc.score) AND (scssc.score < gssc.score)) THEN 'class > subclass < group'::text WHEN ((cssc.score < scssc.score) AND (scssc.score > gssc.score)) THEN 'class < subclass > group'::text ELSE '--'::text END AS score_pattern, CASE WHEN ((cssc.e_value < scssc.e_value) AND (scssc.e_value < gssc.e_value)) THEN 'class < subclass < group'::text WHEN ((cssc.e_value > scssc.e_value) AND (scssc.e_value > gssc.e_value)) THEN 'class > subclass > group'::text WHEN ((cssc.e_value > scssc.e_value) AND (scssc.e_value < gssc.e_value)) THEN 'class > subclass < group'::text WHEN ((cssc.e_value < scssc.e_value) AND (scssc.e_value > gssc.e_value)) THEN 'class < subclass > group'::text ELSE '--'::text END AS e_value_pattern FROM (((latest_hmm_results lhr JOIN seq_scores cssc ON ((((lhr.sequence_source_id = cssc.sequence_source_id) AND (lhr.hmm_profile_id = cssc.hmm_profile_id)) AND (cssc.hp_rank = 'class'::text)))) LEFT JOIN best_seq_score_per_parent scssc ON (((((lhr.sequence_source_id = scssc.sequence_source_id) AND (cssc.sequence_id = scssc.sequence_id)) AND (cssc.hmm_profile_id = scssc.parent_id)) AND (scssc.hp_rank = 'subclass'::text)))) LEFT JOIN best_seq_score_per_parent gssc ON (((((lhr.sequence_source_id = gssc.sequence_source_id) AND (cssc.sequence_id = gssc.sequence_id)) AND (scssc.hmm_profile_id = gssc.parent_id)) AND (gssc.hp_rank = 'group'::text))));


ALTER TABLE public.cscores OWNER TO dl;

--
-- Name: dbxref_qualifier_value; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE dbxref_qualifier_value (
    dbxref_id integer NOT NULL,
    term_id integer NOT NULL,
    rank integer DEFAULT 0 NOT NULL,
    value text
);


ALTER TABLE public.dbxref_qualifier_value OWNER TO dl;

--
-- Name: domain_presence; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE domain_presence (
    seq_src text,
    db text,
    accno text,
    domain text,
    profile_length integer,
    align_length integer,
    align_from integer,
    align_to integer,
    prop_matching double precision,
    score double precision,
    ss_source text,
    ss_name text,
    ss_version text
);


ALTER TABLE public.domain_presence OWNER TO dl;

--
-- Name: fscores; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW fscores AS
    SELECT fssc.sequence_source_id, fssc.ss_version, fssc.db, fssc.gi, fssc.accno, fssc.name, fssc.sequence, fssc.hp_name AS fname, fssc.e_value AS fe_value, fssc.score AS fscore, fssc.best_score AS fbest_score, cssc.hp_name AS cname, cssc.e_value AS ce_value, cssc.score AS cscore, cssc.best_score AS cbest_score, scssc.hp_name AS scname, scssc.e_value AS sce_value, scssc.score AS scscore, scssc.best_score AS scbest_score, CASE WHEN ((fssc.score < cssc.score) AND (cssc.score < scssc.score)) THEN 'family < class < subclass'::text WHEN ((fssc.score > cssc.score) AND (cssc.score > scssc.score)) THEN 'family > class > subclass'::text WHEN ((fssc.score > cssc.score) AND (cssc.score < scssc.score)) THEN 'family > class < subclass'::text WHEN ((fssc.score < cssc.score) AND (cssc.score > scssc.score)) THEN 'family < class > subclass'::text ELSE '--'::text END AS score_pattern, CASE WHEN ((fssc.e_value < cssc.e_value) AND (cssc.e_value < scssc.e_value)) THEN 'family < class < subclass'::text WHEN ((fssc.e_value > cssc.e_value) AND (cssc.e_value > scssc.e_value)) THEN 'family > class > subclass'::text WHEN ((fssc.e_value > cssc.e_value) AND (cssc.e_value < scssc.e_value)) THEN 'family > class < subclass'::text WHEN ((fssc.e_value < cssc.e_value) AND (cssc.e_value > scssc.e_value)) THEN 'family < class > subclass'::text ELSE '--'::text END AS e_value_pattern FROM (((latest_hmm_results lhr JOIN seq_scores fssc ON ((((lhr.sequence_source_id = fssc.sequence_source_id) AND (lhr.hmm_profile_id = fssc.hmm_profile_id)) AND (fssc.hp_rank = 'family'::text)))) LEFT JOIN best_seq_score_per_parent cssc ON (((((lhr.sequence_source_id = cssc.sequence_source_id) AND (fssc.sequence_id = cssc.sequence_id)) AND (fssc.hmm_profile_id = cssc.parent_id)) AND (cssc.hp_rank = 'class'::text)))) LEFT JOIN best_seq_score_per_parent scssc ON (((((lhr.sequence_source_id = scssc.sequence_source_id) AND (fssc.sequence_id = scssc.sequence_id)) AND (cssc.hmm_profile_id = scssc.parent_id)) AND (scssc.hp_rank = 'subclass'::text))));


ALTER TABLE public.fscores OWNER TO dl;

--
-- Name: hmm_profile_hierarchies; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE hmm_profile_hierarchies (
    hmm_profile_id integer NOT NULL,
    superfamily text,
    family text,
    class text,
    subclass text,
    "group" text,
    version text
);


ALTER TABLE public.hmm_profile_hierarchies OWNER TO dl;

--
-- Name: hmm_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE hmm_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hmm_profiles_id_seq OWNER TO dl;

--
-- Name: hmm_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE hmm_profiles_id_seq OWNED BY hmm_profiles.id;


--
-- Name: hmm_profiles_with_results; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW hmm_profiles_with_results AS
    SELECT hr.hmm_profile_id, hp.name AS hmm_profile_name, hp.rank, hp.length, s.id AS sequence_id, s.seq_src, s.db, s.gi, s.accno, s.name AS seq_name, s.sequence, hr.id AS hmm_result_id, hrr.id AS hmm_result_row_id, hrr.e_value, hrr.score, hrr.best_score FROM ((((hmm_profiles hp JOIN hmm_results hr ON ((hp.id = hr.hmm_profile_id))) JOIN hmm_result_rows hrr ON ((hr.id = hrr.hmm_result_id))) JOIN hmm_result_row_sequences hrrs ON ((hrr.id = hrrs.hmm_result_row_id))) JOIN sequences s ON ((hrrs.sequence_id = s.id)));


ALTER TABLE public.hmm_profiles_with_results OWNER TO dl;

--
-- Name: hmm_result_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE hmm_result_domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hmm_result_domains_id_seq OWNER TO dl;

--
-- Name: hmm_result_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE hmm_result_domains_id_seq OWNED BY hmm_result_domains.id;


--
-- Name: hmm_result_row_sequences_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE hmm_result_row_sequences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hmm_result_row_sequences_id_seq OWNER TO dl;

--
-- Name: hmm_result_row_sequences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE hmm_result_row_sequences_id_seq OWNED BY hmm_result_row_sequences.id;


--
-- Name: hmm_result_rows_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE hmm_result_rows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hmm_result_rows_id_seq OWNER TO dl;

--
-- Name: hmm_result_rows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE hmm_result_rows_id_seq OWNED BY hmm_result_rows.id;


--
-- Name: hmm_results_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE hmm_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hmm_results_id_seq OWNER TO dl;

--
-- Name: hmm_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE hmm_results_id_seq OWNED BY hmm_results.id;


--
-- Name: latest_hmm_profiles_with_results; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW latest_hmm_profiles_with_results AS
    SELECT hr.hmm_profile_id, hp.name AS hmm_profile_name, hp.rank, hp.length, s.id AS sequence_id, s.seq_src, s.db, s.gi, s.accno, s.name AS seq_name, s.sequence, hr.id AS hmm_result_id, hrr.id AS hmm_result_row_id, hrr.e_value, hrr.score, hrr.best_score FROM ((((hmm_profiles hp JOIN latest_hmm_results hr ON ((hp.id = hr.hmm_profile_id))) JOIN hmm_result_rows hrr ON ((hr.id = hrr.hmm_result_id))) JOIN hmm_result_row_sequences hrrs ON ((hrr.id = hrrs.hmm_result_row_id))) JOIN sequences s ON ((hrrs.sequence_id = s.id)));


ALTER TABLE public.latest_hmm_profiles_with_results OWNER TO dl;

--
-- Name: location_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE location_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.location_pk_seq OWNER TO dl;

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


ALTER TABLE public.location OWNER TO dl;

--
-- Name: location_qualifier_value; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE location_qualifier_value (
    location_id integer NOT NULL,
    term_id integer NOT NULL,
    value character varying(255) NOT NULL,
    int_value integer
);


ALTER TABLE public.location_qualifier_value OWNER TO dl;

--
-- Name: myco_hits; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE myco_hits (
    accno text
);


ALTER TABLE public.myco_hits OWNER TO dl;

--
-- Name: ncbi_taxon_hierarchies; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE ncbi_taxon_hierarchies (
    ncbi_taxon_id integer NOT NULL,
    domain text,
    kingdom text,
    phylum text,
    class text,
    "order" text,
    family text,
    genus text,
    species text,
    strain text,
    rank text
);


ALTER TABLE public.ncbi_taxon_hierarchies OWNER TO dl;

--
-- Name: ontology_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE ontology_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ontology_pk_seq OWNER TO dl;

--
-- Name: ontology; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE ontology (
    ontology_id integer DEFAULT nextval('ontology_pk_seq'::regclass) NOT NULL,
    name character varying(32) NOT NULL,
    definition text
);


ALTER TABLE public.ontology OWNER TO dl;

--
-- Name: taxon_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE taxon_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taxon_pk_seq OWNER TO dl;

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


ALTER TABLE public.taxon OWNER TO dl;

--
-- Name: protein_fastas; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW protein_fastas AS
    SELECT fasta(t.domain, t.phylum, t.strain, NULL::text, hp.class, hp.subclass, NULL::text, pg_catalog.concat_ws('_'::text, s.db, s.accno), bs.seq) AS fasta, t.domain AS tdomain, t.kingdom AS tkingdom, t.phylum AS tphylum, t.class AS tclass, t.family AS tfamily, t.genus AS tgenus, t.species AS tspecies, t.strain AS tstrain, hp.superfamily AS psuperfamily, hp.family AS pfamily, hp.class AS pclass, hp.subclass AS psubclass, hp."group" AS pgroup, bss.ss_source, bss.ss_name, bss.ss_version, s.accno, bss.e_value, bss.score FROM (((((((((ncbi_taxon_hierarchies t JOIN taxon tt ON ((t.ncbi_taxon_id = tt.ncbi_taxon_id))) JOIN bioentry be ON ((tt.taxon_id = be.taxon_id))) JOIN biosequence bs ON ((be.bioentry_id = bs.bioentry_id))) JOIN sequences s ON ((pg_catalog.concat_ws('.'::text, be.accession, be.version) = s.accno))) JOIN hmm_result_row_sequences hrrs ON ((s.id = hrrs.sequence_id))) JOIN hmm_result_rows hrr ON ((hrrs.hmm_result_row_id = hrr.id))) JOIN hmm_results hr ON ((hrr.hmm_result_id = hr.id))) JOIN hmm_profile_hierarchies hp ON ((hr.hmm_profile_id = hp.hmm_profile_id))) JOIN best_seq_score_per_parent bss ON ((((hr.sequence_source_id = bss.sequence_source_id) AND (hp.hmm_profile_id = bss.hmm_profile_id)) AND (s.id = bss.sequence_id))));


ALTER TABLE public.protein_fastas OWNER TO dl;

--
-- Name: reference_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE reference_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reference_pk_seq OWNER TO dl;

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


ALTER TABLE public.reference OWNER TO dl;

--
-- Name: seqfeature_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE seqfeature_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqfeature_pk_seq OWNER TO dl;

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


ALTER TABLE public.seqfeature OWNER TO dl;

--
-- Name: seqfeature_qualifier_value; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE seqfeature_qualifier_value (
    seqfeature_id integer NOT NULL,
    term_id integer NOT NULL,
    rank integer DEFAULT 0 NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.seqfeature_qualifier_value OWNER TO dl;

--
-- Name: term_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE term_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_pk_seq OWNER TO dl;

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


ALTER TABLE public.term OWNER TO dl;

--
-- Name: seqfeature_comments; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW seqfeature_comments AS
    SELECT be.bioentry_id, be.accession, t.name AS seqfeature_name, sfqt.name AS comment_name, sfq.value AS comment_value FROM (((((bioentry be JOIN seqfeature sf ON ((be.bioentry_id = sf.bioentry_id))) JOIN location l ON ((sf.seqfeature_id = l.seqfeature_id))) JOIN term t ON ((sf.type_term_id = t.term_id))) JOIN seqfeature_qualifier_value sfq ON ((sf.seqfeature_id = sfq.seqfeature_id))) JOIN term sfqt ON ((sfq.term_id = sfqt.term_id)));


ALTER TABLE public.seqfeature_comments OWNER TO dl;

--
-- Name: seqfeature_dbxref; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE seqfeature_dbxref (
    seqfeature_id integer NOT NULL,
    dbxref_id integer NOT NULL,
    rank integer
);


ALTER TABLE public.seqfeature_dbxref OWNER TO dl;

--
-- Name: seqfeature_path; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE seqfeature_path (
    object_seqfeature_id integer NOT NULL,
    subject_seqfeature_id integer NOT NULL,
    term_id integer NOT NULL,
    distance integer
);


ALTER TABLE public.seqfeature_path OWNER TO dl;

--
-- Name: seqfeature_relationship_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE seqfeature_relationship_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seqfeature_relationship_pk_seq OWNER TO dl;

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


ALTER TABLE public.seqfeature_relationship OWNER TO dl;

--
-- Name: sequence_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE sequence_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sequence_sources_id_seq OWNER TO dl;

--
-- Name: sequence_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE sequence_sources_id_seq OWNED BY sequence_sources.id;


--
-- Name: sequences_id_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE sequences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sequences_id_seq OWNER TO dl;

--
-- Name: sequences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dl
--

ALTER SEQUENCE sequences_id_seq OWNED BY sequences.id;


--
-- Name: taxa_to_insert; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE taxa_to_insert (
    taxon_id integer
);


ALTER TABLE public.taxa_to_insert OWNER TO dl;

--
-- Name: taxon_name; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE taxon_name (
    taxon_id integer NOT NULL,
    name character varying(255) NOT NULL,
    name_class character varying(32) NOT NULL
);


ALTER TABLE public.taxon_name OWNER TO dl;

--
-- Name: taxon_with_scientific_name; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW taxon_with_scientific_name AS
    SELECT t.taxon_id, t.ncbi_taxon_id, t.parent_taxon_id, t.node_rank, t.genetic_code, t.mito_genetic_code, t.left_value, t.right_value, tn.name FROM (taxon t JOIN taxon_name tn ON (((t.taxon_id = tn.taxon_id) AND ((tn.name_class)::text = 'scientific name'::text))));


ALTER TABLE public.taxon_with_scientific_name OWNER TO dl;

--
-- Name: taxon_with_scientific_names; Type: VIEW; Schema: public; Owner: dl
--

CREATE VIEW taxon_with_scientific_names AS
    SELECT t.taxon_id, t.ncbi_taxon_id, t.parent_taxon_id, t.node_rank, t.genetic_code, t.mito_genetic_code, t.left_value, t.right_value, tn.name FROM (taxon t JOIN taxon_name tn ON (((t.taxon_id = tn.taxon_id) AND ((tn.name_class)::text = 'scientific name'::text))));


ALTER TABLE public.taxon_with_scientific_names OWNER TO dl;

--
-- Name: term_dbxref; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE term_dbxref (
    term_id integer NOT NULL,
    dbxref_id integer NOT NULL,
    rank integer
);


ALTER TABLE public.term_dbxref OWNER TO dl;

--
-- Name: term_path_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE term_path_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_path_pk_seq OWNER TO dl;

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


ALTER TABLE public.term_path OWNER TO dl;

--
-- Name: term_relationship_pk_seq; Type: SEQUENCE; Schema: public; Owner: dl
--

CREATE SEQUENCE term_relationship_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.term_relationship_pk_seq OWNER TO dl;

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


ALTER TABLE public.term_relationship OWNER TO dl;

--
-- Name: term_relationship_term; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE term_relationship_term (
    term_relationship_id integer NOT NULL,
    term_id integer NOT NULL
);


ALTER TABLE public.term_relationship_term OWNER TO dl;

--
-- Name: term_synonym; Type: TABLE; Schema: public; Owner: dl; Tablespace: 
--

CREATE TABLE term_synonym (
    synonym character varying(255) NOT NULL,
    term_id integer NOT NULL
);


ALTER TABLE public.term_synonym OWNER TO dl;

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

ALTER TABLE ONLY sequence_sources ALTER COLUMN id SET DEFAULT nextval('sequence_sources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: dl
--

ALTER TABLE ONLY sequences ALTER COLUMN id SET DEFAULT nextval('sequences_id_seq'::regclass);


