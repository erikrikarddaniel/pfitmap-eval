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
psql --tuples-only $DB -c "SELECT DISTINCT accession || '.' || version FROM bioentry" | sed 's/^ *//' | sed '/^ *$/d' | sed 's/$/ be/' | sort > bioentry.accnos
psql --tuples-only $DB -c "SELECT DISTINCT accno FROM sequences WHERE db != 'pdb'" | sed 's/^ *//' | sed '/^ *$/d' | sed 's/$/ seq/' | sort > sequences.accnos
join -a 1 -j 1 bioentry.accnos sequences.accnos | grep -v 'seq' | sed 's/ .*//' > only_in_bioentry.accnos
join -a 2 -j 1 bioentry.accnos sequences.accnos | grep -v 'be' | sed 's/ .*//' > only_in_sequences.accnos

# Handle the accessions not found in bioentry in batches of 10000
split -l 10000 only_in_sequences.accnos accnos.

for f in accnos.*; do
  echo "--> $f <--"
  fetch_ncbi_store --verbose $EMAIL $f store/
  ~/dev/pfitmap-eval/src/python/store_genbank --verbose $DB NCBI store
  mv store/*.gb inserted
  rm $f
done
