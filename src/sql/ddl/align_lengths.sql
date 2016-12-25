DROP TABLE align_lengths;

CREATE TABLE align_lengths AS
  SELECT
    hmm_result_row_id,
    MIN("from") min_hmm_from,
    MAX("to") max_hmm_to,
    SUM(length) length
  FROM (
    SELECT (hmm_non_overlapping_coordinates(id)).* FROM hmm_result_rows
  ) a
  GROUP BY
    hmm_result_row_id
;
