CREATE TABLE hmm_profiles (
  id		integer		PRIMARY KEY,
  name		text		NOT NULL,
  version	text		NOT NULL,
  rank		text		NOT NULL,
  parent_id	integer		REFERENCES hmm_profiles (id),
  UNIQUE(name, version)
);
