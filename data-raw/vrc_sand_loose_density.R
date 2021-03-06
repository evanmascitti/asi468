## code to prepare `vrc_sand_loose_density` dataset goes here

library(magrittr)

tsp_vol <- readr::read_csv("inst/ext-data/mini-sand-cone-method/teaspoon-volume-calibration.csv") %>%
  dplyr::left_join(soiltestr::h2o_properties_w_temp_c) %>%
  dplyr::mutate(tsp_vol = water_mass / water_density_Mg_m3) %>%
  dplyr::summarize(tsp_vol = mean(tsp_vol)) %>%
  purrr::pluck("tsp_vol")

vrc_sand_loose_density <- readr::read_csv("inst/ext-data/mini-sand-cone-method/sand_loose_density_calibration.csv") %>%
  dplyr::summarize(sand_density = mean(sand_mass) / tsp_vol) %>%
  purrr::pluck("sand_density", 1) %>%
  signif(digits = 3)



usethis::use_data(vrc_sand_loose_density, overwrite = TRUE)
