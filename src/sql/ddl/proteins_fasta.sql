CREATE OR REPLACE VIEW proteins_fasta AS
  SELECT
    fasta(
      t.domain,
      t.phylum,
      t.strain,
      NULL,		-- Protein family
      hp."class",
      hp.subclass,
      NULL,		-- Protein group
      concat_ws('_', s.db, s.accno),
      bs.seq
    ),
    t.domain AS tdomain,
    t.kingdom AS tkingdom,
    t.phylum AS tphylum,
    t."class" as tclass,
    t.family AS tfamily,
    t.genus AS tgenus,
    t.species AS tspecies,
    hp.superfamily AS psuperfamily,
    hp.family AS pfamily,
    hp."class" AS pclass,
    hp.subclass AS psubclass,
    hp.group AS pgroup,
    bss.ss_source,
    bss.ss_name,
    bss.ss_version
  FROM
    ncbi_taxon_hierarchies t JOIN
    taxon tt ON t.ncbi_taxon_id = tt.ncbi_taxon_id JOIN
    bioentry be ON tt.taxon_id = be.taxon_id JOIN
    biosequence bs ON be.bioentry_id = bs.bioentry_id JOIN
    sequences s ON concat_ws('.', be.accession, be.version) = s.accno JOIN
    hmm_result_row_sequences hrrs ON s.id = hrrs.sequence_id JOIN
    hmm_result_rows hrr ON hrrs.hmm_result_row_id = hrr.id JOIN
    hmm_results hr ON hrr.hmm_result_id = hr.id JOIN
    hmm_profile_hierarchies hp ON hr.hmm_profile_id = hp.hmm_profile_id JOIN
    best_seq_score_per_parent bss ON 
      hr.sequence_source_id = bss.sequence_source_id AND
      hp.hmm_profile_id = bss.hmm_profile_id AND
      s.id = bss.sequence_id
;
