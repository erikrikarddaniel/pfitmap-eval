#!/usr/bin/env Rscript

# Reads database and outputs feather files with all classified proteins for the
# latest ss_versions for NCBI:NR.

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(feather))
suppressPackageStartupMessages(library(readr))

# Connect and define table source
db = src_postgres('pfitmap-eval-prod')

domain_hits = collect(
  tbl(db, 'hmm_profiles') %>% 
    filter(rank == 'domain') %>%
    select(
      hmm_profile_id = id, hmm_profile_name = name,
      hmm_profile_version = version, hmm_profile_length = length
    ) %>%
    inner_join(
      tbl(db, 'hmm_results') %>%
        select(hmm_result_id = id, hmm_profile_id, sequence_source_id),
      by = 'hmm_profile_id'
    ) %>%
  inner_join(
    tbl(db, 'sequence_sources') %>%
      select(
        sequence_source_id = id, ss_source = source,
        ss_name = name, ss_version = version
      ),
    by = 'sequence_source_id'
  ) %>%
  inner_join(
    tbl(db, 'hmm_result_rows') %>%
      select(hmm_result_row_id = id, hmm_result_id, e_value, score),
    by='hmm_result_id'
  ) %>%
  inner_join(
    tbl(db, 'hmm_result_row_sequences') %>% select(-id),
    by='hmm_result_row_id'
  ) %>%
  inner_join(
    tbl(db, 'sequences') %>%
      select(sequence_id = id, db, accno),
    by='sequence_id'
  ) %>%
  inner_join(
    tbl(db, 'align_length') %>% select(hmm_result_row_id, align_length = length),
    by='hmm_result_row_id'
  ) %>%
  transmute(
    ss_source, ss_name, ss_version, accno, db,
    hmm_profile_name, hmm_profile_version, hmm_profile_length, 
    score, e_value, align_length, prop_matching = (as.numeric(align_length)/as.numeric(hmm_profile_length))
  ),
  n = Inf
)

write_feather(domain_hits, 'domain_hits.feather')

# Since feather is a bit unstable, also write to tsv
write_tsv(domain_hits, 'domain_hits.tsv')
