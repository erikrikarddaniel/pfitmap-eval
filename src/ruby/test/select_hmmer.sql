-- Select all sequence_sources with profiles
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

-- Result rows
SELECT
  hp.name, hrr.tname, hrr.qname,
  hrr.e_value, hrr.score, hrr.bias,
  hrr.dom_n_exp, hrr.dom_n_reg, hrr.dom_n_clu, hrr.dom_n_ov,
  hrr.dom_n_env, hrr.dom_n_dom, hrr.dom_n_rep, hrr.dom_n_rep
FROM
  hmm_profiles hp JOIN
  hmm_results hr ON hp.id = hr.hmm_profile_id JOIN
  hmm_result_rows hrr ON hr.id = hrr.hmm_result_id
ORDER BY
  hp.name, hrr.tname, hrr.qname
;

-- Sequences
SELECT sn.seq_src, sn.gi, sn.accno, sn.accno_version, sn.name
FROM
  hmm_profiles hp JOIN
  hmm_results hr ON hp.id = hr.hmm_profile_id JOIN
  hmm_result_rows hrr ON hr.id = hrr.hmm_result_id JOIN
  seqnames sn ON hrr.id = sn.hmm_result_row_id
ORDER BY
  sn.hmm_result_row_id, sn.accno, sn.accno_version
;
