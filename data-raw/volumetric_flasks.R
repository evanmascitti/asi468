## code to prepare `volumetric_flasks` dataset goes here


library(magrittr)

bottle_raw_data <- list.files(
  path = './data-raw/volumetric_flasks/',
  pattern = '\\.csv$',
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
  dplyr::mutate(bottle_vol = (water_filled_mass - bottle_empty_mass) / water_density_Mg_m3) %>%
  dplyr::group_by(bottle_set, bottle_number) %>%
  dplyr::summarise(
    dplyr::across(
      .cols = c(bottle_vol, bottle_empty_mass),
      .fns = ~round(mean(.), digits = 3)),
    .groups = 'drop')

usethis::use_data(volumetric_flasks, overwrite = TRUE)
