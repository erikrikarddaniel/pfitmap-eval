all: import_hmmer

include ../../sql/makefile.common_definitions

DIFF = grep -v "^[ ]*$$" $@.out | diff $@.expect -

CHECK = if [ ` $(DIFF) | wc -l ` -eq 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Here's a diff: "; $(DIFF); exit 1; fi

SIZE_CHECK = if [ ` stat -c "%s" $@.out ` -eq ` stat -c "%s" $@.expect ` ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ($@.out and $@.expect different sizes) ***"; exit 1; fi

GREP_CHECK = pattern=`cat $@.expect`; if [ `grep "$$pattern" $@.out | wc -l` -gt 0 ]; then echo "*** $@ OK ***"; else echo "*** $@ FAILED ***"; echo "Didn't find $$pattern in output"; exit 1; fi

import_hmmer: import_hmmer.000 import_hmmer.010

import_hmmer.000:
	@../import_hmmer --profile NrdAz --ss 'NCBI:NR:20141101' > $@.out 2>&1 ; exit 0
	@$(CHECK)

import_hmmer.010:
	@psql $(DB) -f clean_hmmer.sql >/dev/null 2>&1
	@../import_hmmer --profile NrdAz --ss 'NCBI:NR:20141101' $(DB) $@.hmmout $@.tblout $@.domtblout
	@psql $(DB) --tuples-only -f select_hmmer.sql | sed 's/ *| */\t/g' | sed 's/^ *//' > $@.out 2>&1
	@$(CHECK)
