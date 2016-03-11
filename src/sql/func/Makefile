all_funcs: $(subst .sql,.func,$(wildcard *.sql))

include ../makefile.common_definitions

%.func: %.sql
	psql -d $(DB) -f $< && ../export_db_definition.sql && touch $@
