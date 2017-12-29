include /home/dl/dev/biomakefiles/lib/make/makefile.postgresql

%.tsv.gz: %.sql
	psql $(DBNAME) -f $< | $(POSTGRESQL_SELECT_TO_TSV) | gzip -c > $@
