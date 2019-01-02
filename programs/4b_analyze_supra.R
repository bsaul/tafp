#------------------------------------------------------------------------------#
#     TITLE: Analyze supra response
#      DATE: 2018SEP15
#    AUTHOR: B. Saul
#      DESC: 
# CHANGELOG:
#      TODO: 
#------------------------------------------------------------------------------#


# Sketching analysis of AUC
library(ggplot2)
ggplot(supra_auc, 
       aes(x = time, y = auc, group = record_id)) + 
  geom_point() + 
  geom_line() +
  facet_grid( ~ assay_taste)

lm(auc ~ -1 + assay_taste + factor(time):assay_taste, data = supra_auc) 

# Sketching analysis of untransformed data

ggplot(supra_analysis %>% mutate(id_time = paste(record_id, time, sep = "_")), 
       aes(x = conc, y = response, group = id_time, color = factor(time))) + 
  geom_point() + 
  geom_line() +
  facet_grid(assay_taste ~ .)


pre_post_supra <- supra_analysis %>%
  filter(time %in% c(1, 4)) %>%
  group_by(record_id, assay_taste, conc) %>%
  arrange(time) %>%
  summarise(pre_post_change = response[time == 4] - response[time == 1])
  
ggplot(pre_post_supra,
       aes(x = conc, y = pre_post_change)) + 
  geom_hline(yintercept = 0) + 
  geom_point(shape = 1) +
  geom_line(aes(group = record_id), alpha = .5) + 
  stat_smooth(se = FALSE) + 
  facet_grid(assay_taste ~ . ) + 
  theme_bw() + 
  ggtitle(
    "Pre-post change in suprathreshold for each conc"
  )

library(geepack)

hold <- geeglm(
  response ~ time + conc + I(conc^2),
  id   = record_id, 
  data = filter(supra_analysis, assay_taste == "nacl") %>% arrange(record_id)
)
summary(hold)

hold <- geeglm(
  response ~ time + conc + I(conc^2),
  id   = record_id, 
  data = filter(supra_analysis, assay_taste == "sucr") %>% arrange(record_id)
)
summary(hold)
