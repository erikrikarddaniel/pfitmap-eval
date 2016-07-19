DROP TABLE domain_presence;

CREATE TABLE domain_presence AS
  SELECT
    s.seq_src,
    s.db,
    s.accno,
    hp.name,
    hp.length AS profile_length,
    al.length AS align_length,
    al.min_hmm_from AS align_from,
    al.max_hmm_to AS align_to,
    al.length::float/hp.length::float AS prop_matching,
    hrr.score,
    ss.source AS ss_source,
    ss.name AS ss_name,
    ss.version AS ss_version
  FROM
    sequences s JOIN
    hmm_result_row_sequences hrrs ON s.id = hrrs.sequence_id JOIN
    hmm_result_rows hrr ON hrrs.hmm_result_row_id = hrr.id JOIN
    hmm_results hr ON hrr.hmm_result_id = hr.id JOIN
    hmm_profiles hp ON hr.hmm_profile_id = hp.id JOIN
    sequence_sources ss ON hr.sequence_source_id = ss.id JOIN
    align_lengths al ON hrr.id = al.hmm_result_row_id
  WHERE
    hp.rank = 'domain'
;
