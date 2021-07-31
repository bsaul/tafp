# 
# 
# 
# ## Detection/Recognition
# 
# 
# 
# ```{r dtrt_bydays}
# hold <- dtrt_plot %>%
#   filter(time %in% c(1, 4)) %>%
#   group_by(record_id, assay_taste, type) %>%
#   summarise(
#     rel_change = conc[time == 4]/conc[time == 1],
#     change = log(conc[time == 4]) - log(conc[time == 1]),
#     days   = max(days)
#   ) 
# 
# ggplot(
#   data = hold,
#   aes(x = days, y = change)
# ) + 
#   geom_point() + 
#   scale_y_continuous("Change in log(concentration)") + 
#   stat_smooth(method = "lm", se = FALSE) + 
#   facet_grid(assay_taste ~ type) + 
#   ggtitle(
#     "Pre-post change as function of days since start of fast"
#   )
# ```
# 
# ```{r dtrt_prepost}
# teststats <- dtrt_plot %>%
#   filter(time %in% c(1,4)) %>%
#   group_by(record_id, assay_taste, type) %>% 
#   select(-days) %>%
#   tidyr::spread(key = time, value = conc) %>%
#   group_by(assay_taste, type) %>%
#   summarise(
#     w = wilcox.test(x = `1`, y = `4`, paired = TRUE, exact = FALSE)$p.value,
#     t = t.test(x = `1`, y = `4`, paired = TRUE)$p.value,
#     label = sprintf("Paired Wilcoxon Rank Sum: %.3f\nPaired T: %.3f", w, t)
#   ) 
# 
# dtrt_prepost <- dtrt_plot %>%
#   filter(time %in% c(1,4)) %>%
#   group_by(record_id, assay_taste, type) %>%
#   summarise(change = conc[time == 4] - conc[time == 1]) 
# 
# ggplot(
#   dtrt_prepost,
#   aes(x = type, y = change)
# ) +
#   geom_hline(yintercept = 0) +
#   geom_boxplot() + 
#   geom_point(shape = 1) + 
#   geom_text(
#     data = teststats,
#     aes(x = type, y = -150, label = label),
#     size = 2 
#   ) + 
#   scale_x_discrete("") + 
#   facet_grid(~assay_taste) + 
#   theme_bw() + 
#   ggtitle("Paired Pre-post changes in detection (dt) and recognition (rt) thresholds for each subject by taste")
# 
# ```
# 
# ```{r, eval = FALSE}
# dtrt_analysis %>%
#   select(record_id, time,
#          chose_correct_cup,
#          chose_correct_taste, assay_taste,
#          conc, level) %>%
#   group_by(assay_taste, time, level) %>%
#   summarise(
#     dt = mean(chose_correct_cup),
#     rt = mean(chose_correct_taste)
#   ) %>%
#   tidyr::gather(key = test, value = value, -assay_taste, -time, -level) %>%
#   {
#     dt <- .
#     dt %>% 
#       filter(time == 1) %>% ungroup() %>%
#       select(-time) %>%
#       left_join(
#         dt %>% filter(time != 1),
#         by = c("assay_taste", "level", "test")
#       )
#   } %>%
#   mutate(
#     change = value.y/value.x
#   ) ->
#   dtrt_prop_dt
# 
# ggplot(
#   data = dtrt_prop_dt,
#   aes(x = level, y = value.y, color = factor(time), group = time)
# ) + 
#   # geom_hline(yintercept = 1) + 
#   geom_hline(yintercept = 0.5) + 
#   geom_line() + 
#   geom_line(
#     aes(x = level, y = value.x, group = time),
#     color = "black"
#   ) + 
#   facet_grid(test ~ assay_taste) +
#   ggtitle("Proportion of subjects correctly identifying cup (dt) or taste (rt)\nat concentration levels")
# ```
# 
# ### Models
# 
# These models are first passes getting at the question: does the probability of correct cup identification increase as a function of days after fasting after controlling for concentration (which is obviously associated).
# 
# #### NaCl DT
# 
# ```{r}
# library(lme4)
# m <- glmer(
#   chose_correct_cup ~ log(conc) + days + (1|record_id),
#   data = filter(dtrt_analysis, assay_taste == "nacl", level != 1),
#   family = binomial()
# )
# 
# summary(m)
# ```
# 
# #### NaCl RT
# 
# ```{r}
# m <- glmer(
#   chose_correct_taste ~ log(conc) + days + (1|record_id),
#   data = filter(dtrt_analysis, assay_taste == "nacl", level != 1),
#   family = binomial()
# )
# 
# summary(m)
# ```
# 
# #### Sucrose DT
# 
# 
# ```{r}
# m <- glmer(
#   chose_correct_cup ~ log(conc) + days + (1|record_id),
#   data = filter(dtrt_analysis, assay_taste == "sucr", level != 1),
#   family = binomial()
# )
# 
# summary(m)
# ```
# 
# #### Sucrose RT
# 
# 
# ```{r}
# m <- glmer(
#   chose_correct_taste ~ log(conc) + days + (1|record_id),
#   data = filter(dtrt_analysis, assay_taste == "sucr", level != 1),
#   family = binomial()
# )
# 
# summary(m)
# ```