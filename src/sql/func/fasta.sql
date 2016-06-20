CREATE OR REPLACE FUNCTION
  fasta(
    name		text,
    seq			text
  ) RETURNS text
  AS $$
    DECLARE
      v_return		text;

    BEGIN
      v_return := '>' || regexp_replace(replace(name, ' ', '_'), '[-:|.]', '', 'g') || E'\n' || seq;

      RETURN v_return;
    END;
  $$
  LANGUAGE plpgsql
;
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
