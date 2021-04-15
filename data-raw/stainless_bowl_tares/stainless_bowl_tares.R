## code to prepare `stainless_bowl_tares` dataset goes here

library(magrittr)

stainless_bowl_tares <- list.files(path = './data-raw/stainless-bowl-tares/',
                         pattern = "\\.csv$", full.names = T) %>%
  purrr::set_names(stringr::str_extract(basename(.), '\\d{4}-\\d{2}-\\d{2}')) %>%
  purrr::map(readr::read_csv, col_types = 'cid')

usethis::use_data(stainless_bowl_tares, overwrite = TRUE)
