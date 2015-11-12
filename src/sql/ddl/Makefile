include ../makefile.common_definitions

all_tables: $(subst .sql,.table,$(wildcard *.sql))

%.table: db %.sql
	$(PSQL_CALL)
