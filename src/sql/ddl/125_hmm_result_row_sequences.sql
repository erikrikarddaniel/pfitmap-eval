CREATE TABLE hmm_result_row_sequences (
  id			serial			PRIMARY KEY,
  hmm_result_row_id	integer			REFERENCES hmm_result_rows(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  sequence_id		integer			REFERENCES sequences(id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE UNIQUE INDEX hmm_result_row_sequences_hmm_result_rows ON hmm_result_row_sequences(hmm_result_row_id, sequence_id);
CREATE UNIQUE INDEX hmm_result_row_sequences_sequences ON hmm_result_row_sequences(sequence_id, hmm_result_row_id);
