DB = pfitmap-eval-dev

all_tables: $(subst .sql,.table,$(wildcard *.sql))

db:
	createdb $(DB)
	echo '$(DB)' > $@

%.table: db %.sql
	psql `cat $<` -f $(word 2, $^)
	touch $@
