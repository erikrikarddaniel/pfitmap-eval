SELECT DISTINCT
  s.db,
  s.accno,
  s.gi
FROM
  hmm_profile_hierarchies hph JOIN
  hmm_profiles hp ON hph.hmm_profile_id = hp.id JOIN
  hmm_results hr ON hph.hmm_profile_id = hr.hmm_profile_id JOIN
  hmm_result_rows hrr ON hr.id = hrr.hmm_result_id JOIN
  hmm_result_domains hrd ON hrr.id = hrd.hmm_result_row_id JOIN
  hmm_result_row_sequences hrrs ON hrr.id = hrrs.hmm_result_row_id JOIN
  sequences s ON hrrs.sequence_id = s.id
WHERE
  hph.family = 'BoNT_Tetanus' AND
  hr.executed = (
    SELECT MAX(executed)
    FROM hmm_results
    WHERE hmm_profile_id = hp.id
  ) AND
  s.db = 'gb' AND
  ( hrd.hmm_to - hrd.hmm_from + 1 ) > 0.9 * hp.length
;
