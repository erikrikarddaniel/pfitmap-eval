CREATE TABLE seqnames (
  id			serial			PRIMARY KEY,
  hmm_result_row_id	integer			REFERENCES hmm_result_rows(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  seq_src		text			NOT NULL,
  gi			text			NOT NULL,
  accno			text			NOT NULL,
  accno_version		text			,
  name			text			NOT NULL
);

CREATE INDEX seqnames_hmm_result_rows ON seqnames(hmm_result_row_id);
