#------------------------------------------------------------------------------#
#     TITLE: Analyze dtrt response
#      DATE: 20190101
#    AUTHOR: B. Saul
#      DESC: 
# CHANGELOG:
#      TODO: 
#------------------------------------------------------------------------------#


plot_dt <- dtrt_thresholds %>% ungroup() %>%
  select(-dtp, -rtp, -taste_order) %>%
  tidyr::gather(key = "type", value = "conc", -record_id, -time, -assay_taste)

ggplot(
  data = plot_dt,
  aes(x = time, y = conc, group = record_id)
) + geom_point(shape = 1) +
  geom_line(alpha = .5) + 
  facet_grid(assay_taste + type ~ ., scales = "free_y") + 
  theme_bw()

plot_dt2 <- plot_dt %>%
  filter(time %in% c(1,4)) %>%
  group_by(record_id, assay_taste, type)%>%
  summarise(change = conc[time == 4] - conc[time == 1])

ggplot(
  plot_dt2,
  aes(x = type, y = change)
) + 
  geom_hline(yintercept = 0) +
  geom_point(shape = 1) + 
  facet_grid(~assay_taste) + 
  theme_bw() + 
  ggtitle("pre-post change in detection (dt) and recognition (rt) thresholds for each subject by taste")
