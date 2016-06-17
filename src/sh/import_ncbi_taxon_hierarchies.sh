#!/bin/sh
#
# Imports a flat file, the result of a call to `taxdata2taxflat`
# (called taxflat.tsv and in the BioSQL/taxata directory)
# into the ncbi_taxon_hierarchies table.

psql $DB -c 'TRUNCATE TABLE ncbi_taxon_hierarchies;'

psql $DB -c 'COPY ncbi_taxon_hierarchies FROM STDIN;' < taxflat.tsv
