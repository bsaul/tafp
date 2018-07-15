library(tasp)
library(ggplot2)
dt <- tasp_data("20180715")


temp <- dt$dtrt_long_unblind %>% 
  filter(!(randomization_id == "")) %>%
  group_by(randomization_id) %>%
  mutate(
    result = case_when(
      !chose_correct_taste & !chose_correct_cup ~ "wtwc",
      !chose_correct_taste &  chose_correct_cup ~ "wtcc",
       chose_correct_taste & !chose_correct_cup ~ "ctwc",
       chose_correct_taste &  chose_correct_cup ~ "ctcc"
    )
  )


ggplot(temp, 
       aes(x = level, y = -time,
           group = time,
           color = result, 
           shape = result)) +
  geom_line(color = "gray90") + 
  geom_point() + 
  geom_hline(yintercept = 0) + 
  geom_vline(xintercept = 0) + 
  scale_shape_manual(values = c(16, 2, 6, 1)) + 
  scale_color_manual(values = c("#2b83ba", "#fdae61", "#abdda4", "#d7191c")) + 
  scale_y_continuous("Time", labels = c("", "4", "3", "2", "1", ""), expand = c(0, 0),
                     limits = c(-5, 0)) + 
  scale_x_continuous(breaks = c(1, 5, 10), expand = c(0, 0), limits = c(0, 11)) + 
  facet_grid(record_id ~ assay_taste) +
  theme_classic()


ggplot(temp, 
       aes(x = level, y = -time,
           group = time,
           color = chose_correct_taste)) +
  geom_line(color = "gray90") + 
  geom_point() + 
  geom_hline(yintercept = 0) + 
  geom_vline(xintercept = 0) + 
  # scale_shape_manual(values = c(16, 2, 6, 1)) + 
  scale_color_manual(values = c("#d7191c", "#2b83ba")) + 
  scale_y_continuous("Time", labels = c("", "4", "3", "2", "1", ""), expand = c(0, 0),
                     limits = c(-5, 0)) + 
  scale_x_continuous(breaks = c(1, 5, 10), expand = c(0, 0), limits = c(0, 11)) + 
  facet_grid(record_id ~ assay_taste) +
  theme_classic()


temp_supra <- dt$supra_long_unblind %>% 
  filter(!(randomization_id == "")) %>%
  group_by(randomization_id) 
temp_supra[is.na(temp_supra$conc), ]
ggplot(
  temp_supra,
  aes(x = conc,
      y = response,
      group = time,
      color = factor(time))
) +
  geom_point() + 
  geom_line() + 
  geom_hline(yintercept = -10) + 
  geom_vline(xintercept = -10) +
  scale_y_continuous(expand = c(0, 0)) + 
  scale_x_continuous(expand = c(0, 0)) + 
  facet_grid(record_id ~ assay_taste, scales = "free_x") +
  theme_classic()
