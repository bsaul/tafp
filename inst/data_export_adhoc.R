# 20210731 - Export for Toshia of patients who completed end of fast visit.
source("programs/4a_create_analysis_datasets.R")

supra_analysis %>% 
  group_by(record_id) %>% 
  filter(any(time == 3)) %>%
  write.csv(
    file = "inst/data_export/supra_analysis_completed_endoffast_visit.csv"
  )

dtrt_analysis %>%
  group_by(record_id) %>% 
  filter(any(time == 3)) %>%distinct(record_id)
  write.csv(
    file = "inst/data_export/dtrt_analysis_completed_endoffast_visit.csv"
  )

