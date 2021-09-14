## code to prepare `proctor_molds` dataset goes here


# these calibrations didn't use actual degassed water....just some
# that had been sitting at room temperature and pressure for a while. I have in my notes that this water is about 0.11% i.e. 0.0011 air by mass. Therefore I apply a correction to account for the slightly low density of the water compared to deaired water at the same temperature.


library(magrittr)

# read raw data files

raw_data <- list.files(
  path = './data-raw/proctor-molds/',
  pattern = "\\.csv$", full.names = T) %>%
  purrr::map(readr::read_csv, col_types = 'ididdc', na = "-", lazy = FALSE) %>%
  dplyr::bind_rows() %>%
  dplyr::left_join(soiltestr::h2o_properties_w_temp_c, by = 'water_temp_c')


# compute relevant properties, including correction for air content of water

proctor_molds <- raw_data %>%
  dplyr::mutate(
    water_vol = water_mass / (water_density_Mg_m3 * (1-0.0011) )
  ) %>%
  dplyr::group_by(mold_ID) %>%
  dplyr::summarise(
    mold_vol_cm3 = mean(water_vol, na.rm = TRUE),
    empty_mold_mass_g = mean(mold_mass, na.rm = TRUE)
  )

# write to disk
usethis::use_data(proctor_molds, overwrite = TRUE)
