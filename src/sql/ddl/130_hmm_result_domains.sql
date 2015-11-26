CREATE TABLE hmm_result_domains (
  id			serial			PRIMARY KEY,
  hmm_result_row_id	integer			REFERENCES hmm_result_rows(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  tlen			integer			NOT NULL,
  qlen			integer			NOT NULL,
  i			integer			NOT NULL,
  n			integer			NOT NULL,
  c_e_value		double precision	NOT NULL,
  i_e_value		double precision	NOT NULL,
  score			double precision	NOT NULL,
  bias			double precision	NOT NULL,
  hmm_from		integer			NOT NULL,
  hmm_to		integer			NOT NULL,
  ali_from		integer			NOT NULL,
  ali_to		integer			NOT NULL,
  env_from		integer			NOT NULL,
  env_to		integer			NOT NULL,
  acc			double precision	NOT NULL
);

CREATE UNIQUE INDEX hmm_result_domains_i00 ON hmm_result_domains(hmm_result_row_id, i);

ALTER TABLE hmm_result_domains
  ADD qali		text,
  ADD cali		text,
  ADD tali		text,
  ADD sali		text
;
