SELECT DISTINCT ON (tspecies)
  fasta(
    tdomain,
    tphylum,
    tclass,
    torder,
    tfamily,
    tstrain,
    pgroup,
    accno,
    seq
  )
FROM
  classified_proteins
WHERE
  prop_matching >= 0.9 and 
  pgroup = 'NrdF2' and
  db = 'ref'
ORDER BY
  tspecies,
  seq
;
