/**
 * Fetches all full length proteins annotated as belonging to a superfamily
 * from the latest hmmer search.
 *
 * All details are fetched: taxonomy hierarchy, protein classification 
 * hierarchy, accession numbers. The table retrieved is suitable for import
 * into a pfitmap-2 database.
 *
 * matricaria.suaveolens@gmail.com
 */

-- For the moment, this query creates a table. This will change once I have
-- time for the pfitmap-2 work required.
CREATE TABLE all_the_proteins AS
SELECT DISTINCT
  ss.name AS ss_name,
  ss.version AS ss_version,
  hr.executed AS executed,
  s.db AS db,
  s.accno AS accno,
  hph.hmm_profile_id,
  hph.superfamily AS psuperfamily,
  hph.family AS pfamily,
  hph."class" AS pclass,
  hph.subclass AS psubclass,
  hph.group AS pgroup,
  hph.version AS pversion,
  th.ncbi_taxon_id,
  th.domain AS tdomain,
  th.kingdom AS tkingdom,
  th.phylum AS tphylum,
  th."class" AS tclass,
  th.order AS torder,
  th.family AS tfamily,
  th.genus AS tgenus,
  th.species AS tspecies,
  th.strain AS tstrain,
  th.rank AS trank,
  bs.seq AS sequence
FROM
  hmm_profile_hierarchies hph JOIN
  hmm_profiles hp ON hph.hmm_profile_id = hp.id JOIN
  hmm_results hr ON hph.hmm_profile_id = hr.hmm_profile_id JOIN
  hmm_result_rows hrr ON hr.id = hrr.hmm_result_id JOIN
  align_lengths al ON hrr.id = al.hmm_result_row_id JOIN
  sequence_sources ss ON hr.sequence_source_id = ss.id JOIN
  hmm_result_row_sequences hrrs ON hrr.id = hrrs.hmm_result_row_id JOIN
  sequences s ON hrrs.sequence_id = s.id JOIN
  bioentry be ON s.accno = concat_ws('.', be.accession, be.version) JOIN
  biosequence bs ON be.bioentry_id = bs.bioentry_id JOIN
  taxon t ON be.taxon_id = t.taxon_id JOIN
  ncbi_taxon_hierarchies th ON t.ncbi_taxon_id = th.ncbi_taxon_id
WHERE
  hph.superfamily IS NOT NULL AND
  hrr.best_score = TRUE AND
  al.length > 0.9 * hp.length
;
