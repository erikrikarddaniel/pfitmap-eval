-- Selects the best scoring child for each parent_id from the seq_scores view.

-- Drop only when you have changed the seq_scores
--DROP TABLE best_seq_score_per_parent CASCADE;
TRUNCATE TABLE best_seq_score_per_parent;

-- Create when you've dropped
--CREATE TABLE best_seq_score_per_parent AS
INSERT INTO best_seq_score_per_parent 
  SELECT 
    ss.*
  FROM 
    seq_scores ss JOIN
    (
      SELECT sequence_id, sequence_source_id, parent_id, MAX(score) score
      FROM seq_scores
      GROUP BY 1, 2, 3
    ) ssm ON 
      ss.sequence_id = ssm.sequence_id AND
      ss.sequence_source_id = ssm.sequence_source_id AND
      ss.score = ssm.score
;
