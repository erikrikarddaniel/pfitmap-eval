#!/usr/bin/env Rscript

# Reads database and outputs feather files with all classified proteins for the
# latest ss_versions for NCBI:NR.

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(feather))

# Connect and define table source
db = src_postgres('pfitmap-eval-prod')

cp = tbl(db, 'classified_proteins')

write_feather(collect(cp %>% filter(prop_matching>=0.9), n=Inf), 'classified_proteins.prop_matching_ge_0.9.feather')
