CREATE TABLE hmm_profiles (
  id		serial		PRIMARY KEY,
  name		text		NOT NULL,
  version	text		NOT NULL,
  rank		text		NOT NULL,
  parent_id	integer		REFERENCES hmm_profiles (id),
  UNIQUE(name, version)
);

CREATE INDEX hmm_profiles_parent_id ON hmm_profiles(parent_id);

ALTER TABLE hmm_profiles
  ALTER COLUMN rank DROP NOT NULL
;

ALTER TABLE hmm_profiles
  ADD length	integer
;
