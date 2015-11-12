CREATE TABLE hmm_results (
  id			serial		PRIMARY KEY,
  hmm_profile_id	integer		REFERENCES hmm_profiles (id)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  sequence_source_id	integer		REFERENCES sequence_sources (id),
  executed		timestamp	NOT NULL
);

CREATE INDEX hmm_results_hmm_profile_id ON hmm_results(hmm_profile_id);

CREATE INDEX hmm_results_sequence_source_id ON hmm_results(sequence_source_id);
