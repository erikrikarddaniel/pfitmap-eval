-- Selects class and subclass scores from the latest sequence_source.

CREATE OR REPLACE VIEW cscores AS
  SELECT
    cssc.sequence_source_id,
    cssc.ss_version,
    cssc.db, cssc.gi, cssc.accno, cssc.name, cssc.sequence,
    cssc.hp_name cname, cssc.e_value ce_value, cssc.score cscore,
    scssc.hp_name scname, scssc.e_value sce_value, scssc.score scscore,
    CASE
      WHEN cssc.score < scssc.score THEN 'class < subclass'
      WHEN cssc.score > scssc.score THEN 'class > subclass'
      ELSE '--'
    END score_pattern,
    CASE
      WHEN cssc.e_value < scssc.e_value THEN 'class < subclass'
      WHEN cssc.e_value > scssc.e_value THEN 'class > subclass'
      ELSE '--'
    END e_value_pattern
  FROM
    latest_hmm_results lhr JOIN
    seq_scores cssc ON 
      lhr.sequence_source_id = cssc.sequence_source_id AND
      lhr.hmm_profile_id = cssc.hmm_profile_id AND
      cssc.hp_rank = 'class' LEFT JOIN
    seq_scores scssc ON
      lhr.sequence_source_id = scssc.sequence_source_id AND
      cssc.sequence_id = scssc.sequence_id AND
      scssc.parent_id = cssc.hmm_profile_id AND
      scssc.hp_rank = 'subclass'
