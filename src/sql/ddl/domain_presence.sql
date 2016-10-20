/**
 * Creates the domain_presence table.
 *
 * Author: daniel.lundin@dbb.su.se
 */

CREATE TABLE domain_presence (
  seq_src		TEXT	NOT NULL,
  db			TEXT	NOT NULL,
  accno			TEXT	NOT NULL,
  domain		TEXT	NOT NULL,
  profile_length	TEXT	NOT NULL,
  profile_from		INT	NOT NULL,
  profile_to		INT	NOT NULL,
  align_from		INT	NOT NULL,
  align_to		INT	NOT NULL,
  align_length		INT	NOT NULL,
  prop_matching		FLOAT	NOT NULL,
  score			FLOAT	NOT NULL,
  ss_source		TEXT	NOT NULL,
  ss_name		TEXT	NOT NULL,
  ss_version		TEXT	NOT NULL
);

ALTER TABLE domain_presence
  ADD PRIMARY KEY (domain, ss_source, ss_name, ss_version, seq_src, accno)
;
