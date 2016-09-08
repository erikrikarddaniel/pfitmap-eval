/**
 * Updates the db column in sequences to some reasonable values.
 *
 * Replacement for the db field that was formerly present in NCBI NR files.
 *
 * Information taken from here:
 * 
 *   http://www.ncbi.nlm.nih.gov/Sequin/acc.html
 *
 * matricaria.suaveolens@gmail.com
 */

-- RefSeq accessions have an '_' as the third character
UPDATE sequences
  SET db = 'ref'
  WHERE db IS NULL AND accno ~ '^.._'
;

-- PDB accessions start with 'pdb' (and contains the chain!)
UPDATE sequences
  SET db = 'pdb'
  WHERE db IS NULL AND accno ~ '^pdb'
;
-- They also have a different format in the NR file than in GenBank
UPDATE sequences 
  SET accno = replace(substring(accno, 5), '|', '_') || '.0' 
  WHERE accno ~ '^pdb'
;

-- GenBank have a bunch of prefixes
UPDATE sequences
  SET db = 'gb'
  WHERE db IS NULL AND accno ~ '^[ADEKOJMNP][A-Z][A-Z]'
;

-- So does DDBJ
UPDATE sequences
  SET db = 'dbj'
  WHERE db IS NULL AND accno ~ '^[BFGIL][A-Z][A-Z]'
;

-- SwissProt/Uniprot has  different patterns for six and ten character 
-- accessions respectively
UPDATE sequences
  SET db = 'sp'
  WHERE db IS NULL AND accno ~ '^[A-NR-Z][0-9][A-Z][A-Z0-9][A-Z0-9][0-9][A-Z][A-Z0-9][A-Z0-9][0-9]\.[0-9]*$'
;
UPDATE sequences
  SET db = 'sp'
  WHERE db IS NULL AND accno ~ '^[O,P,Q][0-9][A-Z0-9][A-Z0-9][0-9]\.[0-9]*$'
;
UPDATE sequences
  SET db = 'sp'
  WHERE db IS NULL AND accno ~ '^[A-NR-Z][0-9][A-Z][A-Z0-9][A-Z0-9][0-9]\.[0-9]*$'
;
