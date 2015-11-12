CREATE TABLE sequence_sources (
  id		serial		PRIMARY KEY,
  source	text		NOT NULL,
  name		text		NOT NULL,
  version	text		NOT NULL,
  UNIQUE(source, name, version)
);
