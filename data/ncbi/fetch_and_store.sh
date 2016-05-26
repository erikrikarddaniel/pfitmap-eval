#!/bin/sh

# Gets a list of accession to fetch, fetches from NCBI and stores in database

if [ "$DB" = "" ]; then
  echo "You need to set the DB environment variable"
  exit 1
fi

if [ "$EMAIL" = "" ]; then
  echo "You need to set the EMAIL environment variable"
  exit 1
fi

# Get the list and split into 10000 entries pieces
psql $DB --tuples-only -f ../../src/sql/queries/select_accno_wo_ncbi_entry.sql|sed 's/^ *//' > accnos
split -l 10000 accnos accnos.

for f in accnos.*; do
  echo "--> $f <--"
  fetch_ncbi_store --verbose $EMAIL $f store/
  ~/dev/pfitmap-eval/src/python/store_genbank --verbose $DB NCBI store
  mv store/*.gb inserted
  rm $f
done
