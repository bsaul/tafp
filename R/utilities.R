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


#------------------------------------------------------------------------------#
#' Get a tasp dataset
#'
#' @param intro_text some text
#' @param records some data
#' @param action_text some text
#' @param retrieval_date self-explanatory
#' 
#' @export
#' 
#------------------------------------------------------------------------------#

write_check_to_file <- function(intro_text, records= NULL, action_text = NULL, retrieval_date){
  outfile <- paste0("inst/retrieval_logs/", retrieval_date, "_log.txt")
  
  cat("=====================================================================\n",
      file = outfile, append = TRUE)
  cat(intro_text,  "\n\n",
      file = outfile, append = TRUE)
  
  if(!is.null(records)){
    write.table(records, row.names = FALSE, file = outfile, append = TRUE)
  }
  
  if(!is.null(action_text)){
    cat(action_text,  "\n\n",
        file = outfile, append = TRUE)
  }
  
  cat("=====================================================================\n",
      file = outfile, append = TRUE)
  
}