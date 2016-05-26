SELECT
  s.accno
FROM
  sequences s
WHERE
  s.accno NOT IN (
    SELECT DISTINCT
      accession || '.' || version
    FROM
      bioentry
  )
;
