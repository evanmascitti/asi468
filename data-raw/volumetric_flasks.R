## code to prepare `volumetric_flasks` dataset goes here


library(magrittr)

bottle_raw_data <- list.files(
  path = './data-raw/volumetric_flasks/',
  pattern = 'volumetric-flasks-calibration-data_\\d{4}-\\d{2}-\\d{2}\\.csv$',
  full.names = TRUE) %>%
  readr::read_csv(col_types = readr::cols(
    bottle_set = readr::col_character()),
    na = "-",
    lazy = FALSE)


# calculate the volume of the bottle using the known density of water and water mass, then take
# the average of the 3 measurements as the representative value which will be used
# in the actual specific gravity tests from here forward


volumetric_flasks <- bottle_raw_data %>%
  dplyr::left_join(soiltestr::h2o_properties_w_temp_c, by = 'water_temp_c') %>%
  dplyr::mutate(bottle_vol = (water_filled_mass - empty_bottle_mass) / water_density_Mg_m3) %>%
  dplyr::group_by(bottle_set, bottle_number) %>%
  dplyr::summarise(bottle_vol = mean(bottle_vol),
                   empty_bottle_mass = mean(empty_bottle_mass),
                   .groups = 'drop') %>%
  dplyr::mutate(
    dplyr::across(.cols = c(bottle_vol, empty_bottle_mass),
                  .fns = round, digits = 3)
  )


usethis::use_data(volumetric_flasks, overwrite = TRUE)
