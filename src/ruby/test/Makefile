all: import_hmmer

include ../../sql/makefile.common_definitions

DIFF = grep -v "^[ ]*$$" $@.out | diff $@.expect -

CHECK = if [ ` $(DIFF) | wc -l ` -eq 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Here's a diff: "; $(DIFF); exit 1; fi

SIZE_CHECK = if [ ` stat -c "%s" $@.out ` -eq ` stat -c "%s" $@.expect ` ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ($@.out and $@.expect different sizes) ***"; exit 1; fi

GREP_CHECK = pattern=`cat $@.expect`; if [ `grep "$$pattern" $@.out | wc -l` -gt 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Didn't find $$pattern in output"; exit 1; fi

all: import_hmmer update_hmm_profile_hierarchies

best_score: best_score.setup best_score.000

import_hmmer: import_hmmer.setup import_hmmer.000 import_hmmer.010 import_hmmer.020

update_hmm_profile_hierarchies: update_hmm_profile_hierarchies.setup update_hmm_profile_hierarchies.000

best_score.setup:
	@dropdb $(DB)-integration; exit 0 >/dev/null 2>&1
	@createdb $(DB)-integration >/dev/null 2>&1
	@psql $(DB)-integration -f setup/000.create_tables.sql >/dev/null 2>&1
	@psql $(DB)-integration -f setup/100.copy_hmm_profiles.sql >/dev/null 2>&1
	@echo "Copying data and creating indexes -- will take some time"
	@gunzip -c setup/200.copy_hmm_results.sql.gz | psql $(DB)-integration >/dev/null 2>&1
	@psql $(DB)-integration -f setup/900.add_constraints.sql >/dev/null 2>&1

best_score.000:

import_hmmer.setup:
	@dropdb $(DB)-integration; exit 0 >/dev/null 2>&1
	@createdb $(DB)-integration >/dev/null 2>&1
	@psql $(DB)-integration -f setup/000.create_tables.sql >/dev/null 2>&1
	@psql $(DB)-integration -f setup/100.copy_hmm_profiles.sql >/dev/null 2>&1
	@psql $(DB)-integration -f setup/900.add_constraints.sql >/dev/null 2>&1

import_hmmer.000:
	@../import_hmmer --profile NrdAz --ss 'NCBI:NR:20141101' > $@.out 2>&1 ; exit 0
	@$(CHECK)

import_hmmer.010:
	@psql $(DB)-integration -f clean_hmmer.sql >/dev/null 2>&1
	@../import_hmmer --profile NrdAz --ss 'NCBI:NR:20141101' $(DB)-integration $@.hmmout $@.tblout $@.domtblout
	@psql $(DB)-integration --tuples-only -f select_hmmer.sql | sed 's/  *|  */\t/g' | sed 's/^ *//' > $@.out 2>&1
	@$(CHECK)

import_hmmer.020:
	@psql $(DB)-integration -f clean_hmmer.sql >/dev/null 2>&1
	@../import_hmmer --profile NrdAz --ss 'NCBI:NR:20141101' $(DB)-integration $@.hmmout $@.tblout $@.domtblout
	@psql $(DB)-integration --tuples-only -f select_hmmer.sql | sed 's/  *|  */\t/g' | sed 's/^ *//' > $@.out 2>&1
	@$(CHECK)

update_hmm_profile_hierarchies.setup:
	@dropdb $(DB)-integration; exit 0 >/dev/null 2>&1
	@createdb $(DB)-integration >/dev/null 2>&1
	@psql $(DB)-integration -f setup/000.create_tables.sql >/dev/null 2>&1
	@psql $(DB)-integration -f setup/100.copy_hmm_profiles.sql >/dev/null 2>&1
	@psql $(DB)-integration -f setup/900.add_constraints.sql >/dev/null 2>&1

update_hmm_profile_hierarchies.000:
	@../update_hmm_profile_hierarchies $(DB)-integration
	@psql $(DB)-integration --tuples-only -f select_hmm_profile_hierarchies.sql | sed 's/^ *//' > $@.out 2>&1
	@$(CHECK)
