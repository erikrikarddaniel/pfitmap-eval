CREATE OR REPLACE FUNCTION 
  insert_sequence_source(v_source text, v_name text, v_version text) RETURNS integer
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
  $$
  LANGUAGE plpgsql
;
