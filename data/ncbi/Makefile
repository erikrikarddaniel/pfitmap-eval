include ../makefile.subdirs

all_fetched: $(subst .accnos,.fetched,$(wildcard *.accnos))

all_faas: $(subst .faa,.fetched,$(wildcard *.fetched))

%.fetched: %.accnos
	mkdir $(basename $@)
	fetch_ncbi_store $(email) $< $(basename $@)
	touch $@

%.faa: %.fetched
	awk '/^>/ {printf("\n%s\n",$$0);next; } { printf("%s",$$0);}  END {printf("\n");}' $(basename $@)/*.faa | sed 's/  */_/g' | sed '/^$$/d' > $@
