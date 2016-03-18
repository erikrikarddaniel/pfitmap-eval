# Loading data

## HMMer data

### `hmm_profiles` table

The `hmm_profiles` table is typically loaded from a tab separated file in the dml
directory.  In the makefile there's a target to load all, but it typically
doesn't work because of foreign key constraints. Instead, do it manually:

```

$ psql dbname -c "BEGIN; COPY hmm_profiles FROM STDIN; COMMIT;"

```

After inserting new data in `hmm_profiles`, update the non-hierarchical table too
using the `update_hmm_profile_hierarchies` in `src/ruby`:

```

$ update_hmm_profile_hierarchies --verbose dbname

```

### HMMer data

Data from hmmsearch (all three formats) is imported with the `import_hmmer` 
Ruby script (`src/ruby` in this repository):

```

$ import_hmmer --verbose --profile Rhodopsin --ss NCBI:NR:20160205 dbname Rhodopsin.ncbi_nr.hmmout Rhodopsin.ncbi_nr.tblout Rhodopsin.ncbi_nr.domtblout

```

## NCBI sequence data

Data, in the form of fasta and GenBank files, can be fetched from NCBI using
the `fetch_ncbi_store` in `src/python` and a list of accession numbers.
