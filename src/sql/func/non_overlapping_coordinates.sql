/**
 * profile_coordinates.sql
 *
 * Defines functions that calculate new, non-overlapping, hmm_profile
 * matching coordinates.
 *
 *
 * daniel.lundin@dbb.su.se
 */

-- Takes a hmm_result_row_id and returns a set of records reducing the
-- hmm_result_domains records for it down to non-overlapping
CREATE TYPE non_overlapping_coordinates as (
  hmm_result_row_id	int,
  "from"		int, 
  "to"			int,
  length		int
);

CREATE OR REPLACE FUNCTION
  non_overlapping_coordinates(hrr_id int, from_col text, to_col text)
  RETURNS SETOF non_overlapping_coordinates
  AS $$
  DECLARE
    current_from	int;
    sql			text;
    hrd_row		non_overlapping_coordinates%ROWTYPE;
    r_row		non_overlapping_coordinates%ROWTYPE;
  BEGIN
    current_from := -1;
    sql := 'SELECT hmm_result_row_id,' || from_col || ' AS "from",' || to_col || ' AS "to", 0 AS length FROM hmm_result_domains WHERE hmm_result_row_id = ' || hrr_id || ' ORDER BY ' || from_col;
    FOR hrd_row IN EXECUTE(sql) LOOP
--      RAISE NOTICE 'hrd_row: %s - %s', hrd_row."from", hrd_row."to";
      IF current_from = -1 THEN
--	RAISE NOTICE 'New segment';
	r_row := hrd_row;
	current_from := r_row."from";
      ELSE
	IF hrd_row."from" <= r_row."to" THEN
--	  RAISE NOTICE 'appending';
	  r_row."to" := hrd_row."to";
	ELSE
--	  RAISE NOTICE 'outputting row';
	  r_row.length := r_row."to" - r_row."from" + 1;
	  RETURN NEXT r_row;
	  r_row := hrd_row;
	END IF;
      END IF;
    END LOOP;
    r_row.length := r_row."to" - r_row."from" + 1;
    RETURN NEXT r_row;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION
  hmm_non_overlapping_coordinates(hrr_id int)
  RETURNS SETOF non_overlapping_coordinates
  AS $$
  BEGIN
    RETURN QUERY SELECT (non_overlapping_coordinates(hrr_id, 'hmm_from', 'hmm_to')).*;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION
  ali_non_overlapping_coordinates(hrr_id int)
  RETURNS SETOF non_overlapping_coordinates
  AS $$
  BEGIN
    RETURN QUERY SELECT (non_overlapping_coordinates(hrr_id, 'ali_from', 'ali_to')).*;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION
  env_non_overlapping_coordinates(hrr_id int)
  RETURNS SETOF non_overlapping_coordinates
  AS $$
  BEGIN
    RETURN QUERY SELECT (non_overlapping_coordinates(hrr_id, 'env_from', 'env_to')).*;
  END;
$$ LANGUAGE plpgsql;
