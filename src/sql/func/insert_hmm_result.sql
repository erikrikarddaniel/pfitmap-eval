CREATE OR REPLACE FUNCTION 
  insert_hmm_result(v_hp_name text, v_ss_source text, v_ss_name text, v_ss_version text) RETURNS integer
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
  $$
  LANGUAGE plpgsql
;
