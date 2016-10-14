CREATE OR REPLACE VIEW align_lengths AS
  SELECT
    hmm_result_row_id,
    MIN(hmm_from) min_hmm_from,
    MAX(hmm_to) max_hmm_to,
    SUM(length) length
  FROM (
    SELECT
      hmm_result_row_id,
      hmm_from,
      hmm_to,
      hmm_to - hmm_from + 1 length
    FROM
      hmm_result_domains
  ) a
  GROUP BY
    hmm_result_row_id
;
