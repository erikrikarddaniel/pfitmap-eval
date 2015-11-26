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
