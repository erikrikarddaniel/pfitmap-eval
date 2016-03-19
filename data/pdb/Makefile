include ../makefile.subdirs

%.pdbcodes: %.accnos
	sed 's/:.*//' $< | sort -u > $@

%.pdbfetched: %.pdbcodes
	for s in `cat $<`; do make $$s.pdb; done
	touch $@

%.pdb:
	wget -O $@ http://files.rcsb.org/download/$@
