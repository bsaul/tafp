load("inst/raw_data/redcap_retrieval/tasp_retrieval_2017-10-20.rda")

## ToDo
# add post process capability for (e.g. removing variables)

all_data <- `tasp_retrieval_2017-10-20`$data

# Variable Settings
key_vars <- c("record_id", "redcap_event_name")
flq_vars <- 3:95
dtrt_vars <- 130:190

analysis_data_settings <- list(
  flq = list(
    data_name      = "flq",
    description    = "A description",
    key_variables  = key_vars,
    keep_variables = flq_vars,
    criteria       = quo(redcap_event_name %in% c("pretreatment_arm_1", "posttreatment_arm_1")),
    checks         = list(
      list(
        with      = "included",
        condition = function(x){ any(x$food_liking_questionnaire_complete != 2) },
        response  = quote(warning("FLQ has incomplete forms")),
        action    = function(x){print(x)}), 
      list(
        with      = "excluded",
        condition = function(x){!(all(is.na(x[ , -(1:2)])))},
        response  = quote(warning("Food liking questionnaire has responses where there should be none")),
        action    = function(x){print(x[ , -(1:2)])}))),
  dtrt = list(
    data_name   = "dtrt",
    description = "A description",
    key_variables  = key_vars,
    keep_variables = dtrt_vars,
    criteria       = quo(redcap_event_name %in% c("pretreatment_arm_1", "posttreatment_arm_1")),
    checks         = list(
      list(
        with      = "included",
        condition = function(x){ any(x$detection_recognition_assays_complete != 2) },
        response  = quote(warning("Detection and Recognition has incomplete forms")),
        action    = function(x){print(x)}), 
      list(
        with      = "excluded",
        condition = function(x){!(all(is.na(x[ , -(1:2)])))},
        response  = quote(warning("Detection and Recognition has responses where there should be none")),
        action    = function(x){print(x[ , -(1:2)])})
    ))
)


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
  
  out_data 
}



#### flq = Food Liking questionnair
create_analysis_data_frame(all_data, analysis_data_settings$flq)

# create long flq dataset
flq <- create_flq_dataset(all_data, key_vars, flq_vars)

flq_long <- flq %>%
  dplyr::select(-gender_flq, -diet_flq) %>%
  tidyr::gather(key = "variable", value = "response", 
                -record_id, -redcap_event_name) %>%
  dplyr::mutate(
    part = substr(variable, 2, 2),
    question = stringr::str_extract(variable, "q.*") %>% stringr::str_replace("q", "")
  )

#### dtrt = recognition and detection Liking questionnaire
create_analysis_data_frame(all_data, analysis_data_settings$dtrt)


# start <- all_data %>%
#   dplyr::select(key_vars, dtrt_vars)
# 
# # dtrt should not be completed at 2 timepoints: pre and post treatment
# include <- start %>%  
#   dplyr::filter(!(redcap_event_name %in% c("pretreatment_arm_1", "posttreatment_arm_1")))
# 
# if(any(include$detection_recognition_assays_complete != 2)){
#   warning("Detection and Recognition has incomplete forms")
# }
# 
# include <- include %>%
#   select(-contains("complet"))
# 
# # Check for responses after pretreatment and before posttreatment
# exclude <- start %>%
#   dplyr::filter(redcap_event_name %in% c("pretreatment_arm_1", "posttreatment_arm_1"))
# 
# if(!(all(is.na(exclude[ , -(1:2)])))){
#   warning("Detection and Recognition has responses where there should be none")
# }
