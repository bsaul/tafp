

exdt1 <- gen_data(1, c(0, 0, 0), rho_d = 0)
p1 <- ggplot(exdt1, aes(y = y, x = c, 
                        group = idtx, 
                        color = t,
                        linetype = as.factor(x))) + 
  scale_y_continuous('gLMS') + 
  scale_x_continuous('Concentration', breaks = c(100, 200, 400)) + 
  scale_color_discrete('Taste', guide = FALSE) +
  scale_linetype_discrete('Time', labels = c('Before', 'After')) + 
  geom_point() + 
  geom_line() + 
  facet_grid(~ t) + 
  ggtitle('Randomly generated psychophysical curves for a single subject\n when no fasting effect exists for any taste') +
  theme(plot.title = element_text(size = 10))

exdt2 <- gen_data(1, c(1, 1, 0), rho_d = 0)
p2 <- ggplot(exdt2, aes(y = y, x = c, 
                        group = idtx, 
                        color = t,
                        linetype = as.factor(x))) + 
  scale_y_continuous('gLMS') + 
  scale_x_continuous('Concentration', breaks = c(100, 200, 400)) + 
  scale_color_discrete('Taste', guide = FALSE) +
  scale_linetype_discrete('', labels = c('Baseline', 'After 5 days fasting')) + 
  geom_point() + 
  geom_line() + 
  facet_grid(~ t) + 
  ggtitle('Randomly generated psychophysical curves for a single subject\n when fasting effect increases average gLMS for all tastes a and b') +
  theme(plot.title = element_text(size = 10),
        legend.position = c(.2, .8),
        legend.background = element_blank())


