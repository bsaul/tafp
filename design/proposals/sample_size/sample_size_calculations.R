#------------------------------------------------------------------------------#
# Sample size calculations for TNHF taste adaptation study
#  Author: Bradley Saul
#    Date: 9/9/16
# Purpose: Compute sample size for taste adaptation study based on one sided 
# t-test.
#
#------------------------------------------------------------------------------#

library(ggplot2)
library(dplyr)

## Assume Normally distributed ##

ss_normal <- function(pre, post, sigma, alpha, power){
  power.t.test(delta = abs(post - pre), sd = sigma, sig.level = alpha, power = power, 
               type = 'paired', alternative = 'one.sided')
}

basis <- expand.grid(pre   = seq(8, 12, by = 0.1),
                     post  = seq(9, 13, by = 0.1),
                     alpha = c(0.05, 0.1, 0.15),
                     sigma = c(1, 1.5, 2),
                     power = c(.75, .85)) %>%
  mutate_(diff = ~ post - pre,
          grp  = ~paste0('(', alpha, ', ', power, ')' )) %>%
  filter_(~ post > pre, ~ diff > .5, ~diff < 1.5)

sample_sizes <- basis %>%
  rowwise() %>%
  mutate_(n    = ~ceiling(ss_normal(pre, post, sigma, alpha, power)[['n']]))


ggplot(sample_sizes, aes(x = diff, y = n, group = grp, color = grp)) +
  geom_line() + 
  # geom_hline(yintercept = c(40, 50, 60), color = 'gray50') + 
  scale_color_discrete("(Type I error, power)") + 
  scale_x_continuous('Post - Pre') + 
  scale_y_continuous('Sample size') + 
  coord_cartesian(ylim = c(0, 100)) +
  ggtitle('Sample sizes based on one-sided t-test') + 
  facet_grid(~sigma, labeller = label_bquote(cols = sigma == .(sigma)))






