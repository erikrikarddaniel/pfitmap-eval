INSERT INTO ncbi_taxon_hierarchies AS
  SELECT
    t.ncbi_taxon_id,
    domain.name AS domain,
    kingdom.name AS kingdom,
    phylum.name AS phylum,
    class.name AS class,
    "order".name AS "order",
    family.name AS family,
    genus.name AS genus,
    species.name AS species,
    strain.name AS strain
  FROM
    taxon t LEFT JOIN
    taxon_with_scientific_name domain ON 
      domain.left_value  <= t.left_value AND
      domain.right_value >= t.right_value AND
      domain.node_rank = 'superkingdom' LEFT JOIN
    taxon_with_scientific_name kingdom ON 
      kingdom.left_value  <= t.left_value AND
      kingdom.right_value >= t.right_value AND
      kingdom.node_rank IN ('superphylum', 'kingdom') LEFT JOIN
    taxon_with_scientific_name phylum ON 
      phylum.left_value  <= t.left_value AND
      phylum.right_value >= t.right_value AND
      phylum.node_rank = 'phylum' LEFT JOIN
    taxon_with_scientific_name class ON 
      class.left_value  <= t.left_value AND
      class.right_value >= t.right_value AND
      class.node_rank = 'class' LEFT JOIN
    taxon_with_scientific_name "order" ON 
      "order".left_value  <= t.left_value AND
      "order".right_value >= t.right_value AND
      "order".node_rank = 'order' LEFT JOIN
    taxon_with_scientific_name family ON 
      family.left_value  <= t.left_value AND
      family.right_value >= t.right_value AND
      family.node_rank = 'family' LEFT JOIN
    taxon_with_scientific_name genus ON 
      genus.left_value  <= t.left_value AND
      genus.right_value >= t.right_value AND
      genus.node_rank = 'genus' LEFT JOIN
    taxon_with_scientific_name species ON 
      species.left_value  <= t.left_value AND
      species.right_value >= t.right_value AND
      species.node_rank = 'species' LEFT JOIN
    taxon_with_scientific_name strain ON
      species.taxon_id = strain.parent_taxon_id
;
