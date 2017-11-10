#------------------------------------------------------------------------------#
#     TITLE: Unblind dtrt
#      DATE: 2017NOV03
#    AUTHOR: B. Saul
#      DESC: 
# CHANGELOG:
#      TODO: 
#------------------------------------------------------------------------------#


## Unblind dtrt ####

dtrt_key <- read.csv("design/randomization/rtdt_ids_2017-10-06.csv",
                     stringsAsFactors = FALSE) %>%
  dplyr::select(everything(), is_taste_position = taste_position) %>%
  dplyr::group_by(randomization_id, time) %>%
  dplyr::mutate(taste_order = rep(1:2, each = n()/2))

assign(out_data_name, within(get(out_data_name), {
  dtrt_long_unblind <- dtrt_long_blind %>%
    left_join(
      dtrt_key, 
      by = c("randomization_id", "time", "taste_order", "level",  "cup_id")
    ) %>%
    dplyr::mutate(
      chose_correct_cup = chosen_cup_position == cup_order,
      cup_taste         = if_else(grepl("h2o", cup_taste), "none", cup_taste),
      chose_correct_taste = cup_taste == recognition_taste
    ) %>%
    dplyr::select(
      record_id, time, randomization_id, taste_order, assay_taste, level, conc, 
      cup_id, cup_taste, chosen_cup_position, correct_cup_position = cup_order, 
      chose_correct_cup, recognition_taste, chose_correct_taste
    ) 
}))


## Unblind supra ####

supra_key <- read.csv("design/randomization/supra_ids_2017-10-06.csv",
                      stringsAsFactors = FALSE) %>%
  dplyr::group_by(randomization_id, time) %>%
  dplyr::mutate(
    taste_position = rep(1:2, each = 4)
  ) %>%
  dplyr::select(-assay)

assign(out_data_name, within(get(out_data_name), {
  
  supra_long_unblind <- supra_long_blind %>%
    left_join(supra_key, by = c("randomization_id", "time", "taste_position", "cup_order")) %>%
    dplyr::mutate(
      tasted_correct = recognition_taste == assay_taste
    ) %>% 
    dplyr::group_by(record_id, randomization_id, taste_position) %>%
    dplyr::mutate(
      conc_rank     = rank(conc),
      response_rank = rank(response),
      rank_match    = conc_rank == response_rank 
    ) 
}))
