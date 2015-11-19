PSQL_COPY_TSV_FROM_STDIN = table=`echo $< | sed 's/.*\.\([^.]*\)\.copy\.tsv/\1/'`; psql -d $(DB) -c "BEGIN; DELETE FROM $$table; COPY $$table FROM STDIN; COMMIT;" <$<

all_hmm_profiles_copy: $(wildcard *.hmm_profiles.copy.tsv)
	cat $^ > /tmp/hmm_profiles.copy.tsv
	psql -d $(DB) -c "BEGIN; DELETE FROM hmm_profiles; COPY hmm_profiles FROM STDIN; COMMIT;" </tmp/hmm_profiles.copy.tsv

include ../makefile.common_definitions
