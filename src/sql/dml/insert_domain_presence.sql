/**
 * Replaces rows in the domain_presence table from the latest NCBI:NR relase
 * with new rows.
 *
 * Like classified_proteins.sql this is safe to run with new data.
 *
 * Author: daniel.lundin@dbb.su.se
 */

BEGIN;

DELETE FROM domain_presence
  WHERE
    ss_source = 'NCBI' AND 
    ss_name = 'NR' AND 
    ss_version = ( 
      SELECT MAX(ss.version)
      FROM sequence_sources ss
      WHERE ss.source = 'NCBI' AND ss.name = 'NR'
    )
  ;

INSERT INTO domain_presence (
    seq_src, db, accno, domain, 
    profile_length, align_length, 
    profile_from, profile_to, 
    prop_matching, score,
    ss_source, ss_name, ss_version
  )
  SELECT
    s.seq_src,
    s.db,
    s.accno,
    hp.name AS domain,
    hp.length AS profile_length,
    al.length AS align_length,
    al.min_hmm_from AS profile_from,
    al.max_hmm_to AS profile_to,
    al.length::float/hp.length::float AS prop_matching,
    hrr.score,
    bss.source AS ss_source,
    bss.name AS ss_name,
    bss.version AS ss_version
  FROM
    sequences s JOIN
    hmm_result_row_sequences hrrs ON s.id = hrrs.sequence_id JOIN
    hmm_result_rows hrr ON hrrs.hmm_result_row_id = hrr.id JOIN
    hmm_results hr ON hrr.hmm_result_id = hr.id JOIN
    hmm_profiles hp ON hr.hmm_profile_id = hp.id JOIN
    sequence_sources bss ON hr.sequence_source_id = bss.id JOIN
    align_lengths al ON hrr.id = al.hmm_result_row_id
  WHERE
    hp.rank = 'domain' AND
    db IS NOT NULL AND
    bss.source = 'NCBI' AND bss.name = 'NR' AND bss.version = ( 
      SELECT MAX(ss.version)
      FROM sequence_sources ss
      WHERE ss.source = 'NCBI' AND ss.name = 'NR'
    )
;

COMMIT;
