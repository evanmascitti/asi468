## code to prepare `stainless_bowl_tares` dataset goes here

library(magrittr)

stainless_bowl_tares <- list.files(path = './data-raw/stainless-bowl-tares/',
                         pattern = "\\.csv$", full.names = T) %>%
  purrr::map(readr::read_csv, col_types = 'cid') %>%
  dplyr::bind_rows()

usethis::use_data(stainless_bowl_tares, overwrite = TRUE)
