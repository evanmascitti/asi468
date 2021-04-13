#' Helper function for generating lists of equipment with corresponding IDs and
#' column names
#'
#' @param df data frame of item numbers and massor other property
#' @param ID the character string to add as the unique identifier
#' @param col_name quoted string to use for the ID column. For example,
#'   `tin_tare_set`
#'
#' @return a data frame with the ID appended (i.e. a new column with the ID
#'   value recycled as an entry for each row)
#'
add_set_ID <- function(df, ID, col_name){


  df[[col_name]] <- ID

  df %>%
    dplyr::relocate(col_name,
                    .before = dplyr::everything())

 }
