select t.accno, t.domain, count(*) from (
SELECT
  s.db, s.accno, hp.name AS domain, hp.rank,
  hrr.e_value, hrr.score,
  ss.source, ss.name, ss.version
FROM 
  hmm_profiles hp JOIN
  hmm_results hr ON hp.id = hr.hmm_profile_id JOIN
  hmm_result_rows hrr ON hr.id = hrr.hmm_result_id JOIN
  sequence_sources ss ON hr.sequence_source_id = ss.id JOIN
  hmm_result_row_sequences hrrs ON hrr.id = hrrs.hmm_result_row_id JOIN
  sequences s ON hrrs.sequence_id = s.id JOIN
  hmm_result_domains hrd ON hrr.id = hrd.hmm_result_row_id
WHERE
  hp.rank = 'domain' AND
  ss.version = ( SELECT MAX(version) FROM sequence_sources )
ORDER BY
  s.db, s.accno, hp.name
) t
group by t.accno, t.domain
having count(*) > 1
;
