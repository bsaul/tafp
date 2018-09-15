#------------------------------------------------------------------------------#
#     TITLE: Create analysis dataset
#      DATE: 2018SEP15
#    AUTHOR: B. Saul
#      DESC: 
# CHANGELOG:
#      TODO: 
#------------------------------------------------------------------------------#

library(tasp)
dt <- tasp_data("20180915")

### Suprathreshold Analysis Datasets

supra_analysis <- dt$supra_long_unblind %>%
  group_by(record_id, time, taste_position, assay_taste) %>%
  arrange(conc)

# Area under response curve

compute_auc <- function(x, y){
  f <- splinefun(x = x, y = y, method = "natural")
  integrate(f, lower = 0, upper = 400)$value
}

supra_auc <- supra_analysis %>%
  summarise(auc = compute_auc(conc, response))


