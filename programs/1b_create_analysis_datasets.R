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
    dplyr::select(-gender_flq, -diet_flq, -contains("date"), -age_flq) %>%
    tidyr::gather(key = "variable", value = "response", 
                  -record_id, -time) %>%
    dplyr::mutate(
      part = substr(variable, 2, 2),
      question = stringr::str_extract(variable, "q.*") %>% stringr::str_replace("q", "")
    ) %>%
    dplyr::arrange(
      record_id, time
    )
  
  # create long dtrt dataset ####
  dtrt_long_blind <- dtrt %>% 
    dplyr::select(-contains("comment"), -contains("date")) %>%
    tidyr::gather(key = "variable", value = "response", 
                  -record_id, -randomization_id_rtdt, -time) %>%
    dplyr::mutate(
      variable2      = stringr::str_replace(variable, "(_0.)$", ""),
      variable_name  = stringr::str_extract(variable, "(group|sample|recognition_taste)" ),
      taste_position = stringr::str_extract(variable, "0.$"),
      level          = as.integer(stringr::str_extract(variable2, "\\d+")),
      variable_name  = if_else(variable_name == "group", "chosen_cup_position", 
                               if_else(variable_name == "sample", "cup_id", variable_name))
    ) %>%
    dplyr::select(-variable, -variable2) %>%
    dplyr::arrange(record_id, time, taste_position, level, variable_name) %>%
    
    tidyr::unite(temp, record_id, time,
                 randomization_id_rtdt, taste_position, level, sep = ":::") %>%
    dplyr::group_by(temp) %>%
    tidyr::spread(variable_name, response) %>%
    tidyr::separate(temp, sep = ":::",
                    into = c("record_id", "time", 
                             "randomization_id", "taste_position", "level")) %>%
    dplyr::mutate(
      taste_position = as.integer(taste_position) - 1,
      level          = as.integer(level),
      time           = as.integer(time),
      chosen_cup_position = chosen_cup_position + 1
    ) %>%
    dplyr::arrange(record_id, time, taste_position, level)
  
  # create long supra dataset ####
  supra_long_blind <- tasp_data_20171103$supra %>% 
    dplyr::select(-contains("comment"), -contains("date_st")) %>%
    dplyr::group_by(record_id, randomization_id_st, time) %>%
    tidyr::nest() %>%
    dplyr::mutate(
      data = purrr::map(data, 
      ~ .x %>% 
        tidyr::gather(key = "variable", value = "response") %>%
        dplyr::mutate(
          cup_order      = as.integer(stringr::str_extract(variable, "\\d")),
          taste_position = as.integer(stringr::str_extract(variable, "0.$")),
          variable       = if_else(grepl("taste", variable), "flavor_tasted", "response" )
        ) %>%
        dplyr::group_by(taste_position) %>%
        dplyr::mutate(
          flavor_tasted = max(response[variable == "flavor_tasted"])
        ) %>%
        dplyr::filter(
          variable == "response"
        ) %>%
        dplyr::select(-variable))
    ) %>%
    tidyr::unnest() %>%
    dplyr::select(randomization_id = randomization_id_st, everything())
  
})