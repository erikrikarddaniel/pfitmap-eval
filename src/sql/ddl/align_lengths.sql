CREATE OR REPLACE VIEW align_lengths AS
  SELECT
    hmm_result_row_id,
    MIN(hmm_from) min_hmm_from,
    MAX(hmm_to) max_hmm_to,
    MAX(hmm_to) - MIN(hmm_from) + 1 length
  FROM
    hmm_result_domains
  GROUP BY
    hmm_result_row_id
;
