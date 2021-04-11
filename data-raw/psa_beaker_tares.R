## code to prepare `psa_beaker_tares` dataset goes here
library(magrittr)

obj_names <- list.files(path = "inst/ext-data/asi468_psa_beaker_tares/", pattern = '.csv', full.names = T) %>%
  purrr::map_chr(basename) %>%
  purrr::map_chr(stringr::str_sub, end = 10)

psa_beaker_tare_dfs <- list.files(path = "inst/ext-data/asi468_psa_beaker_tares/", pattern = '.csv', full.names = T) %>%
  purrr::map(readr::read_csv) %>%
  purrr::set_names(nm = obj_names)

psa_beaker_tares <- purrr::pmap(.l = list(
  df = psa_beaker_tare_dfs,
  ID = obj_names,
  col_name = "beaker_tare_set"),
  .f = add_set_ID)

usethis::use_data(psa_beaker_tares, overwrite = TRUE)
