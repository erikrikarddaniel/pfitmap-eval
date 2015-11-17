CREATE TABLE hmm_result_rows (
  id		serial			PRIMARY KEY,
  hmm_result_id	integer			REFERENCES hmm_results(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  e_value	double precision	NOT NULL,
  score		double precision	NOT NULL,
  bias		double precision	NOT NULL,
  dom_n_exp	double precision	NOT NULL,
  dom_n_reg	integer			NOT NULL,
  dom_n_clu	integer			NOT NULL,
  dom_n_ov	integer			NOT NULL,
  dom_n_env	integer			NOT NULL,
  dom_n_dom	integer			NOT NULL,
  dom_n_rep	integer			NOT NULL,
  dom_n_inc	integer			NOT NULL
);

CREATE INDEX hmm_result_rows_hmm_results ON hmm_result_rows(hmm_result_id);
