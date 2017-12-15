library(tasp)
library(ggplot2)
dt <- tasp_data("20171215")


temp <- dt$dtrt_long_unblind %>% 
  filter(!(randomization_id == "")) %>%
  group_by(randomization_id) 

tastes <- c(1 = )

ggplot(temp, 
       aes(x = level, y = conc, color = chose_correct_cup, shape = chose_correct_taste)) + 
  geom_point() + 
  scale_shape_manual(values = c(1, 16)) + 
  facet_grid(randomization_id + time + assay_taste ~ .)
