-- Selects scores per sequence, hmm_profile and sequence_source
CREATE OR REPLACE VIEW seq_scores AS
  SELECT
    hr.sequence_source_id,
    ss.source ss_source, ss.name ss_name, ss.version ss_version,
    hr.hmm_profile_id,
    hp.name hp_name, hp.version hp_version, hp.rank hp_rank, hp.parent_id,
    hrrs.sequence_id, s.seq_src, s.db, s.gi, s.accno, s.name, s.sequence,
    hrr.tname, hrr.qname, 
    hrr.e_value, hrr.score, hrr.bias,
    hrr.best_score
  FROM
    sequence_sources ss JOIN
    hmm_results hr ON ss.id = hr.sequence_source_id JOIN
    hmm_profiles hp ON hr.hmm_profile_id = hp.id JOIN
    hmm_result_rows hrr ON hr.id = hrr.hmm_result_id JOIN
    hmm_result_row_sequences hrrs ON hrr.id = hrrs.hmm_result_row_id JOIN
    sequences s ON hrrs.sequence_id = s.id
