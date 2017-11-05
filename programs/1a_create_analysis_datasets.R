#------------------------------------------------------------------------------#
#     TITLE: Creation of prelimary tasp datasets
#      DATE: 2017NOV03
#    AUTHOR: B. Saul
#      DESC: 
# CHANGELOG:
#      TODO: add post process capability for (e.g. removing variables)
#------------------------------------------------------------------------------#

retrieval_date <- "20171103"
in_data_name  <- paste0("tasp_retrieval_", retrieval_date)
out_data_name <- paste0("tasp_data_", retrieval_date)

load(paste0("inst/raw_data/redcap_retrieval/", in_data_name, ".rda"))

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

analysis_data_settings <- list(
  # Food liking questionnaire ####
  flq = list(
    description    = "A description",
    key_variables  = key_vars,
    keep_variables = 3:96,
    criteria       = quo(time %in% c(0,5)),
    checks         = list(
      list(
        with      = "included",
        condition = function(x){ any(x$food_liking_questionnaire_complete != 2) },
        response  = quote(warning("FLQ has incomplete forms")),
        action    = function(x){invisible(x)}), 
      list(
        with      = "excluded",
        condition = function(x){!(all(is.na(x[ , -(1:2)])))},
        response  = quote(warning("Food liking questionnaire has responses where there should be none")),
        action    = function(x){invisible(x)})),
    post_process  = function(x) {x %>% select(-contains("complete")) }),
  
  # Detection and recognition threshold ####
  dtrt = list(
    description = "A description",
    key_variables  = key_vars,
    keep_variables = 149:214,
    criteria       = quo(time %in% 1:4),
    checks         = list(
      list(
        with      = "included",
        condition = function(x){ any(x$detection_recognition_assays_complete != 2) },
        response  = quote(warning("Detection and Recognition has incomplete forms")),
        action    = function(x){invisible(x)}), 
      list(
        with      = "excluded",
        condition = function(x){!(all(is.na(x[ , -(1:2)])))},
        response  = quote(warning("Detection and Recognition has responses where there should be none")),
        action    = function(x){invisible(x)})
    ),
    post_process  = function(x) {x %>% select(-contains("complete")) }),
  
  # Supra threshold ####
  supra = list(
    description = "A description",
    key_variables  = key_vars,
    keep_variables = 215:230,
    criteria       = quo(time %in% 1:4),
    checks         = list(
      list(
        with      = "included",
        condition = function(x){ any(x$suprathreshold_assays_complete != 2) },
        response  = quote(warning("Supra has incomplete forms")),
        action    = function(x){print(x)}), 
      list(
        with      = "excluded",
        condition = function(x){!(all(is.na(x[ , -(1:2)])))},
        response  = quote(warning("Supra has responses where there should be none")),
        action    = function(x){print(x[ , -(1:2)])})),
      post_process  = function(x) {x %>% select(-contains("complete")) }),
  
  # Treatment ####
  trt = list(
    description    = "A description",
    key_variables  = key_vars,
    keep_variables = 132:139,
    criteria       = quo(time == 1),
    checks         = list(
      list(
        with      = "included",
        condition = function(x){ any(x$treatment_information_complete != 2) },
        response  = quote(warning("Treatment has incomplete forms")),
        action    = function(x){print(x)}), 
      list(
        with      = "excluded",
        condition = function(x){!(all(is.na(x[ , -(1:2)])))},
        response  = quote(warning("Treatment has responses where there should be none")),
        action    = function(x){print(x[ , -(1:2)])})),
     post_process  = function(x) {x %>% select(-contains("complete")) }),
  
  # Clinical ####
  cln =  list(
    description    = "A description",
    key_variables  = key_vars,
    keep_variables = 140:148,
    criteria       = quo(time %in% 1:4),
    checks         = list(
      list(
        with      = "included",
        condition = function(x){ any(x$clinical_complete != 2) },
        response  = quote(warning("Clinical has incomplete forms")),
        action    = function(x){print(x)}), 
      list(
        with      = "excluded",
        condition = function(x){!(all(is.na(x[ , -(1:2)])))},
        response  = quote(warning("Clinical has responses where there should be none")),
        action    = function(x){print(x[ , -(1:2)])})),
    post_process  = function(x) {x %>% select(-contains("complete")) })
)


#
# Create datasets ####
#

create_analysis_data_frame(get(in_data_name) %>% .$data, analysis_data_settings$trt, preprocessFUN)

assign(out_data_name, lapply(analysis_data_settings, function(settings) {
  create_analysis_data_frame(get(in_data_name) %>% .$data, settings, preprocessFUN)
}))

save(list = c(out_data_name), file = paste0("data/", out_data_name, ".rda"))
rm(in_data_name, out_data_name, key_vars, analysis_data_settings)
