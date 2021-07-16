## code to prepare `pvc_perc_cylinders` dataset goes here


library(magrittr)

pvc_perc_cylinders <- list.files(path = './data-raw/pvc-perc-cylinders/',
                                   pattern = "\\.csv$", full.names = T) %>%
  purrr::map(readr::read_csv, col_types = 'cidddd', na = "-") %>%
  dplyr::bind_rows()


usethis::use_data(pvc_perc_cylinders, overwrite = TRUE)
