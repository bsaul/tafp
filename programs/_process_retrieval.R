#------------------------------------------------------------------------------#
#     TITLE: Access data from REDCap
#      DATE: 2017SEP29
#    AUTHOR: B. Saul
#      DESC:
# CHANGELOG:
#------------------------------------------------------------------------------#

library(tasp)
## Retrieve from RedCap
retrieve_redcap_data()

## Create primary datasets
retrieval_date <- "20180715"
in_data_name   <- paste0("tasp_retrieval_", retrieval_date)
out_data_name  <- paste0("tasp_data_", retrieval_date)

load(paste0("inst/raw_data/redcap_retrieval/", in_data_name, ".rda"))

## HARDCODES ##

# Subject 13 uses randomization ID at time 4
# tasp_retrieval_20180715$data[tasp_retrieval_20180715$data$record_id == 13 & 
#                              tasp_retrieval_20180715$data$redcap_event_name == "refeed_day_3_arm_1"  ]
# 

## Create primary datasets
source("programs/1a_define_primary_analysis_settings.R")
assign(out_data_name, lapply(analysis_data_settings, function(settings) {
  create_analysis_data_frame(
    input_data     = get(in_data_name) %>% .$data, 
    settings       = settings, 
    preprocess     = preprocessFUN,
    retrieval_date = retrieval_date)
}))

## Create long versions of primary datasets
source("programs/1b_derive_long_datasets.R")

## Create unblinded versions of dtrt and supra datasets
source("programs/2a_unblind_dtrt_supra_datasets.R")

## Checks for mismatches

dtrt_unmatched <- get(out_data_name)$dtrt_long_unblind %>%
  filter(is.na(assay_taste)) %>%
  select(record_id, time, randomization_id, taste_order, cup_id, level)

write_check_to_file(
  "The following DTRT cup IDs do not match a cup ID in the randomization schedule",
  dtrt_unmatched,
  retrieval_date = retrieval_date)

dtrt_possible <- dtrt_key %>%
  right_join(select(dtrt_unmatched, randomization_id, time, taste_order, level)) %>%
  select(randomization_id, time, level, cup_id)

write_check_to_file(
  "The following DTRT cup IDs are the possible cup IDs according to the randomization schedule",
  dtrt_possible,
  retrieval_date = retrieval_date)


supra_unmatched <- get(out_data_name)$supra_long_unblind %>%
  filter(is.na(assay_taste)) %>% ungroup() %>% 
  select(record_id, time, randomization_id, cup_id, cup_order)

write_check_to_file(
  "The following supra cup IDs do not match a cup ID in the randomization schedule",
  supra_unmatched,
  retrieval_date = retrieval_date)

supra_possible <- supra_key %>%
  right_join(select(supra_unmatched, randomization_id, time, cup_order)) %>%
  select(randomization_id, time, cup_id)

write_check_to_file(
  "The following supra cup IDs are the possible cup IDs according to the randomization schedule",
  supra_possible,
  retrieval_date = retrieval_date)

## Save and clean up
save(list = c(out_data_name), file = paste0("data/", out_data_name, ".rda"))
rm(list = ls())
devtools::install()
