DB = pfitmap-eval-dev

db:
	createdb $(DB)
	echo '$(DB)' > $@

%.table: db %.sql
	psql `cat $<` -f $(word 2, $^)
	touch $@
