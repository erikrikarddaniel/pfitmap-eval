/**
 * fasta.sql
 *
 * Defines functions to return sequences in fasta format.
 *
 * erik.rikard.daniel@gmail.com
 */

-- The simplest version: name and sequence as text.
CREATE OR REPLACE FUNCTION
  fasta(
    name		text,
    seq			text
  ) RETURNS text
  AS $$
    DECLARE
      v_return		text;

    BEGIN
      v_return := '>' || regexp_replace(regexp_replace(replace(replace(replace(name, '''', ''), '[', ''), ']', ''), '[-:|.()]', '', 'g'), '  *', '_', 'g') || E'\n' || seq;

      RETURN v_return;
    END;
  $$
  LANGUAGE plpgsql
;

-- Organism, protein name and accession number plus sequence. Calls the above
-- for the actual formatting.
CREATE OR REPLACE FUNCTION
  fasta(
    org_name		text,
    prot_name		text,
    accno		text,
    seq			text
  ) RETURNS text
  AS $$
    DECLARE
      v_return		text;

    BEGIN
      SELECT fasta(concat_ws('_', org_name, prot_name, 'accno', accno), seq) INTO v_return;

      RETURN v_return;
    END;
  $$
  LANGUAGE plpgsql
;

-- A lot of parameters which are boiled down to three plus sequence which are
-- used to call the above function.
CREATE OR REPLACE FUNCTION
  fasta(
    domain		text,
    phylum		text,
    organism		text,
    protfamily		text,
    protclass		text,
    protsubclass	text,
    protgroup		text,
    accno		text,
    seq			text
  ) RETURNS text
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
  $$
  LANGUAGE plpgsql
;
