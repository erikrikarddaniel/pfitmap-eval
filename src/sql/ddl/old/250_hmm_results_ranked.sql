SELECT
  ss.id,
  ss.version,
  hp.hmm_profile_id,
  hp.superfamily,
  hp.family,
  hp.class,
  hp.subclass,
  hrrs.id,
  s.id,
  s.db,
  s.accno,
  hrr.id,
  hrr.score/**,
  row_number()
OVER (
  PARTITION BY
    ss.id,
    hp.superfamily,
    s.id
  ORDER BY
    score DESC
  )
**/
FROM 
  sequences s JOIN 
  hmm_result_row_sequences hrrs ON s.id = hrrs.sequence_id JOIN 
  hmm_result_rows hrr ON hrrs.hmm_result_row_id = hrr.id JOIN 
  hmm_results hr ON hrr.hmm_result_id = hr.id JOIN 
  hmm_profile_hierarchies hp ON hr.hmm_profile_id = hp.hmm_profile_id JOIN 
  sequence_sources ss ON hr.sequence_source_id = ss.id 
ORDER BY
  ss.version,
  accno,
  hrr.score DESC
;
