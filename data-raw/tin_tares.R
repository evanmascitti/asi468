## code to prepare `tin_tares` dataset goes here
library(magrittr)

tin_tares <- list.files(path = "./data-raw/tin_tares/", pattern = '.csv', full.names = T) %>%
  purrr::map(readr::read_csv, col_types = 'cid') %>%
  dplyr::bind_rows()

cat("First rows of `tin_tares` tibble:")

head(tin_tares)

usethis::use_data(tin_tares, overwrite = TRUE)
