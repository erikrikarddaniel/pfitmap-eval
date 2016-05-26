CREATE TABLE ncbi_taxon_hierarchies (
  ncbi_taxon_id		integer		PRIMARY KEY,
  domain		text		NULL,
  kingdom		text		NULL,
  phylum		text		NULL,
  class			text		NULL,
  "order"		text		NULL,
  family		text		NULL,
  genus			text		NULL,
  species		text		NULL,
  strain		text		NULL
);
