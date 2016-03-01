SELECT
  ss.version,
  hp.superfamily,
  hp.family,
  hp.class,
  hp.subclass,
  s.db,
  s.accno,
  hrr.score
FROM
  sequence_sources ss JOIN
  hmm_results hr ON ss.id = hr.sequence_source_id JOIN
  hmm_profile_hierarchies hp ON hp.hmm_profile_id = hr.hmm_profile_id JOIN
  hmm_result_rows hrr ON hr.id = hrr.hmm_result_id JOIN
  hmm_result_row_sequences hrrs ON hrr.id = hrrs.hmm_result_row_id JOIN
  sequences s ON hrrs.sequence_id = s.id
ORDER BY
  accno,
  score
