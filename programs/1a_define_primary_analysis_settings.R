#------------------------------------------------------------------------------#
#     TITLE: Settings for creation of primary tasp analysis datasets
#      DATE: 2017NOV03
#    AUTHOR: B. Saul
#      DESC: 
# CHANGELOG:
#------------------------------------------------------------------------------#

# Variable Settings
key_vars <- c("record_id", "time")
preprocessFUN <-function(x) {
  x %>% 
    dplyr::mutate(
      time = case_when(
        redcap_event_name == "pretreatment_arm_1"      ~ 0,
        redcap_event_name == "day_0_arm_1"             ~ 1,
        redcap_event_name == "day_5_arm_1"             ~ 2,
        redcap_event_name == "final_fasting_day_arm_1" ~ 3,
        redcap_event_name == "refeed_day_3_arm_1"      ~ 4,
        redcap_event_name == "posttreatment_arm_1"     ~ 5)
    ) %>%
    dplyr::select(-redcap_event_name)
}

#------------------------------------------------------------------------------#
# Define data integrity checks ####
# TODO: these could could be consolidated
#------------------------------------------------------------------------------#

flq_check_include_1 <- function(data, retrieval_date){
  if(any(data$food_liking_questionnaire_complete != 2) ){
    records <- data %>% filter(food_liking_questionnaire_complete != 2) %>%
      select(record_id, time)
    
    write_check_to_file(
      "Food liking questionnaire has incomplete forms",
      records, 
      "Review these records. If they are complete, set the form status to 'complete'.",
      retrieval_date)
  }
}

flq_check_exclude_1 <- function(data, retrieval_date){
  if( (all(is.na(data[ , -(1:2)]))) ){
    
    write_check_to_file(
      "Food liking questionnaire has where there should be none",
      records = NULL,
      "Check that that FLQ observations from pretreatment or posttreatment do not contain data",
      retrieval_date)
  }
}

dtrt_check_include_1 <- function(data, retrieval_date){
  if(any(data$detection_recognition_assays_complete != 2) ){
    records <- data %>% filter(detection_recognition_assays_complete != 2) %>%
      select(record_id, time)
    
    write_check_to_file(
      "DTRT has incomplete forms",
      records, 
      "Review these records. If they are complete, set the form status to 'complete'.",
      retrieval_date)
  }
}

dtrt_check_exclude_1 <- function(data, retrieval_date){
  if( (all(is.na(data[ , -(1:2)]))) ){
    
    write_check_to_file(
      "DTRT has data where there should be none",
      records = NULL,
      "Check that that DTRT observations from pretreatment or posttreatment do not contain data",
      retrieval_date)
  }
}


supra_check_include_1 <- function(data, retrieval_date){
  if(any(data$suprathreshold_assays_complete != 2) ){
    records <- data %>% filter(suprathreshold_assays_complete != 2) %>%
      select(record_id, time)
    
    write_check_to_file(
      "Suprathreshold has incomplete forms",
      records, 
      "Review these records. If they are complete, set the form status to 'complete'.",
      retrieval_date)
  }
}

supra_check_exclude_1 <- function(data, retrieval_date){
  if( (all(is.na(data[ , -(1:2)]))) ){
    
    write_check_to_file(
      "Suprathreshold data has where there should be none",
      records = NULL,
      "Check that that Suprathreshold observations from pretreatment or posttreatment do not contain data",
      retrieval_date)
  }
}


trt_check_include_1 <- function(data, retrieval_date){
  if(any(data$treatment_information_complete != 2) ){
    records <- data %>% filter(treatment_information_complete != 2) %>%
      select(record_id, time)
    
    write_check_to_file(
      "Treatment has incomplete forms",
      records, 
      "Review these records. If they are complete, set the form status to 'complete'.",
      retrieval_date)
  }
}

trt_check_exclude_1 <- function(data, retrieval_date){
  if( (all(is.na(data[ , -(1:2)]))) ){
    
    write_check_to_file(
      "Treatment data has where there should be none",
      records = NULL,
      "Check that that Treatment form observations from other than baseline do not contain data",
      retrieval_date)
  }
}

cln_check_include_1 <- function(data, retrieval_date){
  if(any(data$treatment_information_complete != 2) ){
    records <- data %>% filter(treatment_information_complete != 2) %>%
      select(record_id, time)
    
    write_check_to_file(
      "Clinical has incomplete forms",
      records, 
      "Review these records. If they are complete, set the form status to 'complete'.",
      retrieval_date)
  }
}

cln_check_exclude_1 <- function(data, retrieval_date){
  if( (all(is.na(data[ , -(1:2)]))) ){
    
    write_check_to_file(
      "Clinical data has where there should be none",
      records = NULL,
      "Check that that Clinical observations from pretreatment or posttreatment do not contain data",
      retrieval_date)
  }
}

#------------------------------------------------------------------------------#
# Define data settings ####
#------------------------------------------------------------------------------#


analysis_data_settings <- list(
  # Food liking questionnaire ####
  flq = list(
    description    = "A description",
    key_variables  = key_vars,
    keep_variables = 3:97,
    criteria       = quo(time %in% c(0,5)),
    checks         = list(
      
      # checks on included data 
      list(
        with      = "included",
        action       = flq_check_include_1
      ),
      
      # checks on excluded data
      list(
        with      = "excluded",
        action       = flq_check_exclude_1
      )),
    
    post_process  = function(x) {x %>% select(-contains("complete")) }),
  
  # Detection and recognition threshold ####
  dtrt = list(
    description = "A description",
    key_variables  = key_vars,
    keep_variables = 153:218,
    criteria       = quo(time %in% 1:4),
    checks         = list(
      list(
        with      = "included",
        action       = dtrt_check_include_1
      ),
      list(
        with      = "excluded",
        action       = dtrt_check_exclude_1
      )
    ),
    post_process  = function(x) {x %>% select(-contains("complete")) }),
  
  # Supra threshold ####
  supra = list(
    description = "A description",
    key_variables  = key_vars,
    keep_variables = 219:242,
    criteria       = quo(time %in% 1:4),
    checks         = list(
      list(
        with      = "included",
        action       = supra_check_include_1
      ),
      list(
        with      = "excluded",
        action       = supra_check_exclude_1
      )),
      post_process  = function(x) {x %>% select(-contains("complete")) %>%
          filter(randomization_id_st != "")}),
  
  # Treatment ####
  trt = list(
    description    = "A description",
    key_variables  = key_vars,
    keep_variables = 134:142,
    criteria       = quo(time == 1),
    checks         = list(
      list(
        with      = "included",
        action       = trt_check_include_1
      ), 
      list(
        with      = "excluded",
        action       = trt_check_exclude_1
      )),
     post_process  = function(x) {x %>% select(-contains("complete")) }),
  
  # Clinical ####
  cln =  list(
    description    = "A description",
    key_variables  = key_vars,
    keep_variables = 144:152,
    criteria       = quo(time %in% 1:4),
    checks         = list(
      list(
        with      = "included",
        action       = cln_check_include_1), 
      list(
        with      = "excluded",
        action       = cln_check_exclude_1)),
    post_process  = function(x) {x %>% select(-contains("complete")) })
)
