-- Selects family, class and subclass scores from the latest sequence_source.

CREATE OR REPLACE VIEW fscores AS
  SELECT
    fssc.sequence_source_id,
    fssc.ss_version,
    fssc.db, fssc.gi, fssc.accno, fssc.name, fssc.sequence,
    fssc.hp_name fname, fssc.e_value fe_value, fssc.score fscore, fssc.best_score fbest_score,
    cssc.hp_name cname, cssc.e_value ce_value, cssc.score cscore, cssc.best_score cbest_score,
    scssc.hp_name scname, scssc.e_value sce_value, scssc.score scscore, scssc.best_score scbest_score,
    CASE
      WHEN fssc.score < cssc.score AND cssc.score < scssc.score THEN 'family < class < subclass'
      WHEN fssc.score > cssc.score AND cssc.score > scssc.score THEN 'family > class > subclass'
      WHEN fssc.score > cssc.score AND cssc.score < scssc.score THEN 'family > class < subclass'
      WHEN fssc.score < cssc.score AND cssc.score > scssc.score THEN 'family < class > subclass'
      ELSE '--'
    END score_pattern,
    CASE
      WHEN fssc.e_value < cssc.e_value AND cssc.e_value < scssc.e_value THEN 'family < class < subclass'
      WHEN fssc.e_value > cssc.e_value AND cssc.e_value > scssc.e_value THEN 'family > class > subclass'
      WHEN fssc.e_value > cssc.e_value AND cssc.e_value < scssc.e_value THEN 'family > class < subclass'
      WHEN fssc.e_value < cssc.e_value AND cssc.e_value > scssc.e_value THEN 'family < class > subclass'
      ELSE '--'
    END e_value_pattern
  FROM
    latest_hmm_results lhr JOIN
    seq_scores fssc ON 
      lhr.sequence_source_id = fssc.sequence_source_id AND
      lhr.hmm_profile_id = fssc.hmm_profile_id AND
      fssc.hp_rank = 'family' LEFT JOIN
    best_seq_score_per_parent cssc ON
      lhr.sequence_source_id = cssc.sequence_source_id AND
      fssc.sequence_id = cssc.sequence_id AND
      fssc.hmm_profile_id = cssc.parent_id AND
      cssc.hp_rank = 'class' LEFT JOIN
    best_seq_score_per_parent scssc ON
      lhr.sequence_source_id = scssc.sequence_source_id AND
      fssc.sequence_id = scssc.sequence_id AND
      cssc.hmm_profile_id = scssc.parent_id AND
      scssc.hp_rank = 'subclass'
