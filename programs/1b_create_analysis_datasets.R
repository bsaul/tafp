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
  # dtrt %>%
  #   dplyr::select(-contains("comment"), -date_01, -date_02) %>%
  #   tidyr::gather(key = "variable", value = "response", 
  #                 -record_id, -redcap_event_name, -randomization_id_rtdt) %>%
  #   dplyr::mutate(
  #     part = substr(variable, 2, 2),
  #     question = stringr::str_extract(variable, "q.*") %>% stringr::str_replace("q", "")
  #   ) %>%
  #   dplyr::arrange(
  #     record_id, redcap_event_name
  #   )
  
})

tasp_data_20171103$dtrt %>% 
  dplyr::select(-contains("comment"), -date_01, -date_02) %>%
  tidyr::gather(key = "variable", value = "response", 
                -record_id, -redcap_event_name, -randomization_id_rtdt) %>%
  dplyr::mutate(
    variable2 = stringr::str_replace(variable, "(_0.)$", ""),
    taste_number = stringr::str_extract(variable, "0.$"),
    group_number = stringr::str_extract(variable2, "\\d")
  )
