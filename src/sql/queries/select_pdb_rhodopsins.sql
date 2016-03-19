SELECT
  s.db,
  s.accno,
  s.gi,
  hrr.score,
  hrd.hmm_from,
  hrd.hmm_to
FROM
  hmm_profiles hp JOIN
  hmm_results hr ON hp.id = hr.hmm_profile_id JOIN
  hmm_result_rows hrr ON hr.id = hrr.hmm_result_id JOIN
  hmm_result_domains hrd ON hrr.id = hrd.hmm_result_row_id JOIN
  hmm_result_row_sequences hrrs ON hrr.id = hrrs.hmm_result_row_id JOIN
  sequences s ON hrrs.sequence_id = s.id
WHERE
  hp.name = 'Rhodopsin' AND
  hr.executed = (
    SELECT MAX(executed)
    FROM hmm_results
    WHERE hmm_profile_id = hp.id
  ) AND
  s.db = 'pdb'
;
