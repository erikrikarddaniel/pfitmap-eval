include ../makefile.subdirs

%.fetched: %.accnos
	fetch_ncbi_store $(email) $< .
	touch $@
