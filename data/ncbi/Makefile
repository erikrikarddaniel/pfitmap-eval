%.tsv: %.sql
	psql $(DB) -f $< | grep -v '^--' | grep -v '^(' | sed 's/ *| */\t/g' | sed 's/^ *//' > $@

%.accnos: %.tsv
	cut -f 2 $< | grep -v accno > $@

%.fetched: %.accnos
	fetch_ncbi_store $(email) $< .
	touch $@
