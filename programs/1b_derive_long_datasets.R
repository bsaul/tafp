#------------------------------------------------------------------------------#
#     TITLE: Derive long versions of primary tasp analysis datasets
#      DATE: 2017NOV03
#    AUTHOR: B. Saul
#      DESC: 
# CHANGELOG:
#      TODO: 
#------------------------------------------------------------------------------#

assign(out_data_name,  within(get(out_data_name), {
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
      taste_order    = stringr::str_extract(variable, "0.$"),
      level          = as.integer(stringr::str_extract(variable2, "\\d+")),
      variable_name  = if_else(variable_name == "group", "chosen_cup_position", 
                               if_else(variable_name == "sample", "cup_id", variable_name))
    ) %>%
    dplyr::select(-variable, -variable2) %>%
    dplyr::arrange(record_id, time, taste_order, level, variable_name) %>%
    
    tidyr::unite(temp, record_id, time,
                 randomization_id_rtdt, taste_order, level, sep = ":::") %>%
    dplyr::group_by(temp) %>%
    tidyr::spread(variable_name, response) %>%
    tidyr::separate(temp, sep = ":::",
                    into = c("record_id", "time", 
                             "randomization_id", "taste_order", "level")) %>%
    dplyr::mutate(
      taste_order    = as.integer(taste_order),
      level          = as.integer(level),
      time           = as.integer(time),
      chosen_cup_position = chosen_cup_position + 1,
      recognition_taste = case_when(
        recognition_taste == 1 ~ "nacl",
        recognition_taste == 2 ~ "sucr",
        recognition_taste == 3 ~ "bitt",
        recognition_taste == 4 ~ "sour",
        recognition_taste == 5 ~ "uman",
        recognition_taste == 6 ~ "fatt",
        recognition_taste == 7 ~ "none"
      )
    ) %>%
    dplyr::arrange(record_id, time, taste_order, level)
  
  # create long supra dataset ####
  supra_long_blind <- supra %>% 
    dplyr::select(-contains("comment"), -contains("date_st")) %>%
    dplyr::group_by(record_id, randomization_id_st, time) %>%
    tidyr::nest() %>%
    dplyr::mutate(
      data = purrr::map(data, 
          ~ .x %>% 
            tidyr::gather(key = "variable", value = "response")   %>%
            dplyr::mutate(
              cup_order      = as.integer(stringr::str_extract(variable, "\\d")),
              is_cup_id      = stringr::str_detect(variable, "_cup_id") * 1,
              variable       = gsub("_cup_id", "", variable),
              taste_position = as.integer(stringr::str_extract(variable, "0.$")),
              variable       = if_else(grepl("taste", variable), "recognition_taste", "response" ),
              variable       = if_else(is_cup_id == 1, "cup_id", variable)
            ) %>%
            dplyr::select(-is_cup_id) %>%
            dplyr::group_by(taste_position) %>%
            dplyr::mutate(
              recognition_taste = max(response[variable == "recognition_taste"]),
              recognition_taste = case_when(
                recognition_taste == 1 ~ "nacl",
                recognition_taste == 2 ~ "sucr",
                recognition_taste == 3 ~ "bitt",
                recognition_taste == 4 ~ "sour",
                recognition_taste == 5 ~ "uman",
                recognition_taste == 6 ~ "fatt",
                recognition_taste == 7 ~ "none"
              ),
            ) %>%
            dplyr::filter(variable != "recognition_taste") %>%
            tidyr::spread(variable, response) %>%
            dplyr::arrange(taste_position, cup_order))
    ) %>%
    tidyr::unnest() %>%
    dplyr::select(randomization_id = randomization_id_st, everything())
} )) 

