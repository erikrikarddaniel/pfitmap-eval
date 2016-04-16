-- Update the best scoring rows' best_score to true (if null).
-- Takes a while... Haven't tried to optimize.
UPDATE hmm_result_rows
  SET best_score = true
  WHERE id IN (
    SELECT DISTINCT
      hrr0.id
    FROM
      hmm_results hr0 JOIN
      hmm_result_rows hrr0 ON hr0.id = hrr0.hmm_result_id JOIN
      hmm_result_row_sequences hrrs0 ON hrr0.id = hrrs0.hmm_result_row_id JOIN
      hmm_profiles hp ON hr0.hmm_profile_id = hp.id JOIN
      sequences s ON hrrs0.sequence_id = s.id
    WHERE
      score = (
	SELECT
	  MAX(hrr1.score)
	FROM
	  hmm_results hr1 JOIN
	  hmm_result_rows hrr1 ON hr1.id = hrr1.hmm_result_id JOIN
	  hmm_result_row_sequences hrrs1 ON hrr1.id = hrrs1.hmm_result_row_id
	WHERE
	  hr0.sequence_source_id = hr1.sequence_source_id AND
	  hrrs0.sequence_id = hrrs1.sequence_id
      )
    ) AND
    best_score IS NULL
;

-- Update the null rows to false
UPDATE hmm_result_rows
  SET best_score = false
  WHERE best_score IS NULL
;
