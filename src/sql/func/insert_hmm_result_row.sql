CREATE OR REPLACE FUNCTION 
  insert_hmm_result_row(
    v_hmm_result_id int,
    v_tname text, v_qname text, v_e_value float, v_score float, v_bias float,
    v_dom_n_exp float, v_dom_n_reg int, v_dom_n_clu int, v_dom_n_ov int, 
    v_dom_n_env int, v_dom_n_dom int, v_dom_n_rep int, v_dom_n_inc int
  ) RETURNS integer
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
  $$
  LANGUAGE plpgsql
;
