#!/usr/bin/env Rscript

# Reads database and outputs feather files with all classified proteins for the
# latest ss_versions for NCBI:NR.

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(feather))
suppressPackageStartupMessages(library(readr))

# Connect and define table source
db = src_postgres('pfitmap-eval-prod')

cp = collect(tbl(db, 'classified_proteins') %>% filter(prop_matching>=0.9), n=Inf)

write_feather(cp, 'classified_proteins.prop_matching_ge_0.9.feather')

# Since feather is a bit unstable, also write to tsv
write_tsv(cp, 'classified_proteins.prop_matching_ge_0.9.tsv')