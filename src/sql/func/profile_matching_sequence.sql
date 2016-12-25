/**
 * profile_matching_sequence.sql
 *
 * Returns the parts of a sequence that matches a specified profile.
 *
 * erik.rikard.daniel@gmail.com
 */

-- Takes five lookup parameters (accession number, profile name (e.g. NrdAg),
-- sequence source, name and version) plus the sequence and returns a sequence.
CREATE OR REPLACE FUNCTION
  profile_matching_sequence(
    p_accno		text,
    p_profile_name	text,
    p_ss_source		text,
    p_ss_name		text,
    p_ss_version	text,
    p_sequence		text
  ) RETURNS TEXT
  AS $$
    DECLARE
      v_domain		record;
      v_return		text;

    BEGIN
      v_return := '';

      FOR v_domain IN
	SELECT
	  (env_non_overlapping_coordinates(hrr.id)).*
	FROM
	  hmm_result_rows hrr JOIN
	  hmm_results hr ON hrr.hmm_result_id = hr.id JOIN
	  hmm_profiles hp ON hr.hmm_profile_id = hp.id JOIN
	  hmm_result_row_sequences hrrs ON hrr.id = hrrs.hmm_result_row_id JOIN
	  sequences s ON hrrs.sequence_id = s.id JOIN
	  sequence_sources ss ON hr.sequence_source_id = ss.id
	WHERE
	  s.accno = p_accno AND
	  hp.name = p_profile_name AND
	  ss.source = p_ss_source AND
	  ss.name = p_ss_name AND
	  ss.version = p_ss_version
      LOOP
	v_return := v_return || substring(p_sequence from v_domain."from" for ( v_domain."to" - v_domain."from" + 1 ));
      END LOOP;

      RETURN v_return;
    END;
  $$
  LANGUAGE plpgsql
;
