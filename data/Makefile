import_hmmer: $(subst .hmmout,.import,$(wildcard *hmmer_results.d/*.hmmout))

%.import: %.hmmout
	@echo "Importing $<"
	touch $@
