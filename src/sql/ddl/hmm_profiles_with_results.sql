CREATE OR REPLACE VIEW hmm_profiles_with_results AS
  SELECT
    hr.hmm_profile_id,
    hp.name hmm_profile_name,
    hp.rank,
    s.id sequence_id,
    s.seq_src,
    s.db,
    s.gi,
    s.accno,
    s.name seq_name,
    s.sequence,
    hr.id hmm_result_id,
    hrr.id hmm_result_row_id,
    hrr.e_value,
    hrr.score
  FROM
    hmm_profiles hp JOIN
    hmm_results hr ON hp.id = hr.hmm_profile_id JOIN
    hmm_result_rows hrr ON hr.id = hrr.hmm_result_id JOIN
    hmm_result_row_sequences hrrs ON hrr.id = hrrs.hmm_result_row_id JOIN
    sequences s ON hrrs.sequence_id = s.id
