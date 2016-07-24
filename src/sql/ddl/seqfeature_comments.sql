CREATE OR REPLACE VIEW seqfeature_comments AS
  SELECT 
    be.accession,
    t.name AS seqfeature_name,
    sfqt.name AS comment_name,
    sfq.value AS comment_value
  FROM
    bioentry be JOIN
    seqfeature sf ON be.bioentry_id = sf.bioentry_id JOIN
    location l ON sf.seqfeature_id=l.seqfeature_id JOIN
    term t ON sf.type_term_id = t.term_id JOIN
    seqfeature_qualifier_value sfq ON sf.seqfeature_id = sfq.seqfeature_id JOIN
    term sfqt ON sfq.term_id = sfqt.term_id
;
