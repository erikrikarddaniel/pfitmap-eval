/**
 * This script replaces all rows in classified_proteins, the "export table" from
 * the latest NCBI:NR release imported with new rows from the database.
 *
 * Note that deleting the latest release works also when you want to transfer
 * newly imported rows.
 *
 * Author: daniel.lundin@dbb.su.s
 */

BEGIN;

DELETE FROM classified_proteins
  WHERE
    ss_source = 'NCBI' AND 
    ss_name = 'NR' AND 
    ss_version = ( 
      SELECT MAX(ss.version)
      FROM sequence_sources ss
      WHERE ss.source = 'NCBI' AND ss.name = 'NR'
    )
  ;

INSERT INTO classified_proteins (
    seq_src, db, accno, bioproject, gene, seq,
    ncbi_taxon_id, tdomain, tkingdom, tphylum, tclass, torder, tfamily, tgenus, tspecies, tstrain,
    psuperfamily, pfamily, pclass, psubclass, pgroup, profile_version, profile_length,
    align_length, align_start, align_end, prop_matching,
    ss_source, ss_name, ss_version,
    e_value, score,
    fasta
  )
  SELECT DISTINCT ON (bss.ss_source,bss.ss_name,bss.ss_version,s.accno)
    s.seq_src,
    s.db,
    s.accno,
    bp.accession AS bioproject,
    sfcg.comment_value AS gene,
    bs.seq,
    t.ncbi_taxon_id,
    t.domain AS tdomain,
    t.kingdom AS tkingdom,
    t.phylum AS tphylum,
    t."class" as tclass,
    t."order" as torder,
    t.family AS tfamily,
    t.genus AS tgenus,
    t.species AS tspecies,
    t.strain AS tstrain,
    hp.superfamily AS psuperfamily,
    hp.family AS pfamily,
    hp."class" AS pclass,
    hp.subclass AS psubclass,
    hp.group AS pgroup,
    hp.version AS profile_version,
    hpp.length AS profile_length,
    al.length AS align_length,
    al.min_hmm_from AS align_start,
    al.max_hmm_to AS align_end,
    al.length::float/hpp.length::float AS prop_matching,
    bss.ss_source,
    bss.ss_name,
    bss.ss_version,
    bss.e_value,
    bss.score,
    fasta(
      t.domain,
      t.phylum,
      t.strain,
      NULL,		-- Protein family
      hp."class",
      hp.subclass,
      hp.group,		-- Protein group
      concat_ws('_', s.db, s.accno),
      bs.seq
    ) AS fasta
  FROM
    ncbi_taxon_hierarchies t JOIN
    taxon tt ON t.ncbi_taxon_id = tt.ncbi_taxon_id JOIN
    bioentry be ON tt.taxon_id = be.taxon_id JOIN
    biosequence bs ON be.bioentry_id = bs.bioentry_id JOIN
    sequences s ON concat_ws('.', be.accession, be.version) = s.accno JOIN
    hmm_result_row_sequences hrrs ON s.id = hrrs.sequence_id JOIN
    hmm_result_rows hrr ON hrrs.hmm_result_row_id = hrr.id JOIN
    align_lengths al ON hrr.id = al.hmm_result_row_id JOIN
    hmm_results hr ON hrr.hmm_result_id = hr.id JOIN
    hmm_profile_hierarchies hp ON hr.hmm_profile_id = hp.hmm_profile_id JOIN
    hmm_profiles hpp ON hp.hmm_profile_id = hpp.id JOIN
    best_seq_score_per_parent bss ON 
      hr.sequence_source_id = bss.sequence_source_id AND
      hp.hmm_profile_id = bss.hmm_profile_id AND
      s.id = bss.sequence_id LEFT JOIN
    bioprojects bp ON be.bioentry_id = bp.bioentry_id LEFT JOIN
    seqfeature_comments sfcg ON 
      be.bioentry_id = sfcg.bioentry_id AND 
      sfcg.seqfeature_name = 'CDS' AND 
      sfcg.comment_name = 'gene'
  WHERE
    t.species IS NOT NULL AND
    bss.ss_source = 'NCBI' AND bss.ss_name = 'NR' AND bss.ss_version = ( 
      SELECT MAX(ss.version)
      FROM sequence_sources ss
      WHERE ss.source = 'NCBI' AND ss.name = 'NR'
    )
    --AND s.accno IN ('AAB81405.1', 'AAK33447.1', 'NP_046714.1', 'WP_000451372.1', 'WP_059321938.1')	-- NrdF examples: Use for debugging
    --AND  s.accno in ('NP_001025.1', 'NP_001159403.1', 'NP_033130.1', 'XP_006520164.1')		-- NrdBe examples
  ORDER BY
    bss.ss_source,
    bss.ss_name,
    bss.ss_version,
    s.accno,
    bss.score DESC
;

COMMIT;
