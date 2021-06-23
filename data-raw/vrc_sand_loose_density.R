## code to prepare `vrc_sand_loose_density` dataset goes here

library(magrittr)

tsp_vol <- readr::read_csv("./data-raw/mini-sand-cone-method/teaspoon-volume-calibration.csv",
                           col_types = 'idd') %>%
  dplyr::left_join(soiltestr::h2o_properties_w_temp_c, by = 'water_temp_c') %>%
  dplyr::mutate(tsp_vol = water_mass / water_density_Mg_m3) %>%
  dplyr::summarize(tsp_vol = mean(tsp_vol)) %>%
  purrr::pluck("tsp_vol")

vrc_sand_loose_density <- readr::read_csv("./data-raw/mini-sand-cone-method/sand_loose_density_calibration.csv",
                                          col_types = 'id') %>%
  dplyr::summarize(sand_density = mean(sand_mass) / tsp_vol) %>%
  purrr::pluck("sand_density", 1) %>%
  signif(digits = 3)



usethis::use_data(vrc_sand_loose_density, overwrite = TRUE)
