CREATE OR REPLACE VIEW latest_hmm_results AS
  SELECT 
    hr.*,
    ss.source,
    ss.name,
    ss.version
  FROM
    hmm_results hr JOIN sequence_sources ss ON hr.sequence_source_id = ss.id
  WHERE
    ss.version = (
      SELECT MAX(version)
      FROM sequence_sources
      WHERE 
        sequence_sources.source = ss.source AND
        sequence_sources.name = ss.name
    )
;
