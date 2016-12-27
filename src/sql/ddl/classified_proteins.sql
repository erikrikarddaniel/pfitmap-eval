CREATE TABLE classified_proteins (
  seq_src         text, 
  db              text, 
  accno           text, 
  bioproject      character varying(128), 
  gene            text, 
  seq             text, 
  tdomain         text, 
  tkingdom        text, 
  tphylum         text, 
  tclass          text, 
  torder          text, 
  tfamily         text, 
  tgenus          text, 
  tspecies        text, 
  tstrain         text, 
  psuperfamily    text, 
  pfamily         text, 
  pclass          text, 
  psubclass       text, 
  pgroup          text, 
  profile_length  integer, 
  align_length    integer, 
  align_start     integer, 
  align_end       integer, 
  prop_matching   double precision, 
  ss_source       text, 
  ss_name         text, 
  ss_version      text, 
  e_value         double precision, 
  score           double precision, 
  fasta           text, 
  profile_version text
);

ALTER TABLE classified_proteins
  ADD ncbi_taxon_id	int
;
