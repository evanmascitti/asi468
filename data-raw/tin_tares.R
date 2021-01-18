## code to prepare `tin_tares` dataset goes here
library(magrittr)

obj_names <- list.files(path = "inst/ext-data/asi468_tin_tares/", pattern = '.csv', full.names = T) %>%
  purrr::map_chr(basename) %>%
  purrr::map_chr(stringr::str_sub, end = 10)

tin_tares <- list.files(path = "inst/ext-data/asi468_tin_tares/", pattern = '.csv', full.names = T) %>%
  purrr::map(readr::read_csv) %>%
  purrr::set_names(nm = obj_names)

usethis::use_data(tin_tares, overwrite = TRUE)
