#------------------------------------------------------------------------------#
#     TITLE: Creation of tasp analysis datasets
#      DATE: 2017NOV03
#    AUTHOR: B. Saul
#      DESC: 
# CHANGELOG:
#      TODO: 
#------------------------------------------------------------------------------#


tasp_data_20171103 <- within(tasp_data_20171103, {
  # create long flq dataset ####
  flq_long <- flq %>%
    dplyr::select(-gender_flq, -diet_flq, -date_flq, -age_flq) %>%
    tidyr::gather(key = "variable", value = "response", 
                  -record_id, -redcap_event_name) %>%
    dplyr::mutate(
      part = substr(variable, 2, 2),
      question = stringr::str_extract(variable, "q.*") %>% stringr::str_replace("q", "")
    ) %>%
    dplyr::arrange(
      record_id, redcap_event_name
    )
  
  # create long dtrt dataset ####
  dtrt_long_blind <- dtrt %>% 
    dplyr::mutate(
      time = case_when(
        redcap_event_name == "day_0_arm_1" ~ 1,
        redcap_event_name == "day_5_arm_1" ~ 2,
        redcap_event_name == "final_fasting_day_arm_1" ~ 3,
        redcap_event_name == "refeed_day_3_arm_1" ~ 4)
    ) %>%
    dplyr::select(-contains("comment"), -date_01, -date_02) %>%
    tidyr::gather(key = "variable", value = "response", 
                  -record_id, -redcap_event_name, -randomization_id_rtdt, -time) %>%
    dplyr::mutate(
      variable2      = stringr::str_replace(variable, "(_0.)$", ""),
      variable_name  = stringr::str_extract(variable, "(group|sample|recognition_taste)" ),
      taste_position = stringr::str_extract(variable, "0.$"),
      level          = as.integer(stringr::str_extract(variable2, "\\d+")),
      variable_name  = if_else(variable_name == "group", "chosen_cup_position", 
                               if_else(variable_name == "sample", "cup_id", variable_name))
    ) %>%
    dplyr::select(-variable, -variable2) %>%
    dplyr::arrange(record_id, redcap_event_name, taste_position, level, variable_name) %>%
    
    tidyr::unite(temp, record_id, redcap_event_name, time,
                 randomization_id_rtdt, taste_position, level, sep = ":::") %>%
    dplyr::group_by(temp) %>%
    # dplyr::mutate(id = 1:n()) %>%
    tidyr::spread(variable_name, response) %>%
    tidyr::separate(temp, sep = ":::",
                    into = c("record_id", "redcap_event_name", "time", 
                             "randomization_id", "taste_position", "level")) %>%
    dplyr::mutate(
      taste_position = as.integer(taste_position) - 1,
      level          = as.integer(level),
      time           = as.integer(time),
      chosen_cup_position = chosen_cup_position + 1
    ) %>%
    dplyr::arrange(record_id, redcap_event_name, taste_position, level)
})





