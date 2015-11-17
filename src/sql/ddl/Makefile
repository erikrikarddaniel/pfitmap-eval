all_tables: $(subst .sql,.table,$(wildcard *.sql))

include ../makefile.common_definitions

%.table: db %.sql
	$(PSQL_CALL)
