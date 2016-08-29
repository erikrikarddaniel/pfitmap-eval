CREATE TABLE sequences (
  id			serial			PRIMARY KEY,
  seq_src		text			NOT NULL,
  db			text			NOT NULL,
  gi			text			,
  accno			text			NOT NULL,
  name			text			NOT NULL,
  sequence		text
);

CREATE UNIQUE INDEX sequences_i00 ON sequences(seq_src, accno);
CREATE INDEX sequences_i01 ON sequences(accno);

-- NCBI changed its format, and there is no db field any more
ALTER TABLE sequences
  ALTER COLUMN db DROP NOT NULL
;
