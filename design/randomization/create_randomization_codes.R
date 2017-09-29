#------------------------------------------------------------------------------#
#   TITLE: TASP randomization codes
#  AUTHOR: Bradley Saul
#    DATE: 2017AUG29
# PURPOSE: Create randomization codes for blinding subjects and test 
#          administrators to taste order and cup order for TASP (taste 
#          adaptation study pilot)
#------------------------------------------------------------------------------#

library(permute)
library(readxl)
library(dplyr, quietly = TRUE)
library(tidyr, quietly = TRUE)

seed_rtdt  <- 707
seed_supra <- 919
# number of subjects (doubled to create extra codes in case of problems)
nsubjects <- 22 * 2 
# max number of timepoints a subject may be evaluated
timepoints <- 4 
# tastes being assayed 
tastes <- c('nacl', 'sucr')

#### Recognition and detection threshold assay (rtdt) 
# number of RTDT assay levels
nlevels_rtdt <- 10
# number of cups per assay level
ncups_rtdt <- 3

# Create matrix of possible positions for the taste
cupPos <- diag(1, nrow = ncups_rtdt, ncol = ncups_rtdt)

# Create permutation matrix of tastes
tastePerms <- allPerms(length(tastes), how(observed = TRUE)) %>%
  apply(1, function(x) tastes[x]) %>%
  t()

#### Suprathreshold assay (supra) 

conc_supra <- c(0, 100, 200, 400)
nlevels_supra <- length(conc_supra)
supraPerms <- allPerms(nlevels_supra, how(observed = TRUE)) %>%
  apply(1, function(x) conc_supra[x]) %>%
  t()

# Functions ####

randomize_rtdt_cup_order <- function(.nlevels = 10){
  ncups <- ncol(cupPos)
  cupPos[sample(1:ncups, .nlevels, replace = TRUE), ]
}

# randomize_rtdt_cup_order()

randomize_taste_order <- function(.times, .tastePerms){
  .tastePerms[sample(1:nrow(.tastePerms), .times, replace = TRUE), ]
}

select_rtdt_order <- function(.taste_order, .nlevels){
  ntimes <- nrow(.taste_order)
  ntaste <- ncol(.taste_order)
  ncups  <- ncol(cupPos)
  replicate(ntimes * ntaste, randomize_rtdt_cup_order(.nlevels), 
            simplify = FALSE) %>%
    lapply(function(x) c(t(x))) %>% 
    unlist() -> cup_positions

  data_frame(
    assay          = "rtdt",
    time           = rep(1:ntimes, each = .nlevels*ntaste*ncups),
    assay_taste    = rep(c(t(.taste_order)), each = .nlevels*ncups),
    level          = rep(rep(1:.nlevels, each = ncups), times = ntaste * ntimes),
    cup_order      = rep(1:ncups, times = .nlevels*ntimes*ntaste),
    taste_position = cup_positions)
}


randomize_supra_order <- function(.taste_order, .nlevels, .supraPerms){
  ntimes <- nrow(.taste_order)
  ntaste <- ncol(.taste_order)
  replicate(ntimes * ntaste, .supraPerms[sample(1:nrow(.supraPerms), 1), ], 
           simplify = FALSE) %>% unlist() -> conc

  data_frame(
    assay     = "supra",
    time      = rep(1:ntimes, each = .nlevels*ntaste),
    assay_taste = rep(c(t(.taste_order)), each = .nlevels),
    cup_order = rep(1:.nlevels, times = ntimes*ntaste),
    conc      = conc)
}

# randomize_taste_order(4, tastePerms) %>%
#   randomize_supra_order(nlevels_supra, supraPerms)

#### Read IDs ####

ids <- read_excel("randomization/Taste adaptation sample codes.xlsx") %>%
  mutate_(
    assay_taste =~ case_when(
      grepl("^sucrose", .$taste) ~ "sucr",
      grepl("^sodium chloride", .$taste) ~ "nacl"),
    cup_taste   =~ case_when(
      grepl("^sucrose$", .$taste) ~ "sucr",
      grepl("^sodium chloride$", .$taste) ~ "nacl",
      grepl("distilled 1$", .$taste) ~ "h2o_1",
      grepl("distilled 2$", .$taste) ~ "h2o_2"),
    time =~ case_when(
      time == "baseline" ~ 1,
      time == "day 5" ~ 2,
      time == "final fast" ~ 3,
      time == "refeed" ~ 4),
    assay =~ ifelse(assay == "st", "supra", assay)
  ) %>%
  select_(~ -taste) %>%
  group_by(assay, time, assay_taste, cup_taste) %>%
  mutate(
    level = 1:n()
  ) %>% ungroup()

#### Create datasets ####

## rtdt
set.seed(seed_rtdt)
lapply(1:nsubjects, function(i){
  randomize_taste_order(timepoints, tastePerms) %>%
    select_rtdt_order(.nlevels = nlevels_rtdt) %>%
    mutate(randomization_id = paste0("R", formatC(i, width = 3, flag ="0")))
}) %>% bind_rows() %>%
  select(randomization_id, everything()) ->
  rtdt

h2o_order <- function(cup_taste){
  ord <- sample(1:2, 2, replace = FALSE)
  cup_taste[cup_taste == "h2o"] <- paste0("h2o_", ord )
  cup_taste
}

# Merge on cup IDs
rtdt %>%
  # Add cup_taste variable for merging on IDs
  mutate_(
    cup_taste =~ ifelse(taste_position == 1, assay_taste, "h2o")
  ) %>%
  # Randomly label the H20 cups
  group_by(randomization_id, assay, time, assay_taste, level) %>%
  mutate_(
    cup_taste =~ h2o_order(cup_taste)
  ) %>% 
  left_join(ids %>% filter_(~assay == "dtrt") %>% select_(~ -assay),
            by = c("time", "assay_taste", "level", "cup_taste")) ->
  rtdt


## supra
set.seed(seed_supra)
lapply(1:nsubjects, function(i){
randomize_taste_order(timepoints, tastePerms) %>%
  randomize_supra_order(.nlevels = nlevels_supra, .supraPerms = supraPerms) %>%
  mutate(randomization_id = paste0("R", formatC(i, width = 3, flag ="0"))) 
}) %>% bind_rows() %>%
  select(randomization_id, everything()) ->
  supra

supra %>%
  left_join(ids %>% filter_(~assay == "supra") %>% 
              select_(~ -assay, ~-cup_taste, ~-level),
            by = c("time", "assay_taste", "conc")) ->
  supra

#### Output ####
write.csv(rtdt, file = paste0("randomization/rtdt_ids_", Sys.Date(), ".csv"), row.names = FALSE)
write.csv(supra, file = paste0("randomization/supra_ids_", Sys.Date(), ".csv"), row.names = FALSE)
