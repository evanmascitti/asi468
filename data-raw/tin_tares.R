## code to prepare `tin_tares` dataset goes here
library(magrittr)

obj_names <- list.files(path = "inst/ext-data/asi468_tin_tares/", pattern = '.csv', full.names = T) %>%
  purrr::map_chr(basename) %>%
  purrr::map_chr(stringr::str_remove, pattern = "_tin_tares\\.csv$")

tin_tare_dfs <- list.files(path = "inst/ext-data/asi468_tin_tares/", pattern = '.csv', full.names = T) %>%
  purrr::map(readr::read_csv) %>%
  purrr::set_names(nm = obj_names)

tin_tares <- purrr::pmap(.l = list(
df = tin_tare_dfs,
ID = obj_names,
col_name = "tin_tare_set"),
.f = add_set_ID)

usethis::use_data(tin_tares, overwrite = TRUE)
