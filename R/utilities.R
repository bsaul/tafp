#------------------------------------------------------------------------------#
#' Get a tasp dataset
#'
#' @param retrieval_date self-explanatory
#' 
#' @export
#' 
#------------------------------------------------------------------------------#

tasp_data <- function(retrieval_date){
  get(paste0("tasp_data_", retrieval_date))
}