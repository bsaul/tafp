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
  summarise(pre_post_change = response[2] - response[1])
  
ggplot(pre_post_supra,
       aes(x = conc, y = pre_post_change, group = record_id)) + 
  geom_line() + 
  facet_grid(assay_taste ~ . )

library(geepack)

hold <- geeglm(
  response ~ time*conc + I(conc^2),
  id   = record_id, 
  data = filter(dt$supra_long_unblind, assay_taste == "nacl")
)
summary(hold)