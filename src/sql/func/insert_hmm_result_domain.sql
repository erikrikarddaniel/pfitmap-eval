CREATE OR REPLACE FUNCTION 
  insert_hmm_result_domain(
    v_hmm_result_row_id int,
    v_tlen int, v_qlen int, v_i int, v_n int,
    v_c_e_value float, v_i_e_value float,
    v_score float, v_bias float,
    v_hmm_from int, v_hmm_to int,
    v_ali_from int, v_ali_to int,
    v_env_from int, v_env_to int,
    v_acc float
  ) RETURNS integer
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
  $$
  LANGUAGE plpgsql
;
