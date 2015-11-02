CREATE TABLE sequence_sources (
  id		integer		PRIMARY KEY,
  source	text		NOT NULL,
  name		text		NOT NULL,
  version	text		NOT NULL,
  UNIQUE(source, name, version)
);
