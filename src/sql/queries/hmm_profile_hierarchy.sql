SELECT 
  hp.name profile,
  hpp.superfamily,
  hpp.family,
  hpp.class,
  hpp.subclass,
  hpp.group,
  hpp.version 
FROM
  hmm_profiles hp JOIN
  hmm_profile_hierarchies hpp ON
  hp.id = hpp.hmm_profile_id
;
