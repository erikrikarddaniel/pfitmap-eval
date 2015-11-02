CREATE TABLE hmm_results (
  id			integer		PRIMARY KEY,
  hmm_profile		integer		REFERENCES hmm_profiles (id),
  sequence_source	integer		REFERENCES sequence_sources (id),
  executed		timestamp	NOT NULL
)
