#------------------------------------------------------------------------------#
#' Retrieve and save RedCap data
#'
#' 
#------------------------------------------------------------------------------#

retrieve_redcap_data <- function(token){
  today    <- Sys.Date()
  all_data <- redcap_read(redcap_uri="https://redcap.fasting.org/redcap_v6.8.1/API/",
                          token=token)
  
  save(all_data, file = paste0("inst/raw_data/redcap_retrieval/tasp_all_data_", today, ".rda"))
}
