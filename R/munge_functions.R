#------------------------------------------------------------------------------#
#' Munge and save RedCap data
#'
#' @param input_data self-explanatory
#' @param settings list of settings
#' 
#' @export
#' 
#------------------------------------------------------------------------------#

create_analysis_data_frame <- function(input_data, settings){
  # 1. Select variables
  basis_data <- input_data %>%
    dplyr::select(settings$key_variables, settings$keep_variables)
  
  # 2. Apply criteria filter
  basis_data %>% 
    dplyr::filter(!!settings$criteria) ->
    out_data
  
  excluded_data <- basis_data %>%
    dplyr::filter(!(!!settings$criteria))
  
  # 3. Apply checks
  lapply(settings$checks, function(check) {
    data_to_check <- if(check$with == "included") out_data else excluded_data
    if(check$condition(data_to_check)){
      eval(check$action(data_to_check))
      eval(check$response)
    }
  })
  
  ## TODO: set attributes
  if(!is.null(settings$post_process)){
    settings$post_process(out_data) 
  } else {
    out_data
  }
}