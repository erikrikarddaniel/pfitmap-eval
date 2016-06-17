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

### Database updates

Update the best_score column in hmm_result_rows:

```
$ cd src/sql/dml
$ psql dbname -f update_best_score.sql
```

Load the 'best_seq_score_per_parent' table:

```
$ cd src/sql/ddl
$ psql dbname -f best_seq_score_per_parent.sql
```

## NCBI data

### NCBI taxonomy

Start by updating the NCBI taxonomy using the BioSQL script `load_ncbi_taxonomy.pl` 
Perl script. It fetches the data, inserts into the database and updates some internal
columns. Call like this, assuming a PostgreSQL database:

```
$ cd biosql-path/
$ scripts/load_ncbi_taxonomy.pl --dbname dbname --driver Pg --download
```

Data, in the form of fasta and GenBank files, can be fetched from NCBI using
the `fetch_ncbi_store` in `src/python` and a list of accession numbers.

### Sequence data

Sequence data is stored in the BioSQL schema in the same database as everything 
else. To make sure everything is there you must first generate a list of accession
numbers that are *not* in the database, then fetch the corresponding entries from
GenBank and last import them into the database.

There's a Makefile target to do all the inserts required. It requires
two environment variables: DB and EMAIL.

```
$ make -B only_in_sequences.inserted
```

When you run this the first time it will take a *long* time. It's done
piece by piece, and can be interrupted.

Error handling is poor, so running make again is recommended. Any errors at
the second run need to be investigated. In particular, there are problems with
GenBank entries with long DBLINK fields, see issues #1 and #2.

### Create new ncbi_taxon_hierarchies table

The `ncbi_taxon_hierarchies` table is a flattened out version of the taxonomical
hierarchy in the `taxon` BioSQL table. It has columns for `ncbi_taxon_id` (*not*
used in the `bioentry` table, but the key used in the NCBI dump files) and the 
most commonly used ranks from `domain` to `strain`.

The table is populated by import of a tab separated file that is created from the
dump files imported by the BioSQL taxonomy perl script (`taxdata` directory) with 
the `taxdata2taxflat` from my GitHub repository by the same name. There's a makefile
in this repository to facilitate this call. Provided you have `taxdata2taxflat`
in your PATH, just create a symbolic link in the BioSQL `taxdata` subdirectory from
the `data/ncbi/makefile.taxdata` to `Makefile` and call:

```
$ make taxflat.tsv
```

The file can be imported with the `src/sh/import_ncbi_taxon_hierarchies.sh` which
assumes the presence of a `taxdata.tsv` file in the same directory as it's called.
Most convenient is to symlink also this to the BioSQL `taxdata` directory.
