load("inst/raw_data/redcap_retrieval/tasp_retrieval_2017-10-20.rda")

all_data <- `tasp_retrieval_2017-10-20`$data


# Variable Settings
key_vars <- c("record_id", "redcap_event_name")
flq_vars <- 3:95
dtrt_vars <- 130:190

analysis_data_settings <- list()

#### flq = Food Liking questionnair

# create food liking dataset
create_flq_dataset <- function(all_data, key_vars, dataset_vars){
  start <- all_data %>%
    dplyr::select(key_vars, dataset_vars)
  
  # FLQ should only be completed at 2 timepoints: pre and post treatment
  include <- start %>%  
    dplyr::filter(redcap_event_name %in% c("pretreatment_arm_1", "posttreatment_arm_1")) 
  
  if(any(include$food_liking_questionnaire_complete != 2)){
    warning("FLQ has incomplete forms")
  }
  
  include <- include %>%
    select(-food_liking_questionnaire_complete, -p2_example)
  
  # Check for responses after pretreatment and before posttreatment
  exclude <- start %>%
    dplyr::filter(!(redcap_event_name %in% c("pretreatment_arm_1", "posttreatment_arm_1")))
  
  if(!(all(is.na(exclude[ , -(1:2)])))){
    warning("Food liking questionnaire has responses where there should be none")
  }
  
  return(include)
}

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

start <- all_data %>%
  dplyr::select(key_vars, dtrt_vars)

# dtrt should not be completed at 2 timepoints: pre and post treatment
include <- start %>%  
  dplyr::filter(!(redcap_event_name %in% c("pretreatment_arm_1", "posttreatment_arm_1")))

if(any(include$detection_recognition_assays_complete != 2)){
  warning("Detection and Recognition has incomplete forms")
}

include <- include %>%
  select(-detection_recognition_assays_complete)

# Check for responses after pretreatment and before posttreatment
exclude <- start %>%
  dplyr::filter(redcap_event_name %in% c("pretreatment_arm_1", "posttreatment_arm_1"))

if(!(all(is.na(exclude[ , -(1:2)])))){
  warning("Detection and Recognition has responses where there should be none")
}
