include ../makefile.subdirs

PROBLEM_ACCNOS = grep -v '^[BGJ]A[TNUVB]' | grep -v '^KZS' | grep -v '\.0$$' | grep -v '_[0-9A-Z]$$'

all_fetched: $(subst .accnos,.fetched,$(wildcard *.accnos))

all_faas: $(subst .faa,.fetched,$(wildcard *.fetched))

only_in_sequences.accnos: bioentry.accnos sequences.accnos
	join -a 2 -j 1 $^ | grep '[0-9] seq' | grep -v ':' | sed 's/ .*//' | $(PROBLEM_ACCNOS) > $@

mismatching_versions.accnos: bioentry.acc_indexed_accnos sequences.acc_indexed_accnos
	export LC_ALL=C; join -j 1 $^ | grep -v -P "^[^ ]* ([^ ]*) [^ ]+ \1" > $@

bioentry.accnos:
	psql --tuples-only $(DB) -c "SELECT DISTINCT accession || '.' || version FROM bioentry" | sed 's/^ *//' | sed '/^ *$$/d' | sed 's/$$/ be/' | sort > $@

sequences.accnos:
	psql --tuples-only $(DB) -c "SELECT DISTINCT accno FROM sequences" | sed 's/^ *//' | sed '/^ *$$/d' | sed 's/$$/ seq/' | sort > $@

%.acc_indexed_accnos: %.accnos
	export LC_ALL=C; sed 's/^\([^.]\+\)\.\([0-9]\+\)/\1 &/' $< | sort -u > $@

%.fetched: %.accnos
	fetch_ncbi_store $(EMAIL) $< store/ 50
	touch $@

%.inserted: %.fetched
	store_genbank --verbose $(DB) NCBI store/
	mv -f store/*.gb inserted/
	touch $@


%.faa: %.fetched
	awk '/^>/ {printf("\n%s\n",$$0);next; } { printf("%s",$$0);}  END {printf("\n");}' $(basename $@)/*.faa | sed 's/  */_/g' | sed '/^$$/d' > $@
