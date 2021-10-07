## code to prepare `lowry_pipettes` dataset goes here

library(magrittr)

pipettes_raw_data <- list.files(
  path = './data-raw/lowry-pipettes/',
  pattern = 'lowry-pipettes-calibration-data_\\d{4}-\\d{2}-\\d{2}\\.csv$',
  full.names = TRUE) %>%
  readr::read_csv(col_types = readr::cols(
    lowry_pipette_set = readr::col_character()),
    na = "-",
    lazy = FALSE)

lowry_pipettes <- pipettes_raw_data %>%
  dplyr::left_join(soiltestr::h2o_properties_w_temp_c, by = 'water_temp_c') %>%
  dplyr::mutate(pipette_vol_cm3  = water_mass / (1 / water_density_Mg_m3)) %>%
  dplyr::group_by(lowry_pipette_set, pipette_number) %>%
  dplyr::summarise(
    dplyr::across(.cols = pipette_vol_cm3,
                  .fns = ~round(mean(.), digits = 3)),
    .groups = 'drop'
  )

usethis::use_data(lowry_pipettes, overwrite = TRUE)
