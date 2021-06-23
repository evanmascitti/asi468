## code to prepare `psa_beaker_tares` dataset goes here
library(magrittr)

psa_beaker_tares <- list.files(path = "./data-raw/asi468_psa_beaker_tares/", pattern = '.csv', full.names = T) %>%
  purrr::map(readr::read_csv, col_types = 'cid') %>%
  dplyr::bind_rows()

usethis::use_data(psa_beaker_tares, overwrite = TRUE)
