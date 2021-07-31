# Export data to csv files 
library(tasp)

tasp_data_20190101 %>%
  purrr::iwalk(
    .f = ~ {
      write.csv(
        dplyr::ungroup(.x),
        file = sprintf("inst/data_export/%s_20190101.csv", .y),
        row.names = FALSE
      )
    }
  )

