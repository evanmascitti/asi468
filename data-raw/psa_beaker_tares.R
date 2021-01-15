## code to prepare `psa_beaker_tares` dataset goes here

psa_beaker_tares <- list.files(path = '/inst/ext-data/psa_beaker_tares/',
                               pattern = '.csv') %>%
  purrr::map(readr::read_csv) %>%
  purrr::set_names()

usethis::use_data(psa_beaker_tares, overwrite = TRUE)
