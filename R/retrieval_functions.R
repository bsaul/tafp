#------------------------------------------------------------------------------#
#' Retrieve and save RedCap data
#'
#' @param token RedCap token
#' 
#' @export
#------------------------------------------------------------------------------#

retrieve_redcap_data <- function(token){
  today    <- format(Sys.Date(), "%Y%m%d")
  outname  <- paste0("tasp_retrieval_", today)
  x <- REDCapR::redcap_read(redcap_uri="https://redcap.fasting.org/redcap_v6.8.1/API/",
                   token=token)
  assign(outname, x)
  save(list = outname, file = paste0("inst/raw_data/redcap_retrieval/", outname, ".rda"))
}
