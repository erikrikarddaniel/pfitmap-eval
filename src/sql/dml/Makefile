include ../makefile.common_definitions

PSQL_COPY_TSV_FROM_STDIN = table=`echo $< | sed 's/.*\.\([^.]*\)\.copy\.tsv/\1/'`; psql -d $(DB) -c "BEGIN; DELETE FROM $$table; COPY $$table FROM STDIN; COMMIT;" <$<

all_copy_tsv: $(subst .copy.tsv,.dm,$(wildcard *.copy.tsv))

%.copy: %.copy.tsv
	$(PSQL_COPY_TSV_FROM_STDIN)
