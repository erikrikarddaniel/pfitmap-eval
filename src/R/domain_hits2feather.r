#!/usr/bin/env Rscript

# Reads database and outputs feather files with all classified proteins for the
# latest ss_versions for NCBI:NR.

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(feather))
suppressPackageStartupMessages(library(readr))

# Connect and define table source
sqldb = src_postgres('pfitmap-eval-prod')

domain_hits = collect(
  tbl(sqldb, 'domain_presence'),
  n = Inf
) %>%
  transmute(
    ss_source, ss_name, ss_version, accno, seq_src, db, domain, profile_length,
    ali_from = align_from, ali_to = align_to,
    hmm_from = profile_from, hmm_to = profile_to,
    score, align_length,
    prop_matching = as.numeric(align_length)/as.numeric(profile_length)
  )

write_feather(domain_hits, 'domain_hits.feather')

# Since feather is a bit unstable, also write to tsv
write_tsv(domain_hits, 'domain_hits.tsv')
