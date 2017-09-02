SELECT
  substring(s.accno from '^[^.]*') AS accno,
  s.accno AS accno_version,
  hrr.e_value,
  hrr.score,
  hrd.hmm_from, hrd.hmm_to,
  hrd.ali_from, hrd.ali_to,
  hrd.env_from, hrd.env_to,
  bs.seq
FROM
  sequences s JOIN
  hmm_result_row_sequences hrrs ON s.id = hrrs.sequence_id JOIN
  hmm_result_rows hrr ON hrrs.hmm_result_row_id = hrr.id JOIN
  hmm_results hr ON hrr.hmm_result_id = hr.id JOIN
  hmm_profiles hp ON hr.hmm_profile_id = hp.id JOIN
  hmm_result_domains hrd ON hrr.id = hrd.hmm_result_row_id JOIN
  bioentry be ON substring(s.accno from '^[^.]*') = be.accession JOIN
  biosequence bs ON be.bioentry_id = bs.bioentry_id
WHERE
  hp.name = 'ATPcone' AND
  hrr.score > 40
;
