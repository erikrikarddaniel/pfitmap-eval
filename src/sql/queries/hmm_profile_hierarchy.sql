SELECT 
  hp.name profile,
  hp.rank rank,
  hpp.superfamily,
  hpp.family,
  hpp.class,
  hpp.subclass,
  hpp.group,
  hpp.version ,
  hp.length
FROM
  hmm_profiles hp JOIN
  hmm_profile_hierarchies hpp ON
  hp.id = hpp.hmm_profile_id
;
