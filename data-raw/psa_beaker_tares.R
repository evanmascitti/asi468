## code to prepare `psa_beaker_tares` dataset goes here
library(magrittr)

obj_names <- list.files(path = "./data-raw/asi468_psa_beaker_tares/", pattern = '.csv', full.names = T) %>%
  purrr::map_chr(basename) %>%
  purrr::map_chr(stringr::str_extract, pattern = "\\d{4}-\\d{2}-\\d{2}")

psa_beaker_tare_dfs <- list.files(path = "./data-raw/asi468_psa_beaker_tares/", pattern = '.csv', full.names = T) %>%
  purrr::map(readr::read_csv) %>%
  purrr::set_names(nm = obj_names)


psa_beaker_tares <- purrr::map2(.x = psa_beaker_tare_dfs,
            .y = obj_names,
            .f = ~dplyr::mutate(., beaker_tare_set = .y)) %>%
  purrr::map(dplyr::relocate, beaker_tare_set, .before = dplyr::everything())



usethis::use_data(psa_beaker_tares, overwrite = TRUE)
