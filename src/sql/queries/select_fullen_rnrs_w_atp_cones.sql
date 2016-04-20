SELECT DISTINCT
  hph.superfamily,
  hph.family,
  hph.class,
  hph.subclass,
  s.db,
  s.accno,
  s.gi
FROM
  hmm_profile_hierarchies hph JOIN
  latest_hmm_profiles_with_results hrr ON hph.hmm_profile_id = hrr.hmm_profile_id JOIN
  align_lengths al ON hrr.hmm_result_row_id = al.hmm_result_row_id JOIN
  sequences s ON hrr.sequence_id = s.id
WHERE
  hph.superfamily IN ('NrdGRE', 'Ferritin-like') AND
  hrr.best_score = TRUE AND
  s.db = 'gb' AND
  hrr.sequence_id IN (
    SELECT DISTINCT
      sequence_id
    FROM
      latest_hmm_profiles_with_results
    WHERE
      hmm_profile_name = 'PF03477'
  ) AND
  al.length > 0.9 * hrr.length
ORDER BY
  hph.superfamily,
  hph.family,
  hph.class,
  hph.subclass,
  s.db,
  s.accno
;
