#------------------------------------------------------------------------------#
#     TITLE: Unblind dtrt
#      DATE: 2017NOV03
#    AUTHOR: B. Saul
#      DESC: 
# CHANGELOG:
#      TODO: 
#------------------------------------------------------------------------------#


## Unblind dtrt

dtrt_key <- read.csv("design/randomization/rtdt_ids_2017-10-06.csv")
dtrt_key

tasp_data_20171103$dtrt_long_blind %>%
  left_join(dtrt_key, by = c("randomization_id", "time", "taste_position", "level",  "cup_id")) %>%
  dplyr::mutate(
    chose_correct = chosen_cup_position == cup_order
  ) %>%
  dplyr::select(
    record_id, time, randomization_id, taste_position, assay_taste, level, cup_id,
    chosen_cup_position, correct_cup_position = cup_order, chose_correct
  ) 

# %>%
#   filter(record_id %in% 5:6) %>%
#   View()
