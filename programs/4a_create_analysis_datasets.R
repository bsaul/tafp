#------------------------------------------------------------------------------#
#     TITLE: Create analysis dataset
#      DATE: 2018SEP15
#    AUTHOR: B. Saul
#      DESC: 
# CHANGELOG:
#      TODO: 
#------------------------------------------------------------------------------#

library(tasp)
dt <- tasp_data("20190101")

### Subset to subjects who completed study (have both Day 0 and refeed day 3)

study_subjects_dtrt <- dt$dtrt_long_unblind %>%
  distinct(record_id, time) %>%
  group_by(record_id) %>%
  filter(sum(time == 1) == 1 & sum(time == 4) == 1) %>%
  distinct(record_id) %>% arrange(record_id) %>%
  pull(record_id) %>% as.integer() %>% sort()


study_subjects_supra<- dt$supra_long_unblind %>% ungroup() %>%
  distinct(record_id, time) %>%
  group_by(record_id) %>%
  filter(sum(time == 1) == 1 & sum(time == 4) == 1) %>%
  distinct(record_id) %>% arrange(record_id) %>%
  pull(record_id)

if(!identical(study_subjects_dtrt, study_subjects_supra)){
  stop("subjects should match")
}

study_subjects <- study_subjects_dtrt


## study date/times ####
# Probably should have done this in the derive_long_datasets file...


supra_datetime <- dt$supra %>%
  filter(record_id %in% study_subjects) %>%
  select(record_id, time, contains("date")) %>%
  tidyr::gather("taste_position", "datetime", -record_id, -time) %>%
  group_by(record_id) %>%
  arrange(record_id, time, taste_position) %>%
  mutate(
    taste_position = as.integer(stringr::str_extract(taste_position, "0.$")),
    date = lubridate::ymd(substr(datetime, 1, 10)),
    hour = lubridate::hour(datetime),
    days = as.integer(date - min(date))
  ) %>%
  select(-datetime, -date)

dtrt_datetime <- dt$dtrt %>%  
  filter(record_id %in% study_subjects) %>%
  select(record_id, time, contains("date")) %>%
  tidyr::gather("taste_order", "datetime", -record_id, -time) %>%
  group_by(record_id) %>%
  arrange(record_id, time, taste_order) %>%
  mutate(
    taste_order = as.integer(stringr::str_extract(taste_order, "0.$")),
    date = lubridate::ymd(substr(datetime, 1, 10)),
    hour = lubridate::hour(datetime),
    days = as.integer(date - min(date))
  ) %>%
  select(-datetime, -date)



## Suprathreshold Analysis Datasets ####

supra_analysis <- dt$supra_long_unblind %>%
  filter(record_id %in% study_subjects) %>%
  group_by(record_id, time, taste_position, assay_taste) %>%
  arrange(conc) %>%
  left_join(supra_datetime, by = c("record_id", "time", "taste_position"))


# Area under response curve

compute_auc <- function(x, y){
  f <- splinefun(x = x, y = y, method = "natural")
  integrate(f, lower = 0, upper = 400)$value
}

supra_auc <- supra_analysis %>%
  summarise(auc = compute_auc(conc, response))

## DTRT Datasets ####

dtrt_analysis <- dt$dtrt_long_unblind %>%
  filter(record_id %in% as.character(study_subjects)) %>%
  mutate(
    # See record_id == 12 at time == 2
    chose_correct_taste = if_else(is.na(recognition_taste), FALSE, chose_correct_taste)
  )%>%
  left_join(
    ungroup(dtrt_datetime) %>% mutate(record_id = as.character(record_id)), 
    by = c("record_id", "time", "taste_order")
  )

dtrt_thresholds <- dtrt_analysis %>%
  group_by(record_id, time, days, taste_order, assay_taste) %>%
  summarise(
    dtp      = case_when(
      sum(chose_correct_cup)  == 10 ~ 1L,
      sum(!chose_correct_cup) == 10 ~ 10L,
      # Workaround for the fact that case_when tries to evaluate the RHS
      TRUE ~ if(sum(chose_correct_cup)== 10 || sum(!chose_correct_cup)  == 10) {
        NA_integer_
      } else { 
          as.integer(max(which(!chose_correct_cup))) 
      }
    ),
    dt  =  case_when(
      dtp == 1L  ~ min(conc),
      dtp == 10L ~ max(conc),
      TRUE       ~ exp(mean(log(c(conc[dtp], conc[dtp + 1]))))
    ),
    rtp      = case_when(
      sum(chose_correct_taste) == 10  ~ 1L,
      sum(!chose_correct_taste) == 10 ~ 10L,
      TRUE ~ if(sum(chose_correct_taste) == 10 || sum(!chose_correct_taste)  == 10) {
        NA_integer_
      } else {
        as.integer(max(which(!chose_correct_taste)))
      }
    ),
    rt  =  case_when(
      rtp == 1L  ~ min(conc),
      rtp == 10L ~ max(conc),
      TRUE       ~ exp(mean(log(c(conc[rtp], conc[rtp + 1]))))
    )
  ) 

## Clinical data ####

clinical <- dt$cln %>%
  filter(record_id %in% study_subjects) 

# ## Treamtent data ###
# dt$trt %>%
#   filter(record_id %in% study_subjects) 
