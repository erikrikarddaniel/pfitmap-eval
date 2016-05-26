CREATE OR REPLACE VIEW taxon_with_scientific_name AS
  SELECT
    t.taxon_id,
    t.ncbi_taxon_id,
    t.parent_taxon_id,
    t.node_rank,
    t.genetic_code,
    t.mito_genetic_code,
    t.left_value,
    t.right_value,
    tn.name
  FROM
    taxon t JOIN taxon_name tn ON t.taxon_id = tn.taxon_id AND
    tn.name_class = 'scientific name'
;
