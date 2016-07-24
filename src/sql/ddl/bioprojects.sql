CREATE OR REPLACE VIEW bioprojects AS
  SELECT
    bedbx.bioentry_id,
    dbx.dbname,
    dbx.accession,
    dbx.version
  FROM
    bioentry_dbxref bedbx JOIN
    dbxref dbx ON bedbx.dbxref_id = dbx.dbxref_id AND dbx.dbname = 'BioProject'
;
