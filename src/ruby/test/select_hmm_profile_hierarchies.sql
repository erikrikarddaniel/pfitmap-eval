SELECT
  superfamily,
  family,
  class,
  subclass,
  "group"
FROM
  hmm_profile_hierarchies
ORDER BY
  1, 2, 3, 4, 5
;
