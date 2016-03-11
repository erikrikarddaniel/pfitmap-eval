CREATE OR REPLACE FUNCTION 
  insert_sequence(
    v_seq_src text, v_db text, v_gi text,
    v_accno text, v_name text
  ) RETURNS integer
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
  $$
  LANGUAGE plpgsql
;

CREATE OR REPLACE FUNCTION 
  insert_sequence(
    v_seq_src text, v_db text, v_gi text,
    v_accno text, v_name text, v_sequence text
  ) RETURNS integer
  AS $$
    DECLARE
      v_return int
    ;

    BEGIN
      v_return := insert_sequence(v_seq_src, v_db, v_gi, v_accno, v_name);

      UPDATE sequences SET sequence = v_sequence WHERE id = v_return;

      RETURN v_return;
    END;
  $$
  LANGUAGE plpgsql
;
