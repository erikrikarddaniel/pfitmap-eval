SELECT
  hp.name,
  ss.source,
  ss.name,
  ss.version,
  hr.executed,
  count(*) AS n_rows
FROM
  hmm_profiles hp LEFT JOIN
  hmm_results hr ON hp.id = hr.hmm_profile_id JOIN
  hmm_result_rows hrr ON hr.id = hrr.hmm_result_id JOIN
  sequence_sources ss ON ss.id = hr.sequence_source_id
GROUP BY
  1, 2, 3, 4, 5
ORDER BY
  1, 2, 3, 4, 5
;
