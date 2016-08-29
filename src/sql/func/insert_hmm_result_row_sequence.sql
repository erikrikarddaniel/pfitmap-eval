-- Current version since NCBI's change of file format, late August 2016
CREATE OR REPLACE FUNCTION
  insert_hmm_result_row_sequence(
    v_hmm_result_row_id integer,
    v_seq_src text, v_accno text, v_name text
  ) RETURNS integer
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
  $$
  LANGUAGE plpgsql
;

-- Old main function, with db field.
CREATE OR REPLACE FUNCTION
  insert_hmm_result_row_sequence(
    v_hmm_result_row_id integer,
    v_seq_src text, v_db text, v_gi text,
    v_accno text, v_name text
  ) RETURNS integer
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
  $$
  LANGUAGE plpgsql
;
