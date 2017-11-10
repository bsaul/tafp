#------------------------------------------------------------------------------#
#     TITLE: Access data from REDCap
#      DATE: 2017SEP29
#    AUTHOR: B. Saul
#      DESC:
# CHANGELOG:
#------------------------------------------------------------------------------#

## Retrieve from RedCap
retrieve_redcap_data()

## Create primary datasets
retrieval_date <- "20171110"
in_data_name   <- paste0("tasp_retrieval_", retrieval_date)
out_data_name  <- paste0("tasp_data_", retrieval_date)

load(paste0("inst/raw_data/redcap_retrieval/", in_data_name, ".rda"))

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


save(list = c(out_data_name), file = paste0("data/", out_data_name, ".rda"))
rm(list = ls())
devtools::install()
