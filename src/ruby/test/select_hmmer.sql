SELECT
  ss.source,
  ss.name,
  ss.version,
  hpp.name,
  hp.name,
  hp.rank
FROM
  hmm_profiles hp LEFT JOIN 
  hmm_profiles hpp on hp.parent_id = hpp.id JOIN
  hmm_results hr ON hr.hmm_profile_id = hp.id JOIN
  sequence_sources ss ON hr.sequence_source_id = ss.id
ORDER BY
  1, 2, 3
;
