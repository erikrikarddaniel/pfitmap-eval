-- Selects class, subclass and group scores from the latest sequence_source.

CREATE OR REPLACE VIEW cscores AS
  SELECT
    cssc.sequence_source_id,
    cssc.ss_version,
    cssc.db, cssc.gi, cssc.accno, cssc.name, cssc.sequence,
    cssc.hp_name cname, cssc.e_value ce_value, cssc.score cscore, cssc.best_score cbest_score,
    scssc.hp_name scname, scssc.e_value sce_value, scssc.score scscore, scssc.best_score scbest_score,
    gssc.hp_name gname, gssc.e_value ge_value, gssc.score gscore, gssc.best_score gbest_score,
    CASE
      WHEN cssc.score < scssc.score AND scssc.score < gssc.score THEN 'class < subclass < group'
      WHEN cssc.score > scssc.score AND scssc.score > gssc.score THEN 'class > subclass > group'
      WHEN cssc.score > scssc.score AND scssc.score < gssc.score THEN 'class > subclass < group'
      WHEN cssc.score < scssc.score AND scssc.score > gssc.score THEN 'class < subclass > group'
      ELSE '--'
    END score_pattern,
    CASE
      WHEN cssc.e_value < scssc.e_value AND scssc.e_value < gssc.e_value THEN 'class < subclass < group'
      WHEN cssc.e_value > scssc.e_value AND scssc.e_value > gssc.e_value THEN 'class > subclass > group'
      WHEN cssc.e_value > scssc.e_value AND scssc.e_value < gssc.e_value THEN 'class > subclass < group'
      WHEN cssc.e_value < scssc.e_value AND scssc.e_value > gssc.e_value THEN 'class < subclass > group'
      ELSE '--'
    END e_value_pattern
  FROM
    latest_hmm_results lhr JOIN
    seq_scores cssc ON 
      lhr.sequence_source_id = cssc.sequence_source_id AND
      lhr.hmm_profile_id = cssc.hmm_profile_id AND
      cssc.hp_rank = 'class' LEFT JOIN
    best_seq_score_per_parent scssc ON
      lhr.sequence_source_id = scssc.sequence_source_id AND
      cssc.sequence_id = scssc.sequence_id AND
      cssc.hmm_profile_id = scssc.parent_id AND
      scssc.hp_rank = 'subclass' LEFT JOIN
    best_seq_score_per_parent gssc ON
      lhr.sequence_source_id = gssc.sequence_source_id AND
      cssc.sequence_id = gssc.sequence_id AND
      scssc.hmm_profile_id = gssc.parent_id AND
      gssc.hp_rank = 'group'
