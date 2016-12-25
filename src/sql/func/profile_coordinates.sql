/**
 * profile_coordinates.sql
 *
 * Defines functions that calculate new, non-overlapping, hmm_profile
 * matching coordinates.
 *
 * Returns one or more records: hmm_result_row_id, hmm_from, hmm_to, ali_from,
 * ali_to, env_from and env_to.
 *
 * daniel.lundin@dbb.su.se
 */

-- Takes a hmm_result_row_id and returns a set of records reducing the
-- hmm_result_domains records for it down to non-overlapping
CREATE TYPE profile_coordinates as (
  hmm_result_row_id	int,
  hmm_from		int, hmm_to	int,
  ali_from		int, ali_to	int,
  env_from		int, env_to	int,
  length		int
);

CREATE OR REPLACE FUNCTION
  profile_coordinates(hrr_id int)
  RETURNS SETOF profile_coordinates
  AS $$
  DECLARE
    current_hmm_from	int;
    current_hmm_to	int;
    hrd_row		profile_coordinates%ROWTYPE;
    r_row		profile_coordinates%ROWTYPE;
  BEGIN
    current_hmm_from := -1;
    FOR hrd_row IN 
      SELECT 
        hmm_result_row_id,
	hmm_from,		hmm_to,
	ali_from,		ali_to,
	env_from,		env_to,
	0 AS length
      FROM hmm_result_domains 
      WHERE hmm_result_row_id = hrr_id 
      ORDER BY hmm_from
    LOOP
      IF current_hmm_from = -1 THEN
	r_row := hrd_row;
	current_hmm_from := r_row.hmm_from;
      ELSE
	IF hrd_row.hmm_from <= r_row.hmm_to THEN
	  r_row.hmm_to := hrd_row.hmm_to;
	  r_row.ali_to := hrd_row.ali_to;
	  r_row.env_to := hrd_row.env_to;
	ELSE
	  current_hmm_from := -1;
	  r_row.length := r_row.hmm_to - r_row.hmm_from + 1;
	  RETURN NEXT r_row;
	  r_row := hrd_row;
	END IF;
      END IF;
    END LOOP;
    r_row.length := r_row.hmm_to - r_row.hmm_from + 1;
    RETURN NEXT r_row;
  END;
$$ LANGUAGE plpgsql;
