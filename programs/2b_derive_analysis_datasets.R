#------------------------------------------------------------------------------#
#     TITLE: Unblind supra
#      DATE: 2017NOV05
#    AUTHOR: B. Saul
#      DESC: 
# CHANGELOG:
#      TODO: 
#------------------------------------------------------------------------------#


## Unblind supra

supra_key <- read.csv("design/randomization/supra_ids_2017-10-06.csv",
                     stringsAsFactors = FALSE) %>%
  dplyr::group_by(randomization_id, time) %>%
  dplyr::mutate(
    taste_position = rep(1:2, each = 4)
  ) %>%
  dplyr::select(-assay)


tasp_data_20171103$supra_long_unblind <- tasp_data_20171103$supra_long_blind %>%
  left_join(supra_key, by = c("randomization_id", "time", "taste_position", "cup_order")) %>%
  dplyr::mutate(
    tasted_correct = recognition_taste == assay_taste
  )

tasp_data_20171103$supra_long_unblind %>% 
  dplyr::group_by(record_id, randomization_id, taste_position) %>%
  dplyr::mutate(
    conc_rank     = rank(conc),
    response_rank = rank(response),
    rank_match    = conc_rank == response_rank 
  ) %>%
  dplyr::filter(randomization_id != "")

# %>% View()
#   write.csv(file = "supra_test.csv")
