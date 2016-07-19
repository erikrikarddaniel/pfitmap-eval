DROP TABLE classified_proteins;

CREATE TABLE classified_proteins AS
  SELECT DISTINCT ON (s.accno)
    s.seq_src,
    s.db,
    s.accno,
    dbx.accession AS bioproject,
    bs.seq,
    t.domain AS tdomain,
    t.kingdom AS tkingdom,
    t.phylum AS tphylum,
    t."class" as tclass,
    t.family AS tfamily,
    t.genus AS tgenus,
    t.species AS tspecies,
    t.strain AS tstrain,
    hp.superfamily AS psuperfamily,
    hp.family AS pfamily,
    hp."class" AS pclass,
    hp.subclass AS psubclass,
    hp.group AS pgroup,
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
      NULL,		-- Protein group
      concat_ws('_', s.db, s.accno),
      bs.seq
    ) AS fasta
  FROM
    ncbi_taxon_hierarchies t JOIN
    taxon tt ON t.ncbi_taxon_id = tt.ncbi_taxon_id JOIN
    bioentry be ON tt.taxon_id = be.taxon_id JOIN
    biosequence bs ON be.bioentry_id = bs.bioentry_id LEFT JOIN
    bioentry_dbxref bedbx ON be.bioentry_id = bedbx.bioentry_id JOIN
    dbxref dbx ON bedbx.dbxref_id = dbx.dbxref_id AND dbx.dbname = 'BioProject' JOIN
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
      s.id = bss.sequence_id
  WHERE
    t.species IS NOT NULL
  ORDER BY
    s.accno,
    bss.score DESC
;
