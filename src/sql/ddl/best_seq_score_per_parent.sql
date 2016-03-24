-- Selects the best scoring child for each parent_id from the seq_scores view.

DROP TABLE best_seq_score_per_parent;

CREATE TABLE best_seq_score_per_parent AS
  SELECT 
    ss.*
  FROM 
    seq_scores ss JOIN
    (
      SELECT sequence_id, sequence_source_id, MAX(score) score
      FROM seq_scores
      GROUP BY 1, 2
    ) ssm ON 
      ss.sequence_id = ssm.sequence_id AND
      ss.sequence_source_id = ssm.sequence_source_id AND
      ss.score = ssm.score
;
