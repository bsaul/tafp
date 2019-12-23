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

study_subjects_dtrt <- 
  dt$dtrt_long_unblind %>%
  distinct(record_id, time) %>%
  group_by(record_id) %>%
  filter(sum(time == 1) == 1 & sum(time == 4) == 1) %>%
  distinct(record_id) %>% arrange(record_id) %>%
  pull(record_id) %>% as.integer() %>% sort()


study_subjects_supra <- 
  dt$supra_long_unblind %>% 
  ungroup() %>%
  distinct(record_id, time) %>%
  group_by(record_id) %>%
  filter(sum(time == 1) == 1 & sum(time == 4) == 1) %>%
  distinct(record_id) %>% arrange(record_id) %>%
  pull(record_id)

if(!identical(study_subjects_dtrt, study_subjects_supra)){
  stop("subjects should match")
}

study_subjects <- study_subjects_dtrt

## Get demographics from FLQ ####
demographics <- 
  dt$flq %>%
  filter(record_id %in% study_subjects, time == 0) %>%
  select(record_id, age = age_flq, gender = gender_flq, diet = diet_flq) %>%
  # TODO: what are the codings?
  mutate(
    gender = factor(gender),
    diet   = factor(diet)
  )
## study date/times ####
# Probably should have done this in the derive_long_datasets file...
supra_datetime <- 
  dt$supra %>%
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

dtrt_datetime <- 
  dt$dtrt %>%  
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
supra_analysis <- 
  dt$supra_long_unblind %>%
  filter(record_id %in% study_subjects) %>%
  group_by(record_id, time, taste_position, assay_taste) %>%
  arrange(conc) %>%
  left_join(supra_datetime, by = c("record_id", "time", "taste_position")) %>%
  left_join(demographics, by = "record_id")


# Area under response curve

compute_auc <- function(x, y){
  f <- splinefun(x = x, y = y, method = "natural")
  integrate(f, lower = 0, upper = 400)$value
}

supra_auc <- supra_analysis %>%
  summarise(auc = compute_auc(conc, response))

## DTRT Datasets ####

dtrt_analysis <- 
  dt$dtrt_long_unblind %>%
  filter(record_id %in% as.character(study_subjects)) %>%
  mutate(
    # See record_id == 12 at time == 2
    chose_correct_taste = if_else(is.na(recognition_taste), FALSE, chose_correct_taste)
  ) %>%
  left_join(
    ungroup(dtrt_datetime) %>% mutate(record_id = as.character(record_id)), 
    by = c("record_id", "time", "taste_order")
  ) %>%
  left_join(
    demographics %>% mutate(record_id = as.character(record_id)),
    by = "record_id"
  )

dtrt_thresholds <- 
  dtrt_analysis %>%
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

## Food-Liking Scoring ####

foodliking <-
  dt$flq %>%
  filter(record_id %in% study_subjects) %>%
  select(record_id, time, matches("^p")) %>%
  # the following codings are taken from FLQ_script.R derived by Andrew Beauchesne
  mutate(
    #first-order model for liking for salt
    salt_flq = 
     (p2_q1a*0.622*5/3 +
      p2_q5a*0.759*5/3 + 
      p2_q6a*0.777*5/3 + 
      p2_q8a*0.798*5/3 + 
      p4_q5*0.491 + 
      p4_q6*0.398 + 
      p4_q11*0.332 + 
      p4_q12*0.807*5/3 + 
      p4_q14*0.796*5/3 +
      p4_q17*0.687*5/3 + 
      p4_q18*0.793*5/3)/11 ,
    #first-order model for liking for sweet
    #liking scores were computed for factors F2 through F6
    #overall liking score was computed by averaging compounding factors
    
    sweet_flq = 
      ((p3_q1___4*0.431 +
        p3_q1___5*0.431 + 
        p3_q1___6*0.431 + 
        p1_q22*0.493 + 
        p1_q24*0.692 + 
        p1_q25*0.78 + 
        p1_q28*0.448 + 
        p1_q29*0.627 + 
        p3_q1___0*0.431 + 
        p3_q1___3*0.431 + 
        p3_q1___2*0.431 +
        p3_q1___1*0.431)/12 + 
                   
      ( p1_q22*0.573 +
        p1_q23*0.702 + 
        p1_q26*0.658 +
        p1_q27*0.657)/4 + 
                   
      (p4_q3*0.851 + 
        p4_q23*0.725*5/3 + 
        p4_q24*0.791*5/3)/3 + 
                   
      (p2_q12a*0.66*5/3 + 
        p2_q15a*0.556*5/3 + 
        p2_q16a*0.715*5/3 + 
        p4_q10*0.42)/4 + 
                   
      (p2_q14a*0.658*5/3 +
        p4_q2*0.441 + 
        p4_q19*0.726*5/3 + 
        p4_q21*0.659*5/3)/4 ) /5 ,
    
    #first-order model for liking for fat and salt
    #liking scores were computed for factors F7 through F11
    #overall liking score was computed by averaging compounding factors
    
    fatsalt_flq = (
      (p1_q4*0.777 + 
       p1_q5*0.739 +
       p1_q6*0.732 + 
       p1_q7*0.777 +
       p1_q8*0.661 +
       p1_q9*0.55 +
       p1_q10*0.661 + 
       p1_q15*0.55) / 8 +
                      
      (p2_q2a*0.603*5/3 + 
       p2_q3a*0.628*5/3 +
       p2_q4a*0.693*5/3 + 
       p2_q7a*0.559*5/3 + 
       p2_q9a*0.492*5/3 +
       p2_q10a*0.484*5/3 +
       p2_q11a*0.58*5/3 + 
       p4_q1*0.516 + 
       p4_q13*0.496*5/3 + 
       p4_q15*0.71*5/3 + 
       p4_q16*0.681*5/3)/11 +
                      
      (p1_q17*0.624 + 
       p1_q18*0.807 + 
       p1_q19*0.808 + 
       p1_q20*0.717)/4 + 
                      
      (p1_q11*0.464 + 
       p1_q12*0.495 + 
       p1_q13*0.838 + 
       p1_q14*0.79 + 
       p1_q16*0.509)/5 +
      
      (p1_q1*0.803 + 
       p1_q2*0.813 + 
       p1_q3*0.734)/3) / 5,
    
    #first-order model for liking for fat and sweet
    #liking scores were computed for factors F12 through F15
    #overall liking score was computed by averaging compounding factors
    
    fatsweet_flq = (
      (p1_q30*0.433 +
       p1_q31*0.849 +
       p1_q35*0.469 + 
       p1_q36*0.528 + 
       p1_q37*0.536 +
       p1_q38*0.835 + 
       p1_q40*0.665 +
       p1_q41*0.654)/8 +
                       
      (p2_q17a*0.761*5/3 +
       p2_q18a*0.635*5/3 +
       p2_q19a*0.787*5/3 + 
       p4_q7*0.854 +
       p4_q20*0.811*5/3)/5 +
                       
      (p1_q32*0.834 +
       p2_q13a*0.816*5/3 + 
       p4_q9*0.654 + 
       p4_q22*0.635*5/3)/4 +
                       
      (p1_q33*0.925 +
       p1_q34*0.795 + 
       p1_q39*0.925)/3) / 4
    
  ) %>%
  select(
    record_id, time, ends_with("flq")
  )
