
#' Convert to atbl
#'
#' @param .x Data to be converted
#' @return An atbl (attribute data frame)
#' @export
as_atbl <- function(.x) UseMethod("as_atbl")

#' @export
as_atbl.data.frame <- function(.x) {
  #if (!identical(row.names(.x), as.character(1:nrow(.x)))) {
  #  attr(.x, "row_names") <- row.names(.x)
  #}
  .x <- tibble::as_data_frame(.x)
  atbl(.x)
}

as_atbl.atbl <- function(.x) {
  .x <- tibble::as_data_frame(.x)
  atbl(.x)
}


#' @export
as_atbl.list <- function(.x) {
  .x <- as_tbl(.x)
  atbl(.x)
}
