for(i in 1:44){
  rid <- paste0("R", formatC(i, width = 3, flag ="0"))
  rmarkdown::render("randomization/randomization_templates.Rmd",
                    output_file = paste0('templates/', rid, '.pdf' ),
                    params = list(rid = rid))
}
