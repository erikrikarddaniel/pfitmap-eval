SELECT
  substring(s.accno from '^[^.]*') AS accno,
  s.accno AS accno_version,
  row_number() OVER (PARTITION BY s.accno ORDER BY hrd.score DESC) AS conenum,
  hrd.c_e_value,
  hrd.i_e_value,
  hrd.score,
  hrd.hmm_from, hrd.hmm_to,
  hrd.ali_from, hrd.ali_to,
  hrd.env_from, hrd.env_to,
  substr(bs.seq, hrd.ali_from, hrd.ali_to - hrd.ali_from + 1) AS seq
FROM
  sequences s JOIN
  hmm_result_row_sequences hrrs ON s.id = hrrs.sequence_id JOIN
  hmm_result_rows hrr ON hrrs.hmm_result_row_id = hrr.id JOIN
  hmm_results hr ON hrr.hmm_result_id = hr.id JOIN
  hmm_profiles hp ON hr.hmm_profile_id = hp.id JOIN
  hmm_result_domains hrd ON hrr.id = hrd.hmm_result_row_id JOIN
  bioentry be ON substring(s.accno from '^[^.]*') = be.accession JOIN
  biosequence bs ON be.bioentry_id = bs.bioentry_id JOIN
  sequence_sources ss ON hr.sequence_source_id = ss.id
WHERE
  hp.name = 'ATPcone' AND
  hrd.score > 30 AND
  ss.id = ( SELECT MAX(id) FROM sequence_sources )
ORDER BY
  s.accno,
  conenum DESC
;
